create or replace view chembl_summary_assay as
select
  '' as cas, 
  '' as chemical_id,
  '' as chemical_name,
  b.cpd_molregno as molregno,
  b.target_tax_id as species_id,
  '' as species_common_name,
  b.target_organism as species_latin_name,
  '' as species_group,
  '' as moa_assay_id,
  '' as moa_assay_name,
  '' as assay_function_aop,
  b.target_domain_name as target_domain_name,
  b.cell_name as cell_name,
  b.assay_type as assay_type,
  b.assay_description as assay_description,
  b.target_type as target_type,
  '' as gene_id,
  '' as entrez_gene_id,
  b.target_pref_name as target_pref_name,
  b.protein_short_name as protein_short_name,
  b.target_comp_acc as target_comp_acc
  b.activity_standard_type as activity_standard_type,
  b.activity_standard_relation as activity_standard_relation,
   ec_response_neg,

   PERCENTILE_CONT(0.05) WITHIN GROUP ( ORDER BY activity_standard_value ASC) AS EC_RESPONSE_5P ,
    ( case when b.activity_pchembl_value is not null then b.activity_standard_value else null end)  ec_response_5p,
    ( case when b.activity_pchembl_value is not null then b.activity_standard_value else null end)  ec_response_95p,
    ( case when b.activity_pchembl_value is not null then b.activity_standard_value else null end)  ec_response_95ci,
    ( case when b.activity_pchembl_value is not null then b.activity_standard_value else null end)  ec_response_median,
    ( case when b.activity_pchembl_value is not null then b.activity_standard_value else null end)  ec_response_avg,
    ( case when b.activity_pchembl_value is not null then b.activity_standard_value else null end)  ec_response_stdev,
    ( case when b.activity_pchembl_value is not null then b.activity_standard_value else null end)  ec_response_max,
    ( case when b.activity_pchembl_value is not null then b.activity_standard_value else null end)  ec_response_min,
    ( case when b.activity_pchembl_value is not null then b.activity_standard_value else null end)  ec_response_tp_mean,
    ( case when b.activity_standard_value = 'efficacy' then b.standard_value else null end)  ec_response_unit,
    ( case when b.activity_pchembl_value is not null then b.activity_standard_value else null end)  ec_response_count
from
    chembl_extract1_m b
where 
  a.species_id  = b.TARGET_TAX_ID