CREATE OR REPLACE VIEW EXTRACT1_M AS
SELECT
      A.ACTIVITY_ID as ACTIV#ACTIVITY_ID,
      A.ASSAY_ID AS ACTIV#ASSAY_ID,
      A.DOC_ID AS ACTIV#DOC_ID,
      A.RECORD_ID AS ACTIV#RECORD_ID,
      A.MOLREGNO AS ACTIV#MOLREGNO,
      A.STANDARD_RELATION AS ACTIV#STANDARD_RELATION,
      A.PUBLISHED_VALUE AS ACTIV#PUBLISHED_VALUE,
      A.PUBLISHED_UNITS AS ACTIV#PUBLISHED_UNITS,
      A.STANDARD_VALUE AS ACTIV#STANDARD_VALUE,
      A.STANDARD_UNITS AS ACTIV#STANDARD_UNITS,
      A.STANDARD_FLAG AS ACTIV#STANDARD_FLAG,
      A.STANDARD_TYPE AS ACTIV#STANDARD_TYPE,
      A.ACTIVITY_COMMENT as ACTIV#ACTIVITY_COMMENT,
      A.PUBLISHED_TYPE AS ACTIV#PUBLISHED_TYPE,
      A.DATA_VALIDITY_COMMENT AS ACTIV#DATA_VALIDITY_COMMENT,
      A.POTENTIAL_DUPLICATE AS ACTIV#POTENTIAL_DUPLICATE,
      A.PUBLISHED_RELATION AS ACTIV#PUBLISHED_RELATION,
      a.PCHEMBL_VALUE  as ACTIV#PCHEMBL_VALUE,
      A.BAO_ENDPOINT AS ACTIV#BAO_ENDPOINT,
      a.UO_UNITS as ACTIV#UO_UNITS,
      a.QUDT_UNITS as ACTIV#QUDT_UNITS,
      s.PREDBIND_ID as PRED_BIND#PREDBIND_ID,
      s.ACTIVITY_ID as PRED_BIND_DOM#ACTIVITY_ID,
      s.SITE_ID as PRED_BIND_DOM#SITE_ID,
      s.PREDICTION_METHOD as PRED_BIND_DOM#PRED_METHOD,
      s.CONFIDENCE as PRED_BIND_DOM#CONFIDENCE,
      E.SITE_ID AS BIND_SITES#SITE_ID,
       E.SITE_NAME AS BIND_SITES#SITE_NAME,
        E.TID AS BIND_SITES#TID,
         I.TID  as TAR_DICT#TID,
         i.TARGET_TYPE as TAR_DICT#TARGET_TYPE,
      I.PREF_NAME AS TAR_DICT#PREF_NAME,
      I.TAX_ID AS TAR_DICT#TAX_ID,
       I.ORGANISM AS TAR_DICT#ORGANISM,
      I.CHEMBL_ID AS TAR_DICT#CHEMBL_ID,
      I.SPECIES_GROUP_FLAG AS TAR_DICT#SPECIES_GROUP_FLAG,
      t.SITECOMP_ID as SITE_COMP#SITECOMP_ID,
      t.SITE_ID as SITE_COMP#SITE_ID,
      t.COMPONENT_ID as SITE_COMP#COMPONENT_ID,
      t.DOMAIN_ID as SITE_COMP#DOMAIN_ID,
      t.SITE_RESIDUES as SITE_COMP#SITE_RESIDUES,
      u.DOMAIN_ID as DOM#DOMAIN_ID,
      u.DOMAIN_TYPE as DOM#DOMAIN_TYPE,
      u.SOURCE_DOMAIN_ID as DOM#SOURCE_DOMAIN_ID,
      u.DOMAIN_NAME as DOM#DOMAIN_NAME,
      u.DOMAIN_DESCRIPTION as DOM#DOMAIN_DESCRIPTION,
      l.COMPONENT_ID as COMP_SEQ#COMPONENT_ID,
      L.COMPONENT_TYPE AS COMP_SEQ#COMPONENT_TYPE,
      L.ACCESSION AS COMP_SEQ#ACCESSION,
      L.SEQUENCE AS COMP_SEQ#SEQUENCE,
      L.SEQUENCE_MD5SUM AS COMP_SEQ#SEQUENCE_MD5SUM,
       L.DESCRIPTION AS COMP_SEQ#DESCRIPTION,
      L.TAX_ID AS COMP_SEQ#TAX_ID,
      L.ORGANISM AS COMP_SEQ#ORGANISM,
      L.DB_SOURCE AS COMP_SEQ#DB_SOURCE,
      L.DB_VERSION AS COMP_SEQ#DB_VERSION,
      n.COMPONENT_ID as COMP_CLASS#COMPONENT_ID,
      N.PROTEIN_CLASS_ID as COMP_CLASS#PROTEIN_CLASS_ID,
      N.COMP_CLASS_ID as COMP_CLASS#COMPONENT_CLASS_ID,
      s.PROTEIN_CLASS_ID as PROT_CLASS#PROTEIN_CLASS_ID,
      s.PARENT_ID as PROT_CLASS#PARENT_ID,
      S.PREF_NAME AS PROT_CLASS#PREF_NAME,
      s.SHORT_NAME as PROT_CLASS#SHORT_NAME,
      S.PROTEIN_CLASS_DESC AS PROT_CLASS#PROTEIN_CLASS_DESC,
      S.DEFINITION AS PROT_CLASS#DEFINITION,
      S.CLASS_LEVEL AS PROT_CLASS#CLASS_LEVEL,

      b.ASSAY_ID as ASSAYS#ASSAY_ID,
      b.DOC_ID as ASSAYS#DOC_ID,
      B.DESCRIPTION AS ASSAYS#DESCRIPTION,
      B.ASSAY_TYPE AS ASSAYS#ASSAY_TYPE,
      B.ASSAY_TEST_TYPE as ASSAYS#ASSAY_TEST_TYPE,
      B.ASSAY_CATEGORY as ASSAYS#ASSAY_CATEGORY,
      B.ASSAY_ORGANISM as ASSAYS#ASSAY_ORGANISM,
      TRUNC(B.ASSAY_TAX_ID)AS ASSAYS#ASSAY_TAX_ID,
      B.ASSAY_STRAIN as ASSAYS#ASSAY_STRAIN,
      B.ASSAY_TISSUE as ASSAYS#ASSAY_TISSUE,
      B.ASSAY_CELL_TYPE as ASSAYS#ASSAY_CELL_TYPE,
      B.ASSAY_SUBCELLULAR_FRACTION as ASSAYS#ASSAY_SUBCELLULAR_FRAC,
      B.TID AS ASSAYS#TID,
      B.RELATIONSHIP_TYPE AS ASSAYS#RELATIONSHIP_TYPE,
      B.CONFIDENCE_SCORE AS ASSAYS#CONFIDENCE_SCORE,
      b.CURATED_BY as ASSAYS#CURATED_BY,
      B.SRC_ID AS ASSAYS#SRC_ID,
      B.SRC_ASSAY_ID as ASSAYS#SRC_ASSAY_ID,
      B.CHEMBL_ID AS ASSAYS#CHEMBL_ID,
      B.CELL_ID AS ASSAYS#CELL_ID,
      B.BAO_FORMAT AS ASSAYS#BAO_FORMAT,
      b.TISSUE_ID as ASSAYS#TISSUE_ID,
      b.VARIANT_ID as ASSAYS#VARIANT_ID,
      d.ASSAY_TYPE as ASSAY_TYPE#ASSAY_TYPE,
      d.ASSAY_DESC as ASSAY_TYPE#ASSAY_DESC,
      i.PREF_NAME as TAR_DICT#PREF_NAME,
      i.TAX_ID as TAR_DICT#TAX_ID,
      i.ORGANISM as TAR_DICT#ORGANISM,
      i.CHEMBL_ID as TAR_DICT#CHEMBL_ID,
      i.SPECIES_GROUP_FLAG as TAR_DICT#SPECIES_GROUP_FLAG,
       J.TARGET_TYPE as TAR_TYPE#TARGET_DESC,
      J.TARGET_DESC as TAR_TYPE#TARGET_TYPE,
      J.PARENT_TYPE as TAR_TYPE#PARENT_TYPE,
      k.TID as TAR_COMP#TID,
      k.COMPONENT_ID as TAR_COMP#COMPONENT_ID,
      k.TARGCOMP_ID as TAR_COMP#TARGCOMP_ID,
      k.HOMOLOGUE as TAR_COMP#HOMOLOGUE,
      o.TISSUE_ID as TISSUE_DICT#TISSUE_ID
    FROM
        ((((((((((((((ACTIVITIES A LEFT OUTER JOIN ASSAYS B ON A.ASSAY_ID = B.ASSAY_ID)
        LEFT OUTER JOIN ASSAY_TYPE D ON D.ASSAY_TYPE = B.ASSAY_TYPE)
        LEFT OUTER JOIN BINDING_SITES E ON E.TID = B.TID)
        LEFT OUTER JOIN VIEW_COMPOUND_RECORDS H ON H.MOLREGNO = A.MOLREGNO)
        LEFT OUTER JOIN TISSUE_DICTIONARY O ON O.TISSUE_ID = B.TISSUE_ID)
        LEFT OUTER JOIN TARGET_DICTIONARY I ON I.TID = B.TID)
        LEFT OUTER JOIN TARGET_TYPE J ON J.TARGET_TYPE = I.TARGET_TYPE)
        LEFT OUTER JOIN TARGET_COMPONENTS K ON K.TID = I.TID)
        LEFT OUTER JOIN COMPONENT_SEQUENCES L ON L.COMPONENT_ID = K.COMPONENT_ID)
        LEFT OUTER JOIN COMPONENT_CLASS N ON N.COMPONENT_ID = L.COMPONENT_ID)
        LEFT OUTER JOIN PROTEIN_CLASSIFICATION S ON S.PROTEIN_CLASS_ID = N.PROTEIN_CLASS_ID)
        LEFT OUTER JOIN PREDICTED_BINDING_DOMAINS s ON s.ACTIVITY_ID = a.ACTIVITY_ID)
        LEFT OUTER JOIN SITE_COMPONENTS t ON t.COMPONENT_ID = L.COMPONENT_ID)
        LEFT OUTER JOIN domains u ON u.DOMAIN_ID =t.DOMAIN_ID)
