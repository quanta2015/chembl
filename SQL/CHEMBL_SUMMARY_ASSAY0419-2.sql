create or replace view chembl_summary_assay as
select
  a.cas as cas, 
  a.chemical_id as chemical_id,
  a.chemical_name as chemical_name,
  b.cpd_molregno as molregno,
  b.target_tax_id as species_id,
  a.species_common_name as species_common_name,
  b.target_organism as species_latin_name,
  a.species_group as species_group,
  a.moa_assay_id as moa_assay_id,
  a.moa_assay_name as moa_assay_name,
  a.assay_function_aop as assay_function_aop,
  b.target_domain_name as target_domain_name,
  b.cell_name as cell_name,
  b.assay_type as assay_type,
  b.assay_description as assay_description,
  b.target_type as target_type,
  a.gene_id as gene_id,
  a.entrez_gene_id as entrez_gene_id,
  b.target_pref_name as target_pref_name,
  b.protein_short_name as protein_short_name,
  b.target_comp_acc as target_comp_acc
  b.activity_standard_type as activity_standard_type,
  b.activity_standard_relation as activity_standard_relation,
   ( case when b.activity_standard_relation='>' then b.activity_standard_value else null end)  ec_response_neg,
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
    toxcast_extract1_m a, chembl_extract2_m b
where 
  a.species_id  = b.TARGET_TAX_ID