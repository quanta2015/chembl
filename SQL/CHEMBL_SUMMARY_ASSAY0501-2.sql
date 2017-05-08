select
    '' as cas, 
    '' as chemical_id,
    '' as chemical_name,
    cpd_molregno as molregno,
    target_tax_id as species_id,
    assay_chembl_id as assay_chembl_id,
    '' as species_common_name,
    target_organism as species_latin_name,
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
    t.activity_standard_type as activity_standard_type,
    t.activity_standard_relation as activity_standard_relation,
    ( case when t.activity_standard_relation='>' then to_char( t.activity_standard_value) else null end)  ec_response_neg,
    ( case when t.activity_pchembl_value is not null then to_char( t.activity_standard_value ) else null end)  ec_response_5p,
    ( case when t.activity_pchembl_value is not null then to_char( t.activity_standard_value ) else null end)  ec_response_95p,
    ( case when t.activity_pchembl_value is not null then to_char( t.activity_standard_value ) else null end)  ec_response_95ci,
    ( case when t.activity_pchembl_value is not null then to_char( t.activity_standard_value ) else null end)  ec_response_median,
    ( case when t.activity_pchembl_value is not null then to_char( t.activity_standard_value ) else null end)  ec_response_avg,
    ( case when t.activity_pchembl_value is not null then to_char( t.activity_standard_value ) else null end)  ec_response_stdev,
    ( case when t.activity_pchembl_value is not null then to_char( t.activity_standard_value ) else null end)  ec_response_max,
    ( case when t.activity_pchembl_value is not null then to_char( t.activity_standard_value ) else null end)  ec_response_min,
    ( case when t.activity_pchembl_value is not null then to_char( t.activity_standard_value ) else null end)  ec_response_tp_mean,
    ( case when to_char(t.activity_standard_type) = 'efficacy' then to_char( t.activity_standard_value ) else null end)  ec_response_unit,
    ( case when t.activity_pchembl_value is not null then to_char( t.activity_standard_value ) else null end)  ec_response_count
from chembl_assay_extract2 t

