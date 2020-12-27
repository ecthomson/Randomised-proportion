#This script takes goodfna files and randomises to 100 based on genotype
#It relies on an input file called proprand_infile.sh which is in /home2/HCV2/Uganda/Scripts
#It requires an input file called coordinates which must list the coordinates that are required- these MUST be separated by an underscore e.g. 203_255
#These coordinates MUST be in the name of the goodfna file which is generated with HCV GLUE
#Do NOT put any other junk, especially run files in the same folder
#Emma Thomson emma.thomson@glasgow.ac.uk 26th October 2020

cp /home2/HCV2/Uganda/Scripts/proprand_infile.sh .
while read coord; do sed "s/COORDINATES/$coord/g" proprand_infile.sh>proprand_$coord.sh; done <coordinates
rm -rf runlist.sh *randomised.all
while read coord; do echo proprand_$coord.sh >>runlist.sh; done <coordinates
sed -i 's/^/sh /g' runlist.sh
sh runlist.sh

