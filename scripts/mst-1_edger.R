#!/usr/bin/env Rscript

# mst-1_edger.R
#
# Performs an EdgeR analysis on MST-1 (Megahit, Prokka, wo normalization)
#
# Author: daniel.lundin@lnu.se

suppressPackageStartupMessages(library(readr))
suppressPackageStartupMessages(library(dplyr, warn.conflicts = FALSE))
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(purrr))
suppressPackageStartupMessages(library(stringr))
suppressPackageStartupMessages(library(edgeR))
suppressPackageStartupMessages(library(tibble))

counts <- read_tsv(
  'nextflow/mst-1/megahit.prokka.without_bbnorm/summary_tables/megahit.prokka.counts.tsv.gz', 
  show_col_types = FALSE
)

eggnogs <- read_tsv(
  'nextflow/mst-1/megahit.prokka.without_bbnorm/summary_tables/megahit.prokka.emapper.tsv.gz',
  show_col_types = FALSE
) %>%
  rename_all(str_to_lower) %>%
  select(orf, eggnog_ogs, cog_category, description, preferred_name) %>%
  separate_rows(eggnog_ogs, sep = ',') %>%
  separate(eggnog_ogs, c('eggnog', 'taxon'), sep = '@') %>%
  # Some ORFs have duplicate annotations for a taxon
  group_by(orf, taxon) %>%
  arrange(eggnog) %>%
  filter(row_number() == 1) %>%
  ungroup()

samples <- tribble(
  ~sample, ~treatment, ~replicate,
  'KA1',   'control_acidified', '1',
  'KA2',   'control_acidified', '2',
  'KB1',   'control_nonacidified', '1',
  'KB2',   'control_nonacidified', '2',
  'NA1',   'nutrients_acidified', '1',
  'NA2',   'nutrients_acidified', '2',
  'NB1',   'nutrients_nonacidified', '1',
  'NB2',   'nutrients_nonacidified', '2'
) %>%
  mutate(treatment = factor(treatment)) %>%
  as.data.frame() %>%
  column_to_rownames('sample')

design <- model.matrix(~ 0 + treatment, samples)

contrasts <- makeContrasts(
  'KA-KB' = treatmentcontrol_acidified - treatmentcontrol_nonacidified,
  'NA-NB' = treatmentnutrients_acidified - treatmentnutrients_nonacidified,
  levels  = design
)

# Build a DGEList object
dgelist <- eggnogs %>% 
  filter(taxon == '1|root') %>%
  inner_join(counts, by = 'orf') %>%
  group_by(eggnog, sample) %>%
  summarise(count = sum(count), .groups = 'drop') %>%
  pivot_wider(names_from = sample, values_from = count, values_fill = 0) %>%
  as.data.frame() %>%
  column_to_rownames('eggnog') %>%
  DGEList(groups = samples$treatment) %>%
  calcNormFactors() %>%
  estimateDisp(design)

fit <- glmQLFit(dgelist)

tibble(
  contrast = colnames(contrasts)
) %>%
  mutate(
    test = map(contrast, function(c) glmQLFTest(fit, contrast = contrasts[,c]))
  ) %>%
  mutate(
    top_tags = map(test, function(t) topTags(t, n = 1e9))
  ) %>%
  mutate(
    top_tags_table = map(top_tags, function(tt) tt$table %>% rownames_to_column('eggnog'))
  ) %>%
  unnest(top_tags_table) %>%
  select(-test, -top_tags) %>%
  write_tsv('tables/mst-1_megahit.prokka.without_bbnorm.edger.tsv.gz')
