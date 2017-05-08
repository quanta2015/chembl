-- create or replace view chembl_assay_extract as

drop table v_chembl_assay_extract; 
create table v_chembl_assay_extract as

select 
  activity_id,
  cpd_molregno,
  min(activity_record_id) as  activity_record_id,
  assay_chembl_id,
  min(activity_standard_relation) as  activity_standard_relation,
  rm_same_str(strcat_clob(activity_standard_value),',') as  activity_standard_value,
  min(activity_pchembl_value) as  activity_pchembl_value,
  min(activity_standard_type) as  activity_standard_type,
  min(activity_efficiacy) as  activity_efficiacy,
  min(activity_standard_units) as  activity_standard_units,
  min(activity_standard_flag) as  activity_standard_flag,
  min(activity_activity_comment) as  activity_activity_comment,
  min(activity_data_validity_comment) as  activity_data_validity_comment,
  min(activity_potential_duplicate) as  activity_potential_duplicate,
  min(assay_description) as  assay_description,
  min(assay_type) as  assay_type,
  min(assay_strain) as  assay_strain,
  min(assay_strain) as  assay_test_type,
  min(assay_strain) as  assay_category,
  min(assay_strain) as  assay_confidence_score,
  min(assay_strain) as  assay_curated_by,
  min(tissue_name) as  tissue_name,
  min(cell_name) as  cell_name,
  min(target_type) as  target_type,
  min(target_pref_name) as  target_pref_name,
  min(target_tax_id) as  target_tax_id,
  min(target_organism) as  target_organism,
  min(target_species_group_flag) as  target_species_group_flag,
  min(target_domain_name) as  target_domain_name,
  min(target_domain_desc) as  target_domain_desc,
  min(target_comp_type) as  target_comp_type,
  min(target_comp_tax_id) as  target_comp_tax_id,
  min(target_comp_organism) as  target_comp_organism,
  min(cpd_chembl_id) as  cpd_chembl_id,
  min(tissue_chembl_id) as  tissue_chembl_id,
  min(cell_chembl_id) as  cell_chembl_id,
  min(doc_chembl_id) as  doc_chembl_id,
  '  ' as invalid

from  v_chembl_assay_pre t 

group by cpd_molregno, assay_chembl_id, activity_id, activity_standard_type
