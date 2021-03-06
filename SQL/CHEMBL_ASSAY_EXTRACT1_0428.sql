create or replace view chembl_summary_assay as
select 
  ACTIVITY_RECORD_ID,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT CPD_MOLREGNO || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  CPD_MOLREGNO,
  max(ACTIVITY_STANDARD_RELATION) AS ACTIVITY_STANDARD_RELATION,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ACTIVITY_STANDARD_VALUE || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  ACTIVITY_STANDARD_VALUE,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ACTIVITY_PCHEMBL_VALUE || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  ACTIVITY_PCHEMBL_VALUE,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ACTIVITY_STANDARD_TYPE || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  ACTIVITY_STANDARD_TYPE,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ACTIVITY_EFFICIACY || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  ACTIVITY_EFFICIACY,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ACTIVITY_STANDARD_UNITS || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  ACTIVITY_STANDARD_UNITS,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ACTIVITY_STANDARD_FLAG || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  ACTIVITY_STANDARD_FLAG,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ACTIVITY_ACTIVITY_COMMENT || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  ACTIVITY_ACTIVITY_COMMENT,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ACTIVITY_DATA_VALIDITY_COMMENT || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  ACTIVITY_DATA_VALIDITY_COMMENT,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ASSAY_DESCRIPTION || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  ASSAY_DESCRIPTION,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ASSAY_TYPE || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  ASSAY_TYPE,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ASSAY_RELATIONSHIP_TYPE || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  ASSAY_RELATIONSHIP_TYPE,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ASSAY_STRAIN || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  ASSAY_STRAIN,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ASSAY_TEST_TYPE || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  ASSAY_TEST_TYPE,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ASSAY_CATEGORY || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  ASSAY_CATEGORY,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ASSAY_CONFIDENCE_SCORE || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  ASSAY_CONFIDENCE_SCORE,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ASSAY_CURATED_BY || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  ASSAY_CURATED_BY,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT TISSUE_NAME || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  TISSUE_NAME,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT CELL_NAME || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  CELL_NAME,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT TARGET_TYPE || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  TARGET_TYPE,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT TARGET_PREF_NAME || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  TARGET_PREF_NAME,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT TARGET_TAX_ID || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  TARGET_TAX_ID,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT TARGET_SPECIES_GROUP_FLAG || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  TARGET_SPECIES_GROUP_FLAG,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT TARGET_DOMAIN_NAME || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  TARGET_DOMAIN_NAME,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT TARGET_DOMAIN_DESC || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  TARGET_DOMAIN_DESC,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT TARGET_COMP_TAX_ID || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  TARGET_COMP_TAX_ID,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT TARGET_COMP_ORGANISM || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  TARGET_COMP_ORGANISM,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT CPD_CHEMBL_ID || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  CPD_CHEMBL_ID,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ASSAY_CHEMBL_ID || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  ASSAY_CHEMBL_ID,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT TISSUE_CHEMBL_ID || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  TISSUE_CHEMBL_ID,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT CELL_CHEMBL_ID || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  CELL_CHEMBL_ID,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT DOC_CHEMBL_ID || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  DOC_CHEMBL_ID,
  
  PERCENTILE_CONT(0.05) WITHIN GROUP ( ORDER BY to_number(ACTIVITY_STANDARD_VALUE) ASC) AS EC_RESPONSE_5P,
  PERCENTILE_CONT(0.05) WITHIN GROUP ( ORDER BY to_number(ACTIVITY_STANDARD_VALUE) ASC) AS EC_RESPONSE_5P,
  PERCENTILE_CONT(0.95) WITHIN GROUP ( ORDER BY to_number(ACTIVITY_STANDARD_VALUE)  ASC) AS EC_RESPONSE_95P,
  1.96*STDDEV( to_number(ACTIVITY_STANDARD_VALUE) )  AS EC_RESPONSE_95CI,
  MEDIAN( to_number(ACTIVITY_STANDARD_VALUE) ) as EC_RESPONSE_MEDIAN,
  AVG ( to_number(ACTIVITY_STANDARD_VALUE) ) as ec_response_avg,
  STDDEV( to_number(ACTIVITY_STANDARD_VALUE) )as EC_RESPONSE_STDEV,
  MAX( to_number(ACTIVITY_STANDARD_VALUE) ) as EC_RESPONSE_MAX,
  MIN( to_number(ACTIVITY_STANDARD_VALUE) ) AS EC_RESPONSE_MIN,
  AVG ( to_number(ACTIVITY_STANDARD_VALUE) ) as EC_RESPONSE_TP_MEAN,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT ACTIVITY_STANDARD_UNITS || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as   EC_RESPONSE_UNIT,
  COUNT( to_number(ACTIVITY_STANDARD_VALUE) ) AS EC_RESPONSE_COUNT,

  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT target_organism || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  target_organism,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT protein_short_name || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  protein_short_name,
  replace(rm_same_str(RTRIM(XMLAGG(XMLPARSE(CONTENT target_comp_acc || ',' WELLFORMED)) .GETCLOBVAL(), ','),','),',',';') as  target_comp_acc,

  ' ' AS INVALID

from chembl_assay_pre v
group by v.ACTIVITY_RECORD_ID

