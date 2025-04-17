SAMPLES = list(config["samples"].keys())
KMER_LABELS = list(config["kmer_sets"].keys())

def get_kmers(label):
    return ",".join(map(str, config["kmer_sets"][label]))

rule assemble_spades:
    input:
        r1 = lambda wc: config["samples"][wc.sample]["R1"],
        r2 = lambda wc: config["samples"][wc.sample]["R2"]
    output:
        assembly = "results/assemblies/{sample}/spades_{kmer_label}/contigs.fasta",
        time_log = "logs/spades/{sample}_{kmer_label}.time"
    params:
        kmers = lambda wc: get_kmers(wc.kmer_label),
        outdir = "results/assemblies/{sample}/spades_{kmer_label}"
    threads:
        config["threads"]
    log:
        "logs/spades/{sample}_{kmer_label}.log"
    shell:
        """
        mkdir -p {params.outdir}
        /usr/bin/time -v -o {output.time_log} \
        spades.py -1 {input.r1} -2 {input.r2} \
            -o {params.outdir} \
            -k {params.kmers} \
            -t {threads} &> {log}
        """