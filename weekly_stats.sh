#!/bin/bash

# Add the last 7 accuracies to the txt.
echo $(tail -7 synthetic_historical_fc_accuracy.tsv  | cut -f6) > scratch.txt

week_fc=($(echo $(cat scratch.txt)))

# Validate, we show all the values in the txt.
# In this case, this solution is more suitable when you don't know the exact number of data in the txt or the quantity changes over time.

for ((i = 0; i < ${#week_fc[@]}; i++)); do
    echo ${week_fc[$i]}
done


for ((i = 0; i < ${#week_fc[@]}; i++)); do
  if [[ ${week_fc[$i]} < 0 ]]
  then
    week_fc[$i]=$(((-1)*week_fc[$i]))
  fi
  # validate result:
  echo ${week_fc[$i]}
done

# Initialice the minimum and maximun variables, and then compare each value of the array with the first one to check,
# which value is the highest or the lowest

minimum=${week_fc[0]}
maximum=${week_fc[0]}
for item in ${week_fc[@]}; do
   if [[ $minimum > $item ]]
   then
     minimum=$item
   fi
   if [[ $maximum < $item ]]
   then
     maximum=$item
   fi
done
echo "minimum ebsolute error = $minimum"
echo "maximum absolute error = $maximum"

