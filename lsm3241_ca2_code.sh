#build combined indices
bowtie2-build 'sacCer3.fa,ty5_6p.fa' yeast_trans_index

#alignment of reads to yeast and transposon index:
export BOWTIE2_INDEXES=$(pwd)/yeast_trans_index
bowtie2 -x yeast_trans_index -1 ca2_data/A0155657U_1.fq  -2 ca2_data/A0155657U_2.fq -S read_align_to_index.sam


#sort the read_align_to_index.sam file
samtools sort read_align_to_index.sam > sorted_read_align_to_index.sam

#filter the read_align_to_index.sam file based on the negation of :
#read mapped in proper pair
#read unmapped 
#mate unmapped 
#read fails platform/vendor quality checks 
#read is PCR or optical duplicate 
samtools view -F 1550 sorted_read_align_to_index.sam > sorted_filtered_read_align_to_index_latest.sam

F=sorted_filtered_read_align_to_index_latest.sam

grep -i ty5 $F

grep -i ty5 $F | cut -f3,4

grep -i ty5 $F | cut -f3 | uniq -c

grep -i ty5 $F | cut -f3,4 | grep chrXII




