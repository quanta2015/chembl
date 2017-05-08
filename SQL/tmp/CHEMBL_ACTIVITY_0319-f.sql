create or replace view view_components as
select a.tid,
       a.component_id,
       a.targcomp_id,
       a.homologue,
       b.component_type,
       b.accession,
       b.sequence,
       b.sequence_md5sum,
       b.description,
       b.tax_id,
       b.organism,
       b.db_source,
       b.db_version,
       c.sitecomp_id,
       c.site_id,
       c.domain_id,
       c.site_residues,
       d.domain_type,
       d.source_domain_id,
       d.domain_name,
       d.domain_description,
       e.comp_go_id,
       e.go_id,
       f.parent_go_id,
       f.pref_name,
       f.class_level,
       f.aspect,
       f.path,
       g.protein_class_id,
       g.comp_class_id,
       h.parent_id,
       h.short_name,
       h.protein_class_desc,
       h.definition
 from
       (((((((TARGET_COMPONENTS a
 LEFT OUTER JOIN COMPONENT_SEQUENCES b ON b.COMPONENT_ID = a.COMPONENT_ID)
 LEFT OUTER JOIN SITE_COMPONENTS c ON c.COMPONENT_ID = a.COMPONENT_ID)
 LEFT OUTER JOIN domains d ON d.DOMAIN_ID =c.DOMAIN_ID)
LEFT OUTER JOIN component_go e ON e.COMPONENT_ID = a.COMPONENT_ID)
LEFT OUTER JOIN GO_CLASSIFICATION f ON f.GO_ID  = e.GO_ID)
LEFT OUTER JOIN COMPONENT_CLASS g ON g.COMPONENT_ID = a.COMPONENT_ID)
LEFT OUTER JOIN PROTEIN_CLASSIFICATION h ON h.PROTEIN_CLASS_ID = g.PROTEIN_CLASS_ID);



CREATE OR REPLACE VIEW VIEW_COMPONENTS_G AS
SELECT
            a.TID,
            StrClear(REPLACE(XMLAGG(XMLPARSE(CONTENT a.HOMOLOGUE || ',' WELLFORMED)) .GETCLOBVAL(), ',')) HOMOLOGUE,
            StrClear(REPLACE(RTRIM(XMLAGG(XMLPARSE(CONTENT a.DOMAIN_NAME || ',' WELLFORMED)) .GETCLOBVAL(), ','),',',';')) DOMAIN_NAME,
            StrClear(REPLACE(RTRIM(XMLAGG(XMLPARSE(CONTENT a.DOMAIN_DESCRIPTION || ',' WELLFORMED)) .GETCLOBVAL(), ','),',',';')) DOMAIN_DESCRIPTION,
            StrClear(REPLACE(RTRIM(XMLAGG(XMLPARSE(CONTENT a.COMPONENT_TYPE || ',' WELLFORMED)) .GETCLOBVAL(), ','),',',';')) COMPONENT_TYPE,
            StrClear(REPLACE(RTRIM(XMLAGG(XMLPARSE(CONTENT a.TAX_ID || ',' WELLFORMED)) .GETCLOBVAL(), ','),',',';')) TAX_ID,
            StrClear(REPLACE(RTRIM(XMLAGG(XMLPARSE(CONTENT a.ORGANISM || ',' WELLFORMED)) .GETCLOBVAL(), ','),',',';')) ORGANISM,
            StrClear(REPLACE(RTRIM(XMLAGG(XMLPARSE(CONTENT a.SHORT_NAME || ',' WELLFORMED)) .GETCLOBVAL(), ','),',',';')) SHORT_NAME,
           -- REPLACE(RTRIM(XMLAGG(XMLPARSE(CONTENT a.DEFINITION || ',' WELLFORMED)) .GETCLOBVAL(), ','),',',';') DEFINITION,
            StrClear(REPLACE(WM_CONCAT(CLASS_LEVEL),',',';')) as  CLASS_LEVEL,
            REPLACE(RTRIM(XMLAGG(XMLPARSE(CONTENT a.ACCESSION || ',' WELLFORMED)) .GETCLOBVAL(), ','),',',';') ACCESSION,
            REPLACE(RTRIM(XMLAGG(XMLPARSE(CONTENT a.GO_ID || ',' WELLFORMED)) .GETCLOBVAL(), ','),',',';') GO_ID,
            REPLACE(RTRIM(XMLAGG(XMLPARSE(CONTENT a.PATH || ',' WELLFORMED)) .GETCLOBVAL(), ','),',',';') PATH,
            REPLACE(RTRIM(XMLAGG(XMLPARSE(CONTENT a.DESCRIPTION || ',' WELLFORMED)) .GETCLOBVAL(), ','),',',';') DESCRIPTION
        FROM
            VIEW_COMPONENTS a
        GROUP BY
            a.TID;


CREATE OR REPLACE VIEW CHEMBL_ACTIVITY AS
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
      L.DOMAIN_NAME as TARGET_DOMAIN_NAME,
      L.DOMAIN_DESCRIPTION as TARGET_DOMAIN_DESC,
      L.COMPONENT_TYPE AS TARGET_COMP_TYPE,
      L.TAX_ID AS TARGET_COMP_TAX_ID,
      L.ORGANISM AS TARGET_COMP_ORGANISM,
      L.SHORT_NAME as PROTEIN_SHORT_NAME,
   --  L.DEFINITION AS PROTEIN_DEFINITION,
     L.CLASS_LEVEL AS PROTEIN_CLASS_LEVEL,

      L.HOMOLOGUE as TARGET_HOMOLOGUE,
      K.CHEMBL_ID AS TARGET_CHEMBL_ID,


      L.DESCRIPTION AS TARGET_COMP_DESC,
      L.ACCESSION AS TARGET_COMP_ACC,
      L.GO_ID as TARGET_COMP_GO_ID,
      L.PATH as TARGET_COMP_GO_PATH
      '' as Vaild
    FROM
        ((((((((((ACTIVITIES A LEFT OUTER JOIN ASSAYS B ON A.ASSAY_ID = B.ASSAY_ID)
        
        LEFT OUTER JOIN ASSAY_TYPE D ON D.ASSAY_TYPE = B.ASSAY_TYPE)
        LEFT OUTER JOIN BINDING_SITES E ON E.TID = B.TID)
        LEFT OUTER JOIN VIEW_COMPOUND_RECORDS F ON F.MOLREGNO = A.MOLREGNO)
        LEFT OUTER JOIN MOLECULE_DICTIONARY g ON g.MOLREGNO = a.MOLREGNO)
        LEFT OUTER JOIN DOCS H ON H.DOC_ID = A.DOC_ID)
        LEFT OUTER JOIN TISSUE_DICTIONARY I ON I.TISSUE_ID = B.TISSUE_ID)
        LEFT OUTER JOIN CELL_DICTIONARY J ON J.CELL_ID = B.CELL_ID)
        LEFT OUTER JOIN TARGET_DICTIONARY K ON K.TID = B.TID)
        LEFT OUTER JOIN VIEW_COMPONENTS_G L ON L.TID = K.TID)


