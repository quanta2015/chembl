### Static Table With Filter Model
1 . Join all the table with condition( **a.activity_id < 32000 and a.activity_id > 31500 ** ) and create a temp table named as `v_ACTIVITY`
```sql
drop table v_ACTIVITY; 
create table v_ACTIVITY as(
SELECT
      A.ACTIVITY_ID as ACTIVITY_ID,
      A.RECORD_ID AS ACTIVITY_RECORD_ID,
      A.MOLREGNO AS CPD_MOLREGNO,
      g.CHEMBL_ID as CPD_CHEMBL_ID,
      A.STANDARD_RELATION AS ACTIVITY_STANDARD_RELATION,
      A.STANDARD_VALUE AS ACTIVITY_STANDARD_VALUE,
      A.STANDARD_UNITS AS ACTIVITY_STANDARD_UNITS,
      A.STANDARD_FLAG AS ACTIVITY_STANDARD_FLAG,
      A.STANDARD_TYPE AS ACTIVITY_STANDARD_TYPE,
      A.ACTIVITY_COMMENT as ACTIVITY_ACTIVITY_COMMENT,
      A.DATA_VALIDITY_COMMENT AS ACTIVITY_DATA_VALIDITY_COMMENT,
      A.POTENTIAL_DUPLICATE AS ACTIVITY_POTENTIAL_DUPLICATE,
      a.PCHEMBL_VALUE  as ACTIVITY_PCHEMBL_VALUE,
      H.CHEMBL_ID as DOC_CHEMBL_ID,
      B.DESCRIPTION AS ASSAY_DESCRIPTION,
      d.ASSAY_DESC as ASSAY_TYPE,
      B.RELATIONSHIP_TYPE AS ASSAY_RELATIONSHIP_TYPE,
      B.ASSAY_TAX_ID AS ASSAY_TAX_ID,
      B.ASSAY_ORGANISM as ASSAY_ORGANISM,
      B.ASSAY_STRAIN as ASSAY_STRAIN,
      B.ASSAY_TEST_TYPE as ASSAY_TEST_TYPE,
      B.ASSAY_CATEGORY as ASSAY_CATEGORY,
      B.CONFIDENCE_SCORE AS ASSAY_CONFIDENCE_SCORE,
      b.CURATED_BY as ASSAY_CURATED_BY,
      B.CHEMBL_ID AS ASSAY_CHEMBL_ID,
      I.PREF_NAME as TISSUE_NAME,
      I.CHEMBL_ID as TISSUE_CHEMBL_ID,
      J.CELL_NAME as CELL_NAME,
      J.CHEMBL_ID as CELL_CHEMBL_ID,
      K.TARGET_TYPE as TARGET_TYPE,
      K.PREF_NAME AS TARGET_PREF_NAME,
      K.TAX_ID AS TARGET_TAX_ID,
      K.ORGANISM AS TARGET_ORGANISM,
      K.SPECIES_GROUP_FLAG AS TARGET_SPECIES_GROUP_FLAG,
      O.DOMAIN_NAME as TARGET_DOMAIN_NAME,
      O.DOMAIN_DESCRIPTION as TARGET_DOMAIN_DESC,
      M.COMPONENT_TYPE AS TARGET_COMP_TYPE,
      M.TAX_ID AS TARGET_COMP_TAX_ID,
      M.ORGANISM AS TARGET_COMP_ORGANISM,
      C.SHORT_NAME as PROTEIN_SHORT_NAME,
      C.DEFINITION AS PROTEIN_DEFINITION,
      C.CLASS_LEVEL AS PROTEIN_CLASS_LEVEL,
      L.HOMOLOGUE as TARGET_HOMOLOGUE,
      K.CHEMBL_ID AS TARGET_CHEMBL_ID,
      M.DESCRIPTION AS TARGET_COMP_DESC,
      M.ACCESSION AS TARGET_COMP_ACC,
      P.GO_ID as TARGET_COMP_GO_ID,
      Q.PATH as TARGET_COMP_GO_PATH
    FROM
        (((((((((((((((((ACTIVITIES A LEFT OUTER JOIN ASSAYS B ON A.ASSAY_ID = B.ASSAY_ID) 
        LEFT OUTER JOIN ASSAY_TYPE D ON D.ASSAY_TYPE = B.ASSAY_TYPE)
        LEFT OUTER JOIN BINDING_SITES E ON E.TID = B.TID)
        LEFT OUTER JOIN VIEW_COMPOUND_RECORDS F ON F.MOLREGNO = A.MOLREGNO)
        LEFT OUTER JOIN MOLECULE_DICTIONARY g ON g.MOLREGNO = a.MOLREGNO)
        LEFT OUTER JOIN DOCS H ON H.DOC_ID = A.DOC_ID)
        LEFT OUTER JOIN TISSUE_DICTIONARY I ON I.TISSUE_ID = B.TISSUE_ID)
        LEFT OUTER JOIN CELL_DICTIONARY J ON J.CELL_ID = B.CELL_ID)
        LEFT OUTER JOIN TARGET_DICTIONARY K ON K.TID = B.TID)
        LEFT OUTER JOIN TARGET_COMPONENTS L ON L.TID = K.TID)
        LEFT OUTER JOIN COMPONENT_SEQUENCES M ON M.COMPONENT_ID = L.COMPONENT_ID)
        LEFT OUTER JOIN SITE_COMPONENTS N ON N.COMPONENT_ID = M.COMPONENT_ID)
        LEFT OUTER JOIN domains O ON O.DOMAIN_ID = N.DOMAIN_ID)
        LEFT OUTER JOIN component_go P ON P.COMPONENT_ID = M.COMPONENT_ID)
        LEFT OUTER JOIN GO_CLASSIFICATION Q ON Q.GO_ID  = P.GO_ID)
        LEFT OUTER JOIN COMPONENT_CLASS R ON R.COMPONENT_ID = M.COMPONENT_ID)
        LEFT OUTER JOIN PROTEIN_CLASSIFICATION C ON C.PROTEIN_CLASS_ID = R.PROTEIN_CLASS_ID)
   where a.activity_id < 32000 and a.activity_id > 31500
)
```

2 . Merge the data in  `v_ACTIVITY` to a view named as `CHEMBL_ACTIVITY_ST`
```sql
CREATE OR REPLACE VIEW CHEMBL_ACTIVITY_ST AS
SELECT
  a.activity_id,
  max(a.activity_record_id) as  activity_record_id,
  max(a.cpd_molregno) as  cpd_molregno,
  max(a.cpd_chembl_id) as  cpd_chembl_id,
  max(a.activity_standard_relation) as  activity_standard_relation,
  max(a.activity_standard_value) as  activity_standard_value,
  max(a.activity_standard_units) as  activity_standard_units,
  max(a.activity_standard_flag) as  activity_standard_flag,
  max(a.activity_standard_type) as  activity_standard_type,
  max(a.activity_activity_comment) as  activity_activity_comment,
  max(a.activity_data_validity_comment) as  activity_data_validity_comment,
  max(a.activity_potential_duplicate) as  activity_potential_duplicate,
  max(a.activity_pchembl_value) as  activity_pchembl_value,
  max(a.doc_chembl_id) as  doc_chembl_id,
  max(a.assay_description) as  assay_description,
  max(a.assay_type) as  assay_type,
  max(a.assay_relationship_type) as  assay_relationship_type,
  max(a.assay_tax_id) as  assay_tax_id,
  max(a.assay_organism) as  assay_organism,
  max(a.assay_strain) as  assay_strain,
  max(a.assay_test_type) as  assay_test_type,
  max(a.assay_category) as  assay_category,
  max(a.assay_confidence_score) as  assay_confidence_score,
  max(a.assay_curated_by) as  assay_curated_by,
  max(a.assay_chembl_id) as  assay_chembl_id,
  max(a.tissue_name) as  tissue_name,
  max(a.tissue_chembl_id) as  tissue_chembl_id,
  max(a.cell_name) as  cell_name,
  max(a.cell_chembl_id) as  cell_chembl_id,
  max(a.target_type) as  target_type,
  max(a.target_pref_name) as  target_pref_name,
  max(a.target_tax_id) as  target_tax_id,
  max(a.target_organism) as  target_organism,
  max(a.target_species_group_flag) as  target_species_group_flag,
  max(a.target_domain_name) as  target_domain_name,
  max(a.target_domain_desc) as  target_domain_desc,
  max(a.target_comp_type) as  target_comp_type,
  max(a.target_comp_tax_id) as  target_comp_tax_id,
  max(a.target_comp_organism) as  target_comp_organism,
  max(a.protein_short_name) as  protein_short_name,
  max(a.protein_definition) as  protein_definition,
  max(a.protein_class_level) as  protein_class_level,
  max(a.target_homologue) as  target_homologue,
  max(a.target_chembl_id) as  target_chembl_id,
  strcat_clob(a.target_comp_desc) as  target_comp_desc,
  strcat_clob(a.target_comp_acc) as  target_comp_acc,
  strcat_clob(a.target_comp_go_id) as  target_comp_go_id,
  strcat_clob(a.target_comp_go_path) as  target_comp_go_path
FROM
    V_activity a
GROUP BY
    a.activity_id;

```