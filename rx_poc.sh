#!/bin/bash

# Add a header to your weather report
# header=$(echo -e "year\tmonth\tday\thour\tmin\tobs_temp(°)\tfc_temp(°)")
# echo $header>rx_poc.log

# Variables

city=Bucarest


# Extract weather info

curl -s wttr.in/$city?T --output weather_report


# To extract Current Temperature

# curl -s wttr.in/$city?T: This command uses curl to fetch weather information for the specified city from wttr.in, 
# including the temperature (?T parameter). The -s option makes curl operate in silent mode, suppressing unnecessary output.

# |: This is a pipe. It takes the output of the command on the left and uses it as input for the command on the right.

# grep -m 1 '°.': This grep command searches for the first occurrence (-m 1) of a line containing '°.' in the output. 
#  is a simple way to find a line that likely contains the temperature.

# grep -Eo -e '-?[[:digit:]].*': grep: This command is used for searching text using patterns.

    # -E: This option enables extended regular expressions (ERE). It allows for more complex pattern matching.

    # -o: This option tells grep to only output the matched parts of each line, rather than the entire line.

    # -e '-?[[:digit:]].*': This is the pattern that grep is searching for.

    # -?: This part of the pattern matches an optional hyphen (minus sign). 
    # The hyphen is optional because of the ? which means zero or one occurrences.

    # [[:digit:]]: This matches a single digit. The [[:digit:]] is a character class that represents any digit (0-9).

    # .*: This part of the pattern matches zero or more occurrences of any character (.), except for a newline. 
    # It essentially matches the rest of the line after the first digit.

# obs_temp=$(...): This syntax captures the output of the entire command sequence and stores it in the variable obs_temp.
# So, obs_temp now holds the extracted current temperature.

obs_temp=$(curl -s wttr.in/$city?T | grep -m 1 '°.' | cut -d '(' -f1 | grep -Eo -e '-?[[:digit:]].*')

echo "The current Temperature of $city: is $obs_temp °C"

# To extract the forecast temperature for noon tomorrow

fc_temp=$(curl -s wttr.in/$city?T | head -23 | tail -1 | grep '°.' | cut -d ')' -f2 | cut -d '(' -f1 | grep -Eo -e '-?[[:digit:]].*')
echo "The forecasted temperature for tomorrow noon for $city: is $fc_temp °C"

# Store the current hour, day, month, and year

    # TZ='Romania/Bucharest': Sets the timezone to Romania/Bucharest for the following date command.
    # date -u +%H: Prints the current hour in 24-hour format (00-23) using Coordinated Universal Time (UTC). 
    # The -u option ensures that the output is in UTC.

    # day=$(TZ='Romania/Bucharest' date -u +%d):
    # Similar to the hour command, this line captures the current day of the month in the variable day.

    # month=$(TZ='Romania/Bucharest' date +%m):
    # This line captures the current month in the variable month.
    # The -u option is not used here since the month is not affected by timezone.

    # year=$(TZ='Romania/Bucharest' date +%Y):
    # Similarly, this line captures the current year in the variable 'year'

TZ='Romania/Bucarest'

minutes=$(TZ='Romania/Bucharest' date -u +%M)
hour=$(TZ='Morocco/Casablanca' date -u +%H) 
day=$(TZ='Romania/Bucarest' date -u +%d) 
month=$(TZ='Romania/Bucarest' date +%m)
year=$(TZ='Romania/Bucarest' date +%Y)


# Merge the fields into a tab-delimited record, corresponding to a single row in Table 1

record=$(echo -e "$year\t$month\t$day\t$hour\t$minutes\t$obs_temp\t$fc_temp")
echo $record>>rx_poc.log



# Schedule your Bash script rx_poc.sh to run every day at noon local time

date

date -u

