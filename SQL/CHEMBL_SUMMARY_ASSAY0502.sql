select
    '' as cas, 
    '' as chemical_id,
    '' as chemical_name,
    cpd_molregno as molregno,
    max(target_tax_id) as species_id,
    max(assay_chembl_id as assay_chembl_id,
    '' as species_common_name,
    max(target_organism) as species_latin_name,
    '' as species_group,
    '' as moa_assay_id,
    '' as moa_assay_name,
    '' as assay_function_aop,
    max(target_domain_name) as target_domain_name,
    max(cell_name) as cell_name,
    max(assay_type) as assay_type,
    max(assay_description) as assay_description,
    max(target_type) as target_type,
    '' as gene_id,
    '' as entrez_gene_id,
    max(target_pref_name) as target_pref_name,
    max(activity_standard_type) as activity_standard_type,
    max(activity_standard_relation) as activity_standard_relation,

    PERCENTILE_CONT(0.05) WITHIN GROUP ( ORDER BY activity_pchembl_value ASC) AS EC_RESPONSE_5P,
    PERCENTILE_CONT(0.05) WITHIN GROUP ( ORDER BY activity_pchembl_value ASC) AS EC_RESPONSE_5P,
    PERCENTILE_CONT(0.95) WITHIN GROUP ( ORDER BY activity_pchembl_value  ASC) AS EC_RESPONSE_95P,
    1.96*STDDEV( activity_pchembl_value )  AS EC_RESPONSE_95CI,
    MEDIAN( activity_pchembl_value ) as EC_RESPONSE_MEDIAN,
    AVG ( activity_pchembl_value ) as ec_response_avg,
    STDDEV( activity_pchembl_value)as EC_RESPONSE_STDEV,
    MAX( activity_pchembl_value ) as EC_RESPONSE_MAX,
    MIN( activity_pchembl_value)) AS EC_RESPONSE_MIN,
    AVG ( activity_pchembl_value ) as EC_RESPONSE_TP_MEAN,
  --  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ACTIVITY_STANDARD_UNITS || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as   EC_RESPONSE_UNIT,
    COUNT( activity_pchembl_value ) AS EC_RESPONSE_COUNT

from chembl_assay_extract t

group BY
    cpd_molregno,target_tax_id,assay_chembl_id, target_organism, target_domain_name, cell_name, assay_type, assay_description, target_type, target_pref_name, activity_standard_type, activity_standard_relation
