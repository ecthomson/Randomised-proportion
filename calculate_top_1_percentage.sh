#Solution for pulling out the variants present at >1% only
#Emma Thomson 26th June 2020
#Starting file must be of a similar input each time with no variation in delimiters

#This step pulls out the calculation from the abundance ratio (must be in the filename and must be in position 7 every time) and puts it in a temp file

rm -rf *calcu.sh *.include *.one *.tab *percent.sh *.include *.pasted *.good *.goodfna

#Need to put all the sequences and names onto a single line with a tab delimiter
for one in *.fna; do cat $one | awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}'>>$one.one; done
#Remove blank lines
sed -i '/^$/d' *.one
#Use paste to convert file to tab delimited
for a in *.one; do cat $a | paste - - >$a\.tab; done

#Pulls out the abundance information
for fna in *tab; do grep ">" $fna| cut -f 7 -d "_" > $fna.calcu.sh; done

#This inserts the formula into the start of the calc file
sed -i 's/^/echo \"scale\=3\; /g' *.calcu.sh

#This inserts the formula into the end of the calc file

sed -i 's/$/\*\(100\)\" \| bc >> percent/g' *.calcu.sh

#Need to rename each percent.sh file with the header from the calc.sh file
for calc in *calcu.sh; do sed -i "s/percent/"$calc"\.percent\.sh/g" $calc; done

#Run the calcu.sh files
for calcu in *.calcu.sh; do sh $calcu; done

#This creates a file to determine if the abundance is >1% and creates an output file called include
sed -i 's/^/expr /g' *percent.sh
#This is where the 1% is labelled - if you want more or less, change the value in the sed command below
sed -i 's/$/ \\\> 1/g' *percent.sh
sed -i 's/expr \./expr 0\./g' *percent.sh
sed -i 's/$/ \>\> include/g' *percent.sh

#Need to rename each include in the percent.sh file with the header from the percent.sh file
for perc in *percent.sh; do sed -i "s/include/"$perc"\.include/g" $perc; done

#Run the percent.sh files
for perc in *percent.sh; do sh $perc; done

#Lists the name of each fasta sequence entry and whether or not to include it
#0 and 1 are everywhere - so names changed in the include file to avoid later issues
sed -i 's/0/remove/g' *.include
sed -i 's/1/keep/g' *.include

#Paste the include files with the tab files
for tab in *.tab; do paste $tab $tab.calcu.sh.percent.sh.include > $tab.pasted; done

#Remove unwanted files using grep

for rem in *.pasted; do grep -v "remove" $rem > $rem.goodfna; done
sed -i 's/keep//g' *.goodfna

#Switch back to normal fasta
sed -i 's/\t/\n/g' *.goodfna

rm -rf *calcu.sh *.include *.one *.tab *percent.sh *.include *.pasted *.good 


