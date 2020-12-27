#Script for taking a proportion of reads out of a file based on the genotyping data
#Need to have the .fna files and the geno.stats.sorted files as input in same folder
#Genotyping carried out using create kmers script by Sreenu Vattipally
#Emma Thomson September 2020 emma.thomson@glasgow.ac.uk

#Take out the last 5 lines from the geno.stats file and separate into two files
for genstats in *.geno.stats.sorted; do tail -5 $genstats | cut -f 1 > $genstats\.top5_num_acc; done
for genstats in *.geno.stats.sorted; do tail -5 $genstats | cut -f 2 > $genstats\.top5_num; done

##Calculate the percentage that each represent from the input file

#Total count
for calc1 in *top5_num; do paste -sd+ $calc1 | bc > $calc1\.total; done

#Define numbers from each line; 1=a, 2=b, 3=c, 4=d, 5=e
#The sed -r command removes whitespace
for se in *top5_num; do sed '1q;d' $se |sed -r 's/\s+//g'>$se\_a; done
for se in *top5_num; do sed '2q;d' $se |sed -r 's/\s+//g'>$se\_b; done
for se in *top5_num; do sed '3q;d' $se |sed -r 's/\s+//g'>$se\_c; done
for se in *top5_num; do sed '4q;d' $se |sed -r 's/\s+//g'>$se\_d; done
for se in *top5_num; do sed '5q;d' $se |sed -r 's/\s+//g'>$se\_e; done

#Read abcde and total into variables
#Figure out the percentages - listed by line as 1=2a, 2=2b, 3=3b, 4=4b, 5=5b
for perc in *_num; do read a < $perc\_a; read tot < $perc\.total; printf "%.0f\n" $(echo "scale=5; (($a/$tot)*100)" |bc)>$perc\_2a; done
for perc in *_num; do read b < $perc\_b; read tot < $perc\.total; printf "%.0f\n" $(echo "scale=5; (($b/$tot)*100)" |bc)>$perc\_2b; done
for perc in *_num; do read c < $perc\_c; read tot < $perc\.total; printf "%.0f\n" $(echo "scale=5; (($c/$tot)*100)" |bc)>$perc\_2c; done
for perc in *_num; do read d < $perc\_d; read tot < $perc\.total; printf "%.0f\n" $(echo "scale=5; (($d/$tot)*100)" |bc)>$perc\_2d; done
for perc in *_num; do read e < $perc\_e; read tot < $perc\.total; printf "%.0f\n" $(echo "scale=5; (($e/$tot)*100)" |bc)>$perc\_2e; done

##Print out those percentages
for top5per in *_num; do cat $top5per\_2a $top5per\_2b $top5per\_2c $top5per\_2d $top5per\_2e > $top5per\_per;done
#Print out the percentages with the accession numbers
for top5accper in *num; do paste $top5accper\_acc $top5accper\_per > $top5accper\_acc_per; done

##Replace the accession numbers with genotype
rm -rf *per_geno* *pergeno*
for copy in *num_acc_per; do cp $copy $copy\_geno; done
sed -i 's/AB031663/2k/g' *per_geno
sed -i 's/AF009606/1a/g' *per_geno
sed -i 's/AAF064490/5a/g' *per_geno
sed -i 's/AJ851228/1/g' *per_geno
sed -i 's/AM910652/1g/g' *per_geno
sed -i 's/D00944/2a/g' *per_geno
sed -i 's/D10988/2b/g' *per_geno
sed -i 's/D14853/1c/g' *per_geno
sed -i 's/D17763/3a/g' *per_geno
sed -i 's/D49374/3b/g' *per_geno
sed -i 's/D50409/2c/g' *per_geno
sed -i 's/D63821/3k/g' *per_geno
sed -i 's/D63822/6g/g' *per_geno
sed -i 's/D84262/6b/g' *per_geno
sed -i 's/D84263/6d/g' *per_geno
sed -i 's/D84264/6k/g' *per_geno
sed -i 's/D84265/6h/g' *per_geno
sed -i 's/D90208/1b/g' *per_geno
sed -i 's/DQ155561/2i/g' *per_geno
sed -i 's/DQ278891/6-/g' *per_geno
sed -i 's/DQ278892/6w/g' *per_geno
sed -i 's/DQ278893/6/g' *per_geno
sed -i 's/DQ278894/6n/g' *per_geno
sed -i 's/DQ314805/6e/g' *per_geno
sed -i 's/DQ418786/4d/g' *per_geno
sed -i 's/DQ835760/6f/g' *per_geno
sed -i 's/DQ835767/6m/g' *per_geno
sed -i 's/DQ835769/6j/g' *per_geno
sed -i 's/DQ835770/6i/g' *per_geno
sed -i 's/EF108306/7a/g' *per_geno
sed -i 's/EF424625/6q/g' *per_geno
sed -i 's/EF424626/6p/g' *per_geno
sed -i 's/EF424627/6o/g' *per_geno
sed -i 's/EF424628/6l/g' *per_geno
sed -i 's/EF424629/6c/g' *per_geno
sed -i 's/EF589161/4f/g' *per_geno
sed -i 's/EF632071/6t/g' *per_geno
sed -i 's/EU158186/6v/g' *per_geno
sed -i 's/EU246940/6u/g' *per_geno
sed -i 's/EU392173/4k/g' *per_geno
sed -i 's/EU408328/6r/g' *per_geno
sed -i 's/EU408329/6s/g' *per_geno
sed -i 's/EU408330/6xa/g' *per_geno
sed -i 's/FJ025854/4/g' *per_geno
sed -i 's/FJ025855/4w/g' *per_geno
sed -i 's/FJ407092/3i/g' *per_geno
sed -i 's/FJ462431/4p/g' *per_geno
sed -i 's/FJ462432/4g/g' *per_geno
sed -i 's/FJ462433/4m/g' *per_geno
sed -i 's/FJ462434/4q/g' *per_geno
sed -i 's/FJ462435/4b/g' *per_geno
sed -i 's/FJ462436/4c/g' *per_geno
sed -i 's/FJ462439/4r/g' *per_geno
sed -i 's/FJ462440/4o/g' *per_geno
sed -i 's/FJ462441/4n/g' *per_geno
sed -i 's/FJ839869/4t/g' *per_geno
sed -i 's/FJ839870/4l/g' *per_geno
sed -i 's/FN666428/2q/g' *per_geno
sed -i 's/HM777358/2j/g' *per_geno
sed -i 's/HQ537007/1/g' *per_geno
sed -i 's/HQ537009/4v/g' *per_geno
sed -i 's/JF735110/2/g' *per_geno
sed -i 's/JF735111/2m/g' *per_geno
sed -i 's/JF735112/2u/g' *per_geno
sed -i 's/JF735114/2d/g' *per_geno
sed -i 's/JF735115/2r/g' *per_geno
sed -i 's/JF735116/2/g' *per_geno
sed -i 's/JF735117/2/g' *per_geno
sed -i 's/JF735118/2/g' *per_geno
sed -i 's/JF735119/2/g' *per_geno
sed -i 's/JF735120/2e/g' *per_geno
sed -i 's/JF735121/3h/g' *per_geno
sed -i 's/JF735124/3/g' *per_geno
sed -i 's/JF735127/4/g' *per_geno
sed -i 's/JF735129/4/g' *per_geno
sed -i 's/JF735130/4/g' *per_geno
sed -i 's/JF735131/4/g' *per_geno
sed -i 's/JF735132/4/g' *per_geno
sed -i 's/JF735134/4/g' *per_geno
sed -i 's/JF735135/4/g' *per_geno
sed -i 's/JF735136/4s/g' *per_geno
sed -i 's/JF735138/4/g' *per_geno
sed -i 's/JX183549/6/g' *per_geno
sed -i 's/JX183550/6/g' *per_geno
sed -i 's/JX183551/6/g' *per_geno
sed -i 's/JX183552/6xb/g' *per_geno
sed -i 's/JX183553/6/g' *per_geno
sed -i 's/JX183554/6/g' *per_geno
sed -i 's/JX183557/6xe/g' *per_geno
sed -i 's/JX183558/6/g' *per_geno
sed -i 's/JX227954/3g/g' *per_geno
sed -i 's/JX227964/4/g' *per_geno
sed -i 's/KC197235/2l/g' *per_geno
sed -i 's/KC197236/2/g' *per_geno
sed -i 's/KC197237/2/g' *per_geno
sed -i 's/KC197238/2t/g' *per_geno
sed -i 's/KC197239/2/g' *per_geno
sed -i 's/KC248193/1l/g' *per_geno
sed -i 's/KC248194/1e/g' *per_geno
sed -i 's/KC248195/1/g' *per_geno
sed -i 's/KC248198/1h/g' *per_geno
sed -i 's/KC844039/6/g' *per_geno
sed -i 's/KC844040/6/g' *per_geno
sed -i 's/KC844042/2f/g' *per_geno
sed -i 's/KJ439768/1d/g' *per_geno
sed -i 's/KJ439772/1i/g' *per_geno
sed -i 's/KJ439773/1j/g' *per_geno
sed -i 's/KJ439774/1k/g' *per_geno
sed -i 's/KJ439776/1/g' *per_geno
sed -i 's/KJ439777/1/g' *per_geno
sed -i 's/KJ439778/1m/g' *per_geno
sed -i 's/KJ439779/1o/g' *per_geno
sed -i 's/KJ439780/1/g' *per_geno
sed -i 's/KJ439781/1n/g' *per_geno
sed -i 's/KJ470618/3e/g' *per_geno
sed -i 's/KJ470619/3d/g' *per_geno
sed -i 's/KJ470620/6/g' *per_geno
sed -i 's/KJ470621/6/g' *per_geno
sed -i 's/KJ470622/6/g' *per_geno
sed -i 's/KJ470623/6/g' *per_geno
sed -i 's/KJ470624/6/g' *per_geno
sed -i 's/KJ470625/6/g' *per_geno
sed -i 's/KJ567647/6xf/g' *per_geno
sed -i 's/KJ567648/6/g' *per_geno
sed -i 's/KJ567650/6/g' *per_geno
sed -i 's/KJ567651/6xc/g' *per_geno
sed -i 's/KJ567652/6/g' *per_geno
sed -i 's/KM252789/6xd/g' *per_geno
sed -i 's/KU861171/7/g' *per_geno
sed -i 's/KX092342/7b/g' *per_geno
sed -i 's/MG878999/6/g' *per_geno
sed -i 's/MG879000/6xh/g' *per_geno
sed -i 's/MH492360/6xg/g' *per_geno
sed -i 's/MH590700/8/g' *per_geno
sed -i 's/MN164876/1p/g' *per_geno
sed -i 's/Y11604/4a/g' *per_geno
sed -i 's/Y12083/6a/g' *per_geno

for all in *_num; do paste $all\_acc_top5_geno $all\_per $all\_acc > $all\_top5_all; done

rm -rf *_a *_b *_c *_d *_e *_2a *_2b *_2c *_2d *_2e *num


#Simplify input files and put the files on one line, shuffle them
#Chose the right number using the translated *per_geno input file
#Input co-ordinates are replaced as necessary by region

rm -rf *oneline* *NS5B*random* *NS2*random*
for fna in *.goodfna; do cat $fna |awk '/^>/ { if(i>0) printf("\n"); i++; printf("%s\t",$0); next;} {printf("%s",$0);} END { printf("\n");}' |shuf> $fna\.oneline; done
rename 's/concatenatedBamAlmt_patient_//g' *oneline
rename 's/_ps_with_duplicates\.fna\.one\.tab\.pasted\.goodfna\.oneline/_oneline\.fna/g' *COORDINATES*oneline
rename 's/\.geno\.stats\.sorted\.top5_num_acc_per_geno/\.pergeno/g' *top5_num_acc_per_geno
rename 's/_region_/_/g' *oneline.fna
for pg in *.pergeno; do rename "s/$pg/$(ls $pg| cut -f 1,2 -d "_")\.pergeno/g" $pg; done

#Randomise input fasta files
#Select the right number of sequences using correct input file - this is the per_geno file
#Selects random sequences using shuf command
#Example names below
#P13_310310_1a_911_1020_oneline.fna
#P13_310310.pergeno

#Create a file with the input fna file name, and the number to be taken from there
#while read x y; do  
rm -rf *ipa *ipb *ipc *ipd *ipe *ipall

#Make a file with the percentage to be taken and the correct input file in it
for rand in *.pergeno; do echo "$(ls $rand|sed 's/\.pergeno/_/g')$(sed '1q;d' $rand |cut -f 1)_COORDINATES_oneline.fna" > $rand\_ipa;done
for rand in *.pergeno; do echo "$(ls $rand|sed 's/\.pergeno/_/g')$(sed '2q;d' $rand |cut -f 1)_COORDINATES_oneline.fna" > $rand\_ipb;done
for rand in *.pergeno; do echo "$(ls $rand|sed 's/\.pergeno/_/g')$(sed '3q;d' $rand |cut -f 1)_COORDINATES_oneline.fna" > $rand\_ipc;done
for rand in *.pergeno; do echo "$(ls $rand|sed 's/\.pergeno/_/g')$(sed '4q;d' $rand |cut -f 1)_COORDINATES_oneline.fna" > $rand\_ipd;done
for rand in *.pergeno; do echo "$(ls $rand|sed 's/\.pergeno/_/g')$(sed '5q;d' $rand |cut -f 1)_COORDINATES_oneline.fna" > $rand\_ipe;done

for rand in *.pergeno; do cat $rand\_ipa $rand\_ipb $rand\_ipc $rand\_ipd $rand\_ipe > $rand\_ipall; done 

for rand in *.pergeno; do paste $rand $rand\_ipall | cut -f 2,3 | tac | sed '1q;d'>$rand\.run1; done
for rand in *.pergeno; do paste $rand $rand\_ipall | cut -f 2,3 | tac | sed '2q;d'>$rand\.run2; done
for rand in *.pergeno; do paste $rand $rand\_ipall | cut -f 2,3 | tac | sed '3q;d'>$rand\.run3; done
for rand in *.pergeno; do paste $rand $rand\_ipall | cut -f 2,3 | tac | sed '4q;d'>$rand\.run4; done
for rand in *.pergeno; do paste $rand $rand\_ipall | cut -f 2,3 | tac | sed '5q;d'>$rand\.run5; done

for run in *.run1; do
 while read x y; do shuf| head -$x $y |awk '{printf("%s\n%s\n",$1,$2)}'>$y\.COORDINATESrandomised; done <$run
done 
for run in *.run2; do
 while read x y; do shuf|head -$x $y |awk '{printf("%s\n%s\n",$1,$2)}'>$y\.COORDINATESrandomised; done <$run
done 
for run in *.run3; do
 while read x y; do shuf|head -$x $y |awk '{printf("%s\n%s\n",$1,$2)}'>$y\.COORDINATESrandomised; done <$run
done 
for run in *.run4; do
 while read x y; do shuf|head -$x $y |awk '{printf("%s\n%s\n",$1,$2)}'>$y\.COORDINATESrandomised; done <$run
done 
for run in *.run5; do
 while read x y; do shuf|head -$x $y |awk '{printf("%s\n%s\n",$1,$2)}'>$y\.COORDINATESrandomised; done <$run
done 

for allns2 in *.pergeno; do cat "$(ls $allns2|sed 's/\.pergeno/_/g')"*.COORDINATESrandomised > $allns2\.COORDINATESrandomised\.all;done
rename 's/\.pergeno//g' *COORDINATESrandomised.all

rm -rf *_num_* *run1 *run2 *run3 *run4 *run5 *randomised *oneline* *.total *pergeno*
rm -rf *_ipa *_ipb *_ipc *_ipd *_ipe *_num_ *acc 
##for rand in *905*.oneline; do cat $rand |shuf |head -n 5 |awk '{printf("%s\n%s\n",$1,$2)}'>$rand\.COORDINATESrandomised; done


