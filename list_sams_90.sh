#Solution for pulling out sam files that are >90% only
#Emma Thomson 27th February 2021

#DEPENDENCIES
#Starting files must include sam files and samstats script must run and be generated in the same folder 
#This step pulls out a list of sam files with a percentage coverage of >90% - this can be changed as needed

#Need to put all the sequences and names onto a single line with a tab delimiter
#for one in *.fna; do cat $one | awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}'>>$one.one; done

#Create a sam_stats file
#for st in *.sam; do echo $st>>samstats-$$; SAM_STATS $st >> samstats-$$; done

#Remove blank lines
sed -i '/^$/d' samstats*

#Pulls out the coverage information
for sam in samstats*; do grep -A 1 ".sam" $sam > $sam\_samstats_red; done
for cov in *samstats_red; do grep -B 1 "Cov" $cov > $cov\_stats_coverage; done
for sn in *stats_coverage; do grep "\.sam" $sn > $sn\_cov_names-$$; done
for cn in *stats_coverage; do grep "Cov" $cn | cut -f 3 | sed 's/Coverage://g' > $cn\_cov_number-$$; done
paste *cov_names-$$ *cov_number-$$ | sed 's/\%//g' >cov_stats-$$

#Uses awk to select only same files with coverage >=90 (CHANGE HERE IF A DIFFERENT % IS NEEDED)
cat cov_stats-$$ | awk '$2>=90' | cut -f 1 > sam_files_90-$$

