select
    '' as cas, 
    '' as chemical_id,
    '' as chemical_name,
    replace(rm_same_str(strcat_clob(cpd_molregno),','),',',';') as  molregno,
    ACTIVITY_RECORD_ID,
    replace(rm_same_str(strcat_clob(target_tax_id),','),',',';') as  species_id,
    replace(rm_same_str(strcat_clob(assay_chembl_id),','),',',';') as  assay_chembl_id,
    '' as species_common_name,
    replace(rm_same_str(strcat_clob(target_organism),','),',',';') as  species_latin_name,
    '' as species_group,
    '' as moa_assay_id,
    '' as moa_assay_name,
    '' as assay_function_aop,
    replace(rm_same_str(strcat_clob(target_domain_name),','),',',';') as  target_domain_name,
    replace(rm_same_str(strcat_clob(cell_name),','),',',';') as  cell_name,
    replace(rm_same_str(strcat_clob(assay_type),','),',',';') as  assay_type,
    replace(rm_same_str(strcat_clob(assay_description),','),',',';') as  assay_description,
    replace(rm_same_str(strcat_clob(target_type),','),',',';') as  target_type,
    '' as gene_id,
    '' as entrez_gene_id,
    replace(rm_same_str(strcat_clob(target_pref_name),','),',',';') as  target_pref_name,
    replace(rm_same_str(strcat_clob(activity_standard_type),','),',',';') as  activity_standard_type,
    replace(rm_same_str(strcat_clob(activity_standard_relation),','),',',';') as  activity_standard_relation,
    PERCENTILE_CONT(0.05) WITHIN GROUP ( ORDER BY to_number(ACTIVITY_STANDARD_VALUE) ASC) AS EC_RESPONSE_5P,
  PERCENTILE_CONT(0.95) WITHIN GROUP ( ORDER BY to_number(ACTIVITY_STANDARD_VALUE)  ASC) AS EC_RESPONSE_95P,
  1.96*STDDEV( to_number(ACTIVITY_STANDARD_VALUE) )  AS EC_RESPONSE_95CI,
  MEDIAN( to_number(ACTIVITY_STANDARD_VALUE) ) as EC_RESPONSE_MEDIAN,
  AVG ( to_number(ACTIVITY_STANDARD_VALUE) ) as ec_response_avg,
  STDDEV( to_number(ACTIVITY_STANDARD_VALUE) )as EC_RESPONSE_STDEV,
  MAX( to_number(ACTIVITY_STANDARD_VALUE) ) as EC_RESPONSE_MAX,
  MIN( to_number(ACTIVITY_STANDARD_VALUE) ) AS EC_RESPONSE_MIN,
  AVG ( to_number(ACTIVITY_STANDARD_VALUE) ) as EC_RESPONSE_TP_MEAN,
  replace(rm_same_str(strcat_clob(ACTIVITY_STANDARD_UNITS),','),',',';') as  EC_RESPONSE_UNIT,
  COUNT( to_number(ACTIVITY_STANDARD_VALUE) ) AS EC_RESPONSE_COUNT

from chembl_assay_extract2 t

group by t.ACTIVITY_RECORD_ID, t.assay_chembl_id


