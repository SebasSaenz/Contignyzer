# Snakefile

configfile: "config.yaml"

rule all:
    input:
        expand("{output_dir}/evaluation/{assembler}_kmers_{kmers}/report.tsv",
               output_dir=config["output_dir"],
               assembler=config["assemblers"],
               kmers=["-".join(map(str, ks)) for ks in config["kmer_sets"]]),
        expand("{output_dir}/assemblies/{assembler}/kmers_{kmers}/runtime.txt",
               output_dir=config["output_dir"],
               assembler=config["assemblers"],
               kmers=["-".join(map(str, ks)) for ks in config["kmer_sets"]])

include: "rules/assemble.smk"
include: "rules/evaluate.smk"
