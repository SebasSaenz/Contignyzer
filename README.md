# Metagenome Assembly Benchmark

A modular tool to compare and evaluate metagenome assemblies using MEGAHIT and metaSPAdes with different parameter combinations.

## Features
- Runs multiple assemblies
- Evaluates assemblies with MetaQUAST
- Summarizes results in tables and plots

## Usage (in development)
1. Clone the repo
2. Modify `config/config.yaml`
3. Run the workflow (via Snakemake or CLI)

## Requirements
- Conda
- Python 3.11
- Snakemake, MEGAHIT, SPAdes, QUAST

## Project structure

```
contignyzer/
├── config/
│   └── config.yaml         # User input (read paths, tools, parameters)
├── workflow/
│   └── Snakefile           # The core workflow
├── results/                # Output from assemblies and evaluations
├── environment.yaml        # All dependencies in one conda env
├── data/                   # Input reads go here
└── README.md               # Document your project
```
