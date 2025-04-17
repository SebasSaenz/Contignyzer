# Load config
configfile: "config/config.yaml"

# Include all rule modules
include: "rules/all.smk"
include: "rules/spades.smk"
include: "rules/megahit.smk"
include: "rules/quast.smk"
include: "rules/summary.smk"