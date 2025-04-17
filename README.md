# 🧬 Contignyzer

**Contignyzer** is a reproducible, Snakemake-based workflow for benchmarking metagenome assemblies across different k-mer sets and assemblers (currently SPAdes, MEGAHIT planned). It evaluates assembly quality using QUAST, tracks runtime, and summarizes results in tables and plots — helping researchers select the optimal assembly strategy for their metagenomic samples.

---

## 📁 Folder Structure

contignyzer/ ├── config/ │ └── config.yaml # Input samples, k-mer sets, global settings ├── rules/
│ ├── all.smk # Rule to build all final targets │ ├── spades.smk # SPAdes assembly rule │ ├── megahit.smk # MEGAHIT assembly rule (coming soon) │ ├── quast.smk # QUAST evaluation rule (coming soon) │ └── summary.smk # Summary plots + table (coming soon) ├── envs/ │ └── contignyzer.yaml # Conda environment for the whole pipeline ├── scripts/ │ └── summarize_quast.py # Script to parse QUAST + time logs (TBD) ├── data/ │ └── raw/ # Input FASTQ files (gzipped supported) ├── results/ │ └── assemblies/ # Assembly outputs (SPAdes, MEGAHIT) │ └── quast/ # QUAST reports │ └── summary/ # Summary tables and plots ├── logs/ # Assembly logs + runtime tracking ├── Snakefile # Main Snakefile (includes modular rules) └── README.md


---

## 🧪 Example Config

Example `config/config.yaml`:

```yaml
samples:
  gut01:
    R1: "data/raw/gut01_R1.fastq.gz"
    R2: "data/raw/gut01_R2.fastq.gz"
  gut02:
    R1: "data/raw/gut02_R1.fastq.gz"
    R2: "data/raw/gut02_R2.fastq.gz"

kmer_sets:
  kset1: [21, 33, 55]
  kset2: [27, 37, 47]

assemblers: [spades]

threads: 8

🚀 How to Use

1. Clone this repository
git clone https://github.com/yourusername/contignyzer.git
cd contignyzer
2. Create the conda environment
conda env create -f envs/contignyzer.yaml
conda activate contignyzer
3. Prepare your data
Place your gzipped paired-end reads in data/raw/ and edit config/config.yaml with your sample names and paths.

4. Run the workflow
snakemake --cores 8
This will:

Run SPAdes for each sample and k-mer set
Log runtime for each assembly
Output assemblies and logs in the results/ and logs/ folders
📋 Tasks and Roadmap


Status	Task
✅	Modular SPAdes rule with runtime tracking
✅	Global thread configuration
✅	Multi-sample and multi-k-mer support
✅	Conda environment file
✅	config.yaml with flexible structure
🛠️	Implement MEGAHIT rule
🛠️	Implement QUAST rule
🛠️	Script to parse QUAST + time logs
🛠️	Generate summary table and plots
⏳	Optional HTML report
⏳	Example test dataset
⏳	Unit tests / CI integration
⏳	Docker / Singularity support
⏳	Documentation site or wiki
⏳	Release v1.0 on GitHub
⏳	Publication-ready preprint or paper
🤝 Contributing

Contributions are welcome! Please open an issue or submit a pull request. See the issues tab for features you can help with.

📜 License

Distributed under the MIT License. See LICENSE for details.

👤 Author

Developed by [Your Name], microbial ecologist and bioinformatician.
Contact: [your.email@domain.org]

📣 Citation

Coming soon — this tool is under active development.