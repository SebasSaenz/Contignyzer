rule assemble:
    input:
        R1=config["reads"]["R1"],
        R2=config["reads"]["R2"]
    output:
        contigs=lambda wc: f"{config['output_dir']}/assemblies/{wc.assembler}/kmers_{wc.kmers}/contigs.fasta",
        runtime=lambda wc: f"{config['output_dir']}/assemblies/{wc.assembler}/kmers_{wc.kmers}/runtime.txt"
    params:
        kmers_csv=lambda wc: ",".join(wc.kmers.split("-"))
    threads: config["threads"]
    shell:
        """
        start_time=$(date +%s)

        if [ "{wildcards.assembler}" == "megahit" ]; then
            megahit -1 {input.R1} -2 {input.R2} \
                -o {config[output_dir]}/assemblies/megahit/kmers_{wildcards.kmers} \
                --k-list {params.kmers_csv} --num-cpu-threads {threads} && \
            cp {config[output_dir]}/assemblies/megahit/kmers_{wildcards.kmers}/final.contigs.fa {output.contigs} ;
        elif [ "{wildcards.assembler}" == "metaspades" ]; then
            spades.py -1 {input.R1} -2 {input.R2} \
                -k {params.kmers_csv} -t {threads} \
                -o {config[output_dir]}/assemblies/metaspades/kmers_{wildcards.kmers} && \
            cp {config[output_dir]}/assemblies/metaspades/kmers_{wildcards.kmers}/contigs.fasta {output.contigs} ;
        fi

        end_time=$(date +%s)
        echo "$((end_time - start_time))" > {output.runtime}
        """
