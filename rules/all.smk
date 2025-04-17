# Load sample and k-mer info from config
SAMPLES = list(config["samples"].keys())
KMER_LABELS = list(config["kmer_sets"].keys())

rule all:
    input:
        # SPAdes assemblies
        expand("results/assemblies/{sample}/spades_{kmer_label}/contigs.fasta",
               sample=SAMPLES,
               kmer_label=KMER_LABELS),
        # SPAdes runtime logs
        expand("logs/spades/{sample}_{kmer_label}.time",
               sample=SAMPLES,
               kmer_label=KMER_LABELS),
        # We'll add these later:
        # QUAST reports
        # Summary tables and plots
