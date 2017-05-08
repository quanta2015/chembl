-- create or replace view chembl_summary_assay as

select
    '' as cas, 
  '' as chemical_id,
  '' as chemical_name,
  cpd_molregno as molregno,
  target_tax_id as species_id,
  '' as species_common_name,
  -- target_organism as species_latin_name,
  '' as species_group,
  '' as moa_assay_id,
  '' as moa_assay_name,
  '' as assay_function_aop,
  target_domain_name as target_domain_name,
  cell_name as cell_name,
  assay_type as assay_type,
  assay_description as assay_description,
  target_type as target_type,
  '' as gene_id,
  '' as entrez_gene_id,
  target_pref_name as target_pref_name,
  -- protein_short_name as protein_short_name,
  -- target_comp_acc as target_comp_acc
  activity_standard_type as activity_standard_type,
  activity_standard_relation as activity_standard_relation,
  ec_response_neg,
  ec_response_5p,
  ec_response_95p,
  ec_response_95ci,
  ec_response_median,
  ec_response_avg,
  ec_response_stdev,
  ec_response_max,
  ec_response_min,
  ec_response_tp_mean,
  ec_response_unit,
  ec_response_count
from
    v_assay_extract1



