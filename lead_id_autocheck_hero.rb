# This program is used to compare id from two JSON file
# written in 30 Sept 2022
require 'json'
require 'csv'

=begin
-- DOCS --
input : 2 JSON File with lead_id

outputs: 
Total Lead IDs per file:
  1200 file-a.csv
  1230 file-b.csv
Match count: 1102

and also save the unique ones into another csv file, like for example
lead_id,file
123abc,file-a.csv
234ccc,file-a.csv
333afd,file-b.csv
=end

# parse the input
list_file = Dir["*.json"]
file_name_1 = list_file.first
file_name_2 = list_file.last
input_1 = File.open(file_name_1)
input_2 = File.open(file_name_2)
# input_1 = JSON.parse(File.read(file_name_1))
# input_2 = JSON.parse(File.read(file_name_2))

hash_1 = {}
hash_2 = {}

# input_1.each do |line|
#     key = line["lead_id"]
#     hash_1[key] = 1
# end

# input_2.each do |line|
#     key = line["lead_id"]
#     hash_2[key] = 1
# end

input_1.each do |line|
    json_line = JSON.parse(line)
    key = json_line["lead_id"]
    hash_1[key] = 1
end
input_1.close # Close the file to save memory

input_2.each do |line|
    json_line = JSON.parse(line)
    key = json_line["lead_id"]
    hash_2[key] = 1
end
input_2.close # Close the file to save memory

# Total lead IDs per file
total_1 = hash_1.size
total_2 = hash_2.size
puts "total lead_id in #{file_name_1} is #{total_1}"
puts "total lead_id in #{file_name_2} is #{total_2}"

# Match each lead IDs
total_match = 0
hash_1.each do |k1,v1|
    hash_2.each do |k2,v2|
        if k1 == k2
            total_match += 1
            hash_1[k1] += 1 # Increment the lead_id count
            hash_2[k2] += 1 # Increment the lead_id count
        end
    end
end

puts "The total match is #{total_match}"

# Save the report to a txt file
File.open("result.txt", "w") { 
    |f| f.write "Total Lead IDs per file:\n\t#{total_1} #{file_name_1}\n\t#{total_2} #{file_name_2}\nMatch count: #{total_match}" 
}

# Optional, could be skipped
unique_lead_id = hash_1.merge(hash_2).reject{|k,v| v > 1}
puts "The total unique lead_ids is #{unique_lead_id.size}"

# Save all the unique lead ids
CSV.open("unique_lead_id_result.csv", "w") do |csv|
    csv << ["lead_id", "file"] # header

    hash_1.each{|k,v| csv << [k,file_name_1] unless v > 1}
    hash_2.each{|k,v| csv << [k,file_name_2] unless v > 1}
end