create or replace view chembl_moa_class_extract1 as
(select a.molregno as CPD_MOLREGNO ,
       'FRAC' as RAC_CLASS_TYPE,
       c.frac_class_id as RAC_CLASS_ID,
       c.active_ingredient as RAC_ACTIVE_INGREDIENT,
       c.level1 as RAC_LEVEL1,
       c.level1_description as RAC_LEVEL1_DESC,
       c.level2 as RAC_LEVEL2,
       c.level2_description as RAC_LEVEL2_DESC,
       c.level3 as RAC_LEVEL3,
       c.level3_description as RAC_LEVEL3_DESC,
       c.level4 as RAC_LEVEL4,
       c.level4_description as RAC_LEVEL4_DESC,
       c.level5 as RAC_LEVEL5,
       c.frac_code as RAC_CODE,
       '' as INVALID
  from ((compound_properties a
  inner join molecule_frac_classification b on a.molregno = b.molregno)
  inner join frac_classification c on b.frac_class_id = c.frac_class_id))
  union all
  (select a.molregno as CPD_MOLREGNO,
       'HRAC' as RAC_CLASS_TYPE,
       c.hrac_class_id as RAC_CLASS_ID,
       c.active_ingredient as RAC_ACTIVE_INGREDIENT,
       c.level1 as RAC_LEVEL1,
       c.level1_description as RAC_LEVEL1_DESC,
       c.level2 as RAC_LEVEL2,
       c.level2_description as RAC_LEVEL2_DESC,
       c.level3 as RAC_LEVEL3,
       '' as RAC_LEVEL3_DESC,
       '' as RAC_LEVEL4,
       '' as RAC_LEVEL4_DESC,
       '' as RAC_LEVEL5,
       c.hrac_code as RAC_CODE,
       '' as INVALID
  from ((compound_properties a
  inner join  molecule_hrac_classification b on a.molregno = b.molregno)
  inner join  hrac_classification c on b.hrac_class_id = c.hrac_class_id))
  union all
  (
  select a.molregno as CPD_MOLREGNO,
       'IRAC' as RAC_CLASS_TYPE,
       c.irac_class_id as RAC_CLASS_ID,
       c.active_ingredient as RAC_ACTIVE_INGREDIENT,
       c.level1 as RAC_LEVEL1,
       c.level1_description as RAC_LEVEL1_DESC,
       c.level2 as RAC_LEVEL2,
       c.level2_description as RAC_LEVEL2_DESC,
       c.level3 as RAC_LEVEL3,
       c.level3_description as RAC_LEVEL3_DESC,
       c.level4 as RAC_LEVEL4,
       '' as RAC_LEVEL4_DESC,
       '' as RAC_LEVEL5,
       c.irac_code as RAC_CODE,
       '' as INVALID
  from ((compound_properties a
  inner join molecule_irac_classification b on a.molregno = b.molregno)
  inner join irac_classification c on b.irac_class_id = c.irac_class_id)
  );
