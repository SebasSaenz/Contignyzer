import os
import re
import glob
import pandas as pd


def parse_report_line(report_path):
    """Extracts metrics from a single report.tsv file"""
    metrics = {"N50": None, "Total length": None, "# contigs": None}
    try:
        with open(report_path, "r") as f:
            for line in f:
                for key in metrics:
                    if key in line:
                        # Extract the value from tab-separated line
                        try:
                            metrics[key] = line.strip().split("\t")[-1]
                        except IndexError:
                            pass
    except Exception as e:
        print(f"Failed to parse {report_path}: {e}")
    return metrics


def parse_runtime(assembler, kmers, base_dir):
    """Reads runtime in seconds from runtime.txt"""
    runtime_path = os.path.join(base_dir, "assemblies", assembler, f"kmers_{kmers}", "runtime.txt")
    if os.path.exists(runtime_path):
        with open(runtime_path, "r") as f:
            return int(f.read().strip())
    return None


def collect_results(base_dir="results"):
    """Collects metrics and runtime from all evaluations"""
    reports = glob.glob(os.path.join(base_dir, "evaluation", "*", "report.tsv"))
    results = []

    for report in reports:
        match = re.search(r"([^/]+)_kmers_([^/]+)/report.tsv$", report)
        if not match:
            continue

        assembler, kmers = match.groups()
        metrics = parse_report_line(report)
        metrics["assembler"] = assembler
        metrics["kmers"] = kmers
        metrics["runtime_sec"] = parse_runtime(assembler, kmers, base_dir)
        results.append(metrics)

    return pd.DataFrame(results)


if __name__ == "__main__":
    df = collect_results()
    df = df[["assembler", "kmers", "N50", "Total length", "# contigs", "runtime_sec"]]
    print(df.to_string(index=False))

    # Optionally write to CSV
    df.to_csv("results/summary.csv", index=False)
