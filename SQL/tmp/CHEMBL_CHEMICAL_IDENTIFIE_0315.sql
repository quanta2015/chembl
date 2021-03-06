CREATE OR REPLACE VIEW CHEMBL_CHEMICAL_IDENTIFIERS AS
SELECT A.MOLREGNO AS CPD_PROP#MOLREGNO,
       C.COMPOUND_NAME AS COMPOUND_SYNONYM,
       A.MW_FREEBASE AS CPD_PROP#MW_FREEBASE,
       A.ALOGP AS CPD_PROP#ALOGP,
       A.HBA AS CPD_PROP#HBA,
       A.HBD AS CPD_PROP#HBD,
       A.HEAVY_ATOMS AS CPD_PROP#HEAVY_ATOMS,
       A.PSA  AS CPD_PROP#PSA,
       A.RTB AS CPD_PROP#RTB,
       A.RO3_PASS AS CPD_PROP#RO3_PASS,
       A.NUM_RO5_VIOLATIONS AS CPD_PROP#NUM_RO5_VIOLATIONS,
       A.ACD_MOST_APKA AS CPD_PROP#ACD_MOST_APKA,
       A.ACD_MOST_BPKA AS CPD_PROP#ACD_MOST_BPKA,
       A.ACD_LOGP AS CPD_PROP#ACD_LOGP,
       A.ACD_LOGD AS CPD_PROP#ACD_LOGD,
       A.MOLECULAR_SPECIES AS CPD_PROP#MOLECULAR_SPECIES,
       A.FULL_MWT AS CPD_PROP#FULL_MWT,
       A.AROMATIC_RINGS AS CPD_PROP#AROMATIC_RINGS,
       A.NUM_ALERTS AS CPD_PROP#NUM_ALERTS,
       A.QED_WEIGHTED AS CPD_PROP#QED_WEIGHTED,
       A.MW_MONOISOTOPIC AS CPD_PROP#MW_MONOISOTOPIC,
       A.FULL_MOLFORMULA AS CPD_PROP#FULL_MOLFORMULA,
       A.HBA_LIPINSKI AS CPD_PROP#HBA_LIPINSKI,
       A.HBD_LIPINSKI AS CPD_PROP#HBD_LIPINSKI,
       A.NUM_LIPINSKI_RO5_VIOLATIONS AS CPD_PROP#NUM_LIPINSKI_RO5_VIO,
       B.MOLFILE AS CPD_STR#MOLFILE,
       B.STANDARD_INCHI AS CPD_STR#STANDARD_INCHI,
       B.STANDARD_INCHI_KEY AS CPD_STR#STANDARD_INCHI_KEY,
       B.CANONICAL_SMILES AS CPD_STR#CANONICAL_SMILES
  FROM ((COMPOUND_PROPERTIES A
       LEFT OUTER JOIN COMPOUND_STRUCTURES B ON A.MOLREGNO = B.MOLREGNO)
       LEFT OUTER JOIN VIEW_COMPOUND_RECORDS C ON C.MOLREGNO = A.MOLREGNO);
