# nf-core/metatdenovo execution directories

Each subdirectory contains a project for the manuscript, with these individual pieces:

* A script, `fetch_sequences.sh` that fetches _public_ data from a repository and places it in the reads directory

* A comma separated sample sheet, e.g. `samples.csv`

* One or more parameter file, typically in yaml format, defining running conditions for nf-core/metatdenovo (used with Nextflow's `-params-file` parameter)

* One output directory for each parameter file, specified as value for the `outdir` parameter for the run, named similar to `assembler.orf_caller.bbnorm.minlenN` where:
  - `assembler`: `megahit` or `rnaspades`
  - `orf_caller`: `prodigal`, `prokka` or `transdecoder`
  - `bbnorm`: `with_bbnorm` or `without_bbnorm`
  - `minlenN`: non-mandatory, `N` indicates the number specified for the `min_contig_length` parameter

* The following results files should be _added_ to the repo:
  - `multiqc/multiqc_report.html`
  - `pipeline_info`: `execution_trace*.txt`, `params*.json`, `samplesheet.valid.csv` and `software_versions.yml`
  - All `*.tsv.gz` files in `summary_tables/`
  - The `*.csv` file in `transrate/

Since the files will be read by the Quarto script in the root directory of the repo, which parses file names for information, it's important that the naming conventions are followed and that the above files are added to the repo.

Please see the `mst-1` subdirectory for examples.

Run nf-core/metatdenovo in your subdirectory.
