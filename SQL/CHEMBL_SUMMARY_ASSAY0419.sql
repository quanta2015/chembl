CREATE OR REPLACE VIEW CHEMBL_SUMMARY_ASSAY AS
SELECT
  a.molregno as molregno,
  replace(rm_same_str(strcat_clob(a.TARGET_TAX_ID),','),',',';') as  TARGET_TAX_ID,
  replace(rm_same_str(strcat_clob(a.target_organism),','),',',';') as  target_organism,
  replace(rm_same_str(strcat_clob(a.target_domain_name),','),',',';') as  target_domain_name,
  replace(rm_same_str(strcat_clob(a.cell_name),','),',',';') as  cell_name,
  replace(rm_same_str(strcat_clob(a.assay_type),','),',',';') as  assay_type,
  replace(rm_same_str(strcat_clob(a.assay_description),','),',',';') as  assay_description,
  replace(rm_same_str(strcat_clob(a.target_type),','),',',';') as  target_type,
  replace(rm_same_str(strcat_clob(a.target_pref_name),','),',',';') as  target_pref_name,
  replace(rm_same_str(strcat_clob(a.protein_short_name),','),',',';') as  protein_short_name,
  replace(rm_same_str(strcat_clob(a.target_comp_acc),','),',',';') as  target_comp_acc,
  replace(rm_same_str(strcat_clob(a.activity_standard_type),','),',',';') as  activity_standard_type,
  replace(rm_same_str(strcat_clob(a.activity_standard_relation),','),',',';') as  activity_standard_relation,
  max(a.EC_RESPONSE_NEG) as  EC_RESPONSE_NEG,
  max(a.EC_RESPONSE_5P) as  EC_RESPONSE_5P,
  max(a.EC_RESPONSE_95P) as  EC_RESPONSE_95P,
  max(a.EC_RESPONSE_95CI) as  EC_RESPONSE_95CI,
  max(a.EC_RESPONSE_MEDIAN) as  EC_RESPONSE_MEDIAN,
  max(a.EC_RESPONSE_AVG) as  EC_RESPONSE_AVG,
  max(a.EC_RESPONSE_STDEV) as  EC_RESPONSE_STDEV,
  max(a.EC_RESPONSE_MAX) as  EC_RESPONSE_MAX,
  max(a.EC_RESPONSE_MIN) as  EC_RESPONSE_MIN,
  -- max(a.ACTIVITY_EFFICIACY) as  EC_RESPONSE_TP_AVG,
  replace(rm_same_str(strcat_clob(a.ACTIVITY_EFFICIACY),','),',',';') as  ACTIVITY_EFFICIACY,
  count(*) as  EC_RESPONSE_COUNT,
  max(a.EC_RESPONSE_UNIT) as  EC_RESPONSE_UNIT

FROM
    VIEW_CHEMBL_ASSAY_EXTRACT2 a
GROUP BY
    a.molregno
;
