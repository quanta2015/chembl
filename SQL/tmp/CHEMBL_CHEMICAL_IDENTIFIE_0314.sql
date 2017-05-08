CREATE OR REPLACE VIEW CHEMBL_CHEMICAL_IDENTIFIERS AS
SELECT A.MOLREGNO AS CPD_PROP.MOLREGNO,
       C.COMPOUND_NAME AS COMPOUND_SYNONYM,
       A.MW_FREEBASE AS CPD_PROP.MW_FREEBASE,
       A.ALOGP AS CPD_PROP.ALOGP,
       A.HBA AS COMPOUND_HBA,
       A.HBD AS COMPOUND_HBD,
       A.HEAVY_ATOMS AS COMPOUND_HEAVY_ATOMS,
       A.PSA  AS COMPOUND_PSA,
       A.RTB AS COMPOUND_RTB,
       A.RO3_PASS AS COMPOUND_RO3_PASS,
       A.NUM_RO5_VIOLATIONS AS COMPOUND_NUM_RO5_VIOLATIONS,
       A.ACD_MOST_APKA AS COMPOUND_ACD_MOST_APKA,
       A.ACD_MOST_BPKA AS COMPOUND_ACD_MOST_BPKA,
       A.ACD_LOGP AS COMPOUND_ACD_LOGP,
       A.ACD_LOGD AS COMPOUND_ACD_LOGD,
       A.MOLECULAR_SPECIES AS COMPOUND_MOLECULAR_SPECIES,
       A.FULL_MWT AS COMPOUND_FULL_MWT,
       A.AROMATIC_RINGS AS COMPOUND_AROMATIC_RINGS,
       A.NUM_ALERTS AS COMPOUND_NUM_ALERTS,
       A.QED_WEIGHTED AS COMPOUND_QED_WEIGHTED,
       A.MW_MONOISOTOPIC AS COMPOUND_MW_MONOISOTOPIC,
       A.FULL_MOLFORMULA AS COMPOUND_FULL_MOLFORMULA,
       A.HBA_LIPINSKI AS COMPOUND_HBA_LIPINSKI,
       A.HBD_LIPINSKI AS COMPOUND_HBD_LIPINSKI,
       A.NUM_LIPINSKI_RO5_VIOLATIONS AS COMPOUND_NUM_LIPINSKI_RO5_VIO,
       B.MOLFILE AS COMPOUND_MOLFILE,
       B.STANDARD_INCHI AS COMPOUND_STANDARD_INCHI,
       B.STANDARD_INCHI_KEY AS COMPOUND_STANDARD_INCHI_KEY,
       B.CANONICAL_SMILES AS COMPOUND_CANONICAL_SMILES
  FROM ((COMPOUND_PROPERTIES A
       LEFT OUTER JOIN COMPOUND_STRUCTURES B ON A.MOLREGNO = B.MOLREGNO)
       LEFT OUTER JOIN VIEW_COMPOUND_RECORDS C ON C.MOLREGNO = A.MOLREGNO);
