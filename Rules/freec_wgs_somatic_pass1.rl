if config['project']['annotation'] == "hg19":
 rule freec_wgs_somatic_pass1:
     input: normal=lambda wildcards: config['project']['pairs'][wildcards.x][0]+".recal.bam",
            tumor=lambda wildcards: config['project']['pairs'][wildcards.x][1]+".recal.bam",
            index1=lambda wildcards: config['project']['pairs'][wildcards.x][0]+".recal.bai",
            index2=lambda wildcards: config['project']['pairs'][wildcards.x][1]+".recal.bai",
     output: cnvs="freec_out/pass1/{x}/"+lambda wildcards: config['project']['pairs'][wildcards.x][1]+".recal.bam_CNVs",
             newnormbam=temp("freec_out/"+lambda wildcards: config['project']['pairs'][wildcards.x][0]+".recal.bam"),
             newtumorbam=temp("freec_out/"+lambda wildcards: config['project']['pairs'][wildcards.x][1]+".recal.bam"),
             normalpileup="freec_out/pass1/{x}/"+lambda wildcards: config['project']['pairs'][wildcards.x][0]+".recal.bam_minipileup.pileup",
             tumorpileup="freec_out/pass1/{x}/"+lambda wildcards: config['project']['pairs'][wildcards.x][1]+".recal.bam_minipileup.pileup",
     params: dir=config['project']['workpath'],fasta=config['references'][pfamily]['FREECFASTA'],tumorsample=lambda wildcards: config['project']['pairs'][wildcards.x][1],normalsample=lambda wildcards: config['project']['pairs'][wildcards.x][0],lengths=config['references'][pfamily]['FREECLENGTHS'],chroms=config['references'][pfamily]['FREECCHROMS'],pile=config['references'][pfamily]['FREECPILEUP'],snps=config['references'][pfamily]['FREECSNPS'],rname="pl:freec"
     shell: "module load samtools/1.9
             samtools view -H {input.normal} | sed -e 's/SN:1/SN:chr1/' | sed -e 's/SN:2/SN:chr2/' | sed -e 's/SN:3/SN:chr3/' | sed -e 's/SN:4/SN:chr4/' | sed -e 's/SN:5/SN:chr5/' | sed -e 's/SN:6/SN:chr6/' | sed -e 's/SN:7/SN:chr7/' | sed -e 's/SN:8/SN:chr8/' | sed -e 's/SN:9/SN:chr9/' | sed -e 's/SN:10/SN:chr10/' | sed -e 's/SN:11/SN:chr11/' | sed -e 's/SN:12/SN:chr12/' | sed -e 's/SN:13/SN:chr13/' | sed -e 's/SN:14/SN:chr14/' | sed -e 's/SN:15/SN:chr15/' | sed -e 's/SN:16/SN:chr16/' | sed -e 's/SN:17/SN:chr17/' | sed -e 's/SN:18/SN:chr18/' | sed -e 's/SN:19/SN:chr19/' | sed -e 's/SN:20/SN:chr20/' | sed -e 's/SN:21/SN:chr21/' | sed -e 's/SN:22/SN:chr22/' | sed -e 's/SN:X/SN:chrX/' | sed -e 's/SN:Y/SN:chrY/' | sed -e 's/SN:MT/SN:chrM/' | samtools reheader - {input.normal} > {output.newnormbam}
             samtools view -H {input.tumor} | sed -e 's/SN:1/SN:chr1/' | sed -e 's/SN:2/SN:chr2/' | sed -e 's/SN:3/SN:chr3/' | sed -e 's/SN:4/SN:chr4/' | sed -e 's/SN:5/SN:chr5/' | sed -e 's/SN:6/SN:chr6/' | sed -e 's/SN:7/SN:chr7/' | sed -e 's/SN:8/SN:chr8/' | sed -e 's/SN:9/SN:chr9/' | sed -e 's/SN:10/SN:chr10/' | sed -e 's/SN:11/SN:chr11/' | sed -e 's/SN:12/SN:chr12/' | sed -e 's/SN:13/SN:chr13/' | sed -e 's/SN:14/SN:chr14/' | sed -e 's/SN:15/SN:chr15/' | sed -e 's/SN:16/SN:chr16/' | sed -e 's/SN:17/SN:chr17/' | sed -e 's/SN:18/SN:chr18/' | sed -e 's/SN:19/SN:chr19/' | sed -e 's/SN:20/SN:chr20/' | sed -e 's/SN:21/SN:chr21/' | sed -e 's/SN:22/SN:chr22/' | sed -e 's/SN:X/SN:chrX/' | sed -e 's/SN:Y/SN:chrY/' | sed -e 's/SN:MT/SN:chrM/' | samtools reheader - {input.tumor} > {output.newtumorbam}
             mkdir -p freec_out
             mkdir -p freec_out/pass1
             mkdir -p freec_out/pass1/{params.normalsample}+{params.tumorsample}
             perl Scripts/make_freec_pass1_wgs_tn_config.pl {params.dir}/freec_out/pass1/{params.normalsample}+{params.tumorsample} {params.lengths} {params.chroms} {params.dir}/freec_out/{output.newtumorbam} {params.dir}/freec_out/{output.newnormalbam} {params.pile} {params.fasta} {params.snps}
             module load freec/11.5
             module load bedtools/2.27.1
             freec -conf {params.dir}/freec_out/pass1/{params.normalsample}+{params.tumorsample}/freec_wgs_config.txt"

else:
 rule freec_wgs_somatic_pass1:
     input: normal=lambda wildcards: config['project']['pairs'][wildcards.x][0]+".recal.bam",
            tumor=lambda wildcards: config['project']['pairs'][wildcards.x][1]+".recal.bam",
            index1=lambda wildcards: config['project']['pairs'][wildcards.x][0]+".recal.bai",
            index2=lambda wildcards: config['project']['pairs'][wildcards.x][1]+".recal.bai",
     output: cnvs="freec_out/pass1/{x}/"+lambda wildcards: config['project']['pairs'][wildcards.x][1]+".recal.bam_CNVs",
             normalpileup="freec_out/pass1/{x}/"+lambda wildcards: config['project']['pairs'][wildcards.x][0]+".recal.bam_minipileup.pileup",
             tumorpileup="freec_out/pass1/{x}/"+lambda wildcards: config['project']['pairs'][wildcards.x][1]+".recal.bam_minipileup.pileup",
     params: dir=config['project']['workpath'],fasta=config['references'][pfamily]['FREECFASTA'],tumorsample=lambda wildcards: config['project']['pairs'][wildcards.x][1],normalsample=lambda wildcards: config['project']['pairs'][wildcards.x][0],lengths=config['references'][pfamily]['FREECLENGTHS'],chroms=config['references'][pfamily]['FREECCHROMS'],pile=config['references'][pfamily]['FREECPILEUP'],snps=config['references'][pfamily]['FREECSNPS'],rname="pl:freec"
     shell: "mkdir -p freec_out
             mkdir -p freec_out/pass1
             mkdir -p freec_out/pass1/{params.normalsample}+{params.tumorsample}
             perl Scripts/make_freec_pass1_wgs_tn_config.pl {params.dir}/freec_out/pass1/{params.normalsample}+{params.tumorsample} {params.lengths} {params.chroms} {params.dir}/{input.tumor} {params.dir}/{input.normal} {params.pile} {params.fasta} {params.snps}
             module load freec/11.5
             module load samtools/1.9
             module load bedtools/2.27.1
             freec -conf {params.dir}/freec_out/pass1/{params.normalsample}+{params.tumorsample}/freec_wgs_config.txt"