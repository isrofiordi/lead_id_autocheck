
# Lead_id Auto QA

This is a ruby script to process lead_id stats from two JSON files.

There are 2 scripts, one for the Hero project and another for WOLT.

## Before running the script, please make sure:
1. Ruby is installed (version 2 or higher is recommended)
2. The script and the two JSON files are in the same directory. (please also make sure there are no other .JSON files in the directory).

To run the script, use this command
```bash
ruby lead_id_autocheck_hero.rb
```
or
```bash
ruby lead_id_autocheck_wolt.rb
```

After the script finished its run, there will be two files:
1. result.txt (this will contain summary stats)
2. unique_lead_id_result.csv (contain a list of unique lead_id and its file origin)


