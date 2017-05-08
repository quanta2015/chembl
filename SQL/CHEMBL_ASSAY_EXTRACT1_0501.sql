create table v_chembl_assay_extract as (

select 
  rm_same_strv(WM_CONCAT(ACTIVITY_ID),',') as  ACTIVITY_ID,
  -- rm_same_str(strcat_clob(ACTIVITY_ID),',') as  ACTIVITY_ID,
  CPD_MOLREGNO,
  rm_same_str(strcat_clob(ACTIVITY_RECORD_ID),',') as  ACTIVITY_RECORD_ID,
  ASSAY_CHEMBL_ID,
  rm_same_str(strcat_clob(ACTIVITY_STANDARD_RELATION),',') as  ACTIVITY_STANDARD_RELATION,
  rm_same_str(strcat_clob(ACTIVITY_STANDARD_VALUE),',') as  ACTIVITY_STANDARD_VALUE,
  rm_same_str(strcat_clob(ACTIVITY_PCHEMBL_VALUE),',') as  ACTIVITY_PCHEMBL_VALUE,
  rm_same_str(strcat_clob(ACTIVITY_STANDARD_TYPE),',') as  ACTIVITY_STANDARD_TYPE,
  rm_same_str(strcat_clob(ACTIVITY_EFFICIACY),',') as  ACTIVITY_EFFICIACY,
  rm_same_str(strcat_clob(ACTIVITY_STANDARD_UNITS),',') as  ACTIVITY_STANDARD_UNITS,
  rm_same_str(strcat_clob(ACTIVITY_STANDARD_FLAG),',') as  ACTIVITY_STANDARD_FLAG,
  rm_same_str(strcat_clob(ACTIVITY_ACTIVITY_COMMENT),',') as  ACTIVITY_ACTIVITY_COMMENT,
  rm_same_str(strcat_clob(ACTIVITY_DATA_VALIDITY_COMMENT),',') as  ACTIVITY_DATA_VALIDITY_COMMENT,
  rm_same_str(strcat_clob(ACTIVITY_POTENTIAL_DUPLICATE),',') as  ACTIVITY_POTENTIAL_DUPLICATE,
  rm_same_str(strcat_clob(ASSAY_DESCRIPTION),',') as  ASSAY_DESCRIPTION,
  rm_same_str(strcat_clob(ASSAY_TYPE),',') as  ASSAY_TYPE,
  rm_same_str(strcat_clob(ASSAY_STRAIN),',') as  ASSAY_STRAIN,
  rm_same_str(strcat_clob(ASSAY_STRAIN),',') as  ASSAY_TEST_TYPE,
  rm_same_str(strcat_clob(ASSAY_STRAIN),',') as  ASSAY_CATEGORY,
  rm_same_str(strcat_clob(ASSAY_STRAIN),',') as  ASSAY_CONFIDENCE_SCORE,
  rm_same_str(strcat_clob(ASSAY_STRAIN),',') as  ASSAY_CURATED_BY,
  rm_same_str(strcat_clob(TISSUE_NAME),',') as  TISSUE_NAME,
  rm_same_str(strcat_clob(CELL_NAME),',') as  CELL_NAME,
  rm_same_str(strcat_clob(TARGET_TYPE),',') as  TARGET_TYPE,
  rm_same_str(strcat_clob(TARGET_PREF_NAME),',') as  TARGET_PREF_NAME,
  rm_same_str(strcat_clob(TARGET_TAX_ID),',') as  TARGET_TAX_ID,
  rm_same_str(strcat_clob(TARGET_ORGANISM),',') as  TARGET_ORGANISM,
  rm_same_str(strcat_clob(TARGET_SPECIES_GROUP_FLAG),',') as  TARGET_SPECIES_GROUP_FLAG,
  rm_same_str(strcat_clob(TARGET_DOMAIN_NAME),',') as  TARGET_DOMAIN_NAME,
  rm_same_str(strcat_clob(TARGET_DOMAIN_DESC),',') as  TARGET_DOMAIN_DESC,
  rm_same_str(strcat_clob(TARGET_COMP_TYPE),',') as  TARGET_COMP_TYPE,
  rm_same_str(strcat_clob(TARGET_COMP_TAX_ID),',') as  TARGET_COMP_TAX_ID,
  rm_same_str(strcat_clob(TARGET_COMP_ORGANISM),',') as  TARGET_COMP_ORGANISM,
  rm_same_str(strcat_clob(CPD_CHEMBL_ID),',') as  CPD_CHEMBL_ID,
  rm_same_str(strcat_clob(TISSUE_CHEMBL_ID),',') as  TISSUE_CHEMBL_ID,
  rm_same_str(strcat_clob(CELL_CHEMBL_ID),',') as  CELL_CHEMBL_ID,
  rm_same_str(strcat_clob(DOC_CHEMBL_ID),',') as  DOC_CHEMBL_ID,
  -- rm_same_str(strcat_clob(PROTEIN_SHORT_NAME),',') as  PROTEIN_SHORT_NAME,
  -- rm_same_str(strcat_clob(TARGET_COMP_ACC),',') as  TARGET_COMP_ACC,
  rm_same_str(strcat_clob(EC_RESPONSE_NEG),',') as  EC_RESPONSE_NEG

from v_chembl_assay_pre t 

group by CPD_MOLREGNO, ASSAY_CHEMBL_ID
 
)

