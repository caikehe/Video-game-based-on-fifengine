# This tool should print each actor followed by its actions
# Actors are located under objects/agents and are described by .xml files
# Running this script should print the following output:
#  bee: attack, fall, fly, get_hit, stand, 
#  tourist_male2: run, stand, talk, walk, 
#  tourist_female1: stand, talk, walk, 
#  chemist: experiment, read, repair, stand, talk, walk, 
#  tourist_male1: bend_down, stand, talk, walk, 
#  girl: run, stand, talk, walk, 
#  boy: cheer, kick, run, stand, talk, walk, 
#  beekeeper: stand, talk, walk, 
#  merchant: pray, run, stand, talk, 
#  hippie_priest: attack, cast_spell, fall, get_hit, read, run, stand, talk, walk, 
#  tourist_female2: stand, talk, walk,
#
# The actor id has to be followed by : and each action needs to be separated by 
# commas (the comma at the end of the line is not important)
#
# The tool is invoked with the root directory of the agents as first
# parameter. E.g., ./tools/actors_summary.sh objects/agents

# Put here your code
# This code should be excuted as (sh tools/actors_summary.sh objects/agents)# Becareful of the current directory when you are excuting this code

#!/bin/sh

Dirs=`ls -l --time-style="long-iso" $1 | egrep '^d' | awk '{print $8}'` 

# "ls -l $1": get a directory list
# "egrep '^d'": egrep and select only the directories
# "awk '{print $8}'": awk  and print only the 8th filed

for Dir in $Dirs
do 
    Dirfile=`ls -l "$1/$Dir" | egrep '.xml' | awk '{print $9}'`
    Dirfilefull="$1/$Dir/$Dirfile"
    var=$(cat $Dirfilefull | awk '/object blocking/ {print $3}' | cut -c 5- | sed -e "s/\"/\:/g")
    var1=$(cat $Dirfilefull | awk '/action id/ {print $2}' | cut -c 5- | sed -e "s/\">/\,/g") 
    echo $var $var1
done



  



