CREATE OR REPLACE VIEW CHEMBL_CHEMICAL_IDENTIFIERS AS
SELECT A.MOLREGNO AS MOLREGNO,
       C.COMPOUND_NAME AS CPD_COMPOUND_NAME,
       A.MW_FREEBASE AS CPD_MW_FREEBASE,
       A.ALOGP AS CPD_ALOGP,
       A.HBA AS CPD_HBA,
       A.HBD AS CPD_HBD,
       A.HEAVY_ATOMS AS CPD_HEAVY_ATOMS,
       A.PSA  AS CPD_PSA,
       A.RTB AS CPD_RTB,
       A.RO3_PASS AS CPD_RO3_PASS,
       A.NUM_RO5_VIOLATIONS AS CPD_NUM_RO5_VIOLATIONS,
       A.ACD_MOST_APKA AS CPD_ACD_MOST_APKA,
       A.ACD_MOST_BPKA AS CPD_ACD_MOST_BPKA,
       A.ACD_LOGP AS CPD_ACD_LOGP,
       A.ACD_LOGD AS CPD_ACD_LOGD,
       A.MOLECULAR_SPECIES AS CPD_MOLECULAR_SPECIES,
       A.FULL_MWT AS CPD_FULL_MWT,
       A.AROMATIC_RINGS AS CPD_AROMATIC_RINGS,
       A.NUM_ALERTS AS CPD_NUM_ALERTS,
       A.QED_WEIGHTED AS CPD_QED_WEIGHTED,
       A.MW_MONOISOTOPIC AS CPD_MW_MONOISOTOPIC,
       A.FULL_MOLFORMULA AS CPD_FULL_MOLFORMULA,
       A.HBA_LIPINSKI AS CPD_HBA_LIPINSKI,
       A.HBD_LIPINSKI AS CPD_HBD_LIPINSKI,
       A.NUM_LIPINSKI_RO5_VIOLATIONS AS CPD_NUM_LIPINSKI_RO5_VIO,
       B.MOLFILE AS CPD_MOLFILE,
       B.STANDARD_INCHI AS CPD_STANDARD_INCHI,
       B.STANDARD_INCHI_KEY AS CPD_STANDARD_INCHI_KEY,
       B.CANONICAL_SMILES AS CPD_CANONICAL_SMILES
  FROM ((COMPOUND_PROPERTIES A
       LEFT OUTER JOIN COMPOUND_STRUCTURES B ON A.MOLREGNO = B.MOLREGNO)
       LEFT OUTER JOIN VIEW_COMPOUND_RECORDS C ON C.MOLREGNO = A.MOLREGNO);
