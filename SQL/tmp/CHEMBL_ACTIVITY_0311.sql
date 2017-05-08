CREATE OR REPLACE FORCE VIEW extract1_m 
as 
    select 
           a.ACTIVITY_ID,a.ASSAY_ID,a.DOC_ID,a.RECORD_ID,a.MOLREGNO,a.STANDARD_RELATION,a.STANDARD_VALUE, 
           a.STANDARD_UNITS, a.STANDARD_FLAG, a.STANDARD_TYPE, a.ACTIVITY_COMMENT, a.DATA_VALIDITY_COMMENT, 
           a.POTENTIAL_DUPLICATE, a.BAO_ENDPOINT , b.DESCRIPTION, b.ASSAY_TYPE, b.ASSAY_TEST_TYPE,  b.ASSAY_CATEGORY, b.ASSAY_ORGANISM, b.ASSAY_TAX_ID, b.ASSAY_STRAIN, b.ASSAY_TISSUE, b.ASSAY_CELL_TYPE, 
           b.ASSAY_SUBCELLULAR_FRACTION, b.TID, b.RELATIONSHIP_TYPE, b.CONFIDENCE_SCORE, b.SRC_ID, b.SRC_ASSAY_ID, b.CHEMBL_ID as CHEMBL_ID1,
           b.CELL_ID, b.BAO_FORMAT, b.TISSUE_ID, b.VARIANT_ID, c.PARAMETER_TYPE, c.PARAMETER_VALUE, d.ASSAY_DESC, e.SITE_NAME,
           f.LABEL, g.CELL_NAME, g.CELL_DESCRIPTION, g.CELL_SOURCE_TISSUE, g.CELL_SOURCE_ORGANISM, g.CELL_SOURCE_TAX_ID,
           g.CLO_ID, g.EFO_ID, g.CELLOSAURUS_ID, g.CL_LINCS_ID, g.CHEMBL_ID as CHEMBL_ID2, 
           l.COMPONENT_TYPE, l.ACCESSION, l.SEQUENCE, l.SEQUENCE_MD5SUM, l.DESCRIPTION as DESCRIPTION2,
           m.GO_ID, n.PROTEIN_CLASS_ID, n.COMP_CLASS_ID, o.UBERON_ID, o.PREF_NAME as PREF_NAME1, p.CHEMBL_ID,
           h.COMPOUND_NAME, i.PREF_NAME as PREF_NAME2, i.CHEMBL_ID as CHEMBL_ID3, j.TARGET_DESC
    from 
        (((((((((((((((ACTIVITIES a left outer join ASSAYS b on a.ASSAY_ID = b.ASSAY_ID)
        left outer join ASSAY_PARAMETERS c on a.ASSAY_ID = c.ASSAY_ID)
        left outer join ASSAY_TYPE d on d.ASSAY_TYPE = b.ASSAY_TYPE)
        left outer join BINDING_SITES e on e.TID = b.TID)
        left outer join BIOASSAY_ONTOLOGY f on f.BAO_ID = b.BAO_FORMAT)
        left outer join CELL_DICTIONARY g on g.CELL_ID = b.CELL_ID)
        left outer join COMPOUND_RECORDS h on h.MOLREGNO = a.MOLREGNO)
        left outer join TARGET_DICTIONARY i on i.TID = b.TID)
        left outer join TARGET_TYPE j on j.TARGET_TYPE = i.TARGET_TYPE)
        left outer join target_components k on k.tid = i.tid)
        left outer join component_sequences l on l.component_id = k.component_id)
        left outer join component_go m on m.component_id = l.component_id)
        left outer join component_class n on n.component_id = l.component_id)
        left outer join TISSUE_DICTIONARY o on o.TISSUE_ID = b.TISSUE_ID)
        left outer join DOCS p on p.DOC_ID = a.DOC_ID)
