# View&Table Logic

### CHEMBL_ASSAY_EXTRACT

Logic Description:

1 . Join following table as T1

`ACTIVITIES` `ASSAYS` `ASSAY_TYPE`  `MOLECULE_DICTIONARY`  `DOCS` `TISSUE_DICTIONARY` `CELL_DICTIONARY`  `TARGET_DICTIONARY`  `TARGET_COMPONENTS`  `COMPONENT_SEQUENCES`  `SITE_COMPONENTS`  `DOMAINS`  `COMPONENT_CLASS`  `PROTEIN_CLASSIFICATION` 

2 . Query the `record_id` as T2 with the condition `standard_type = 'Efficacy'`

3 . Extract records in T1 which meeting following condition:

- `RECORD_ID` in set T2
- `PCHEMBL_VALUE` is not null
- `STANDARD_TYPE` = `Efficacy` and `STANDARD_VALUE` is not null
- `STANDARD_RELATION` =` >`

4 . Grouping data according to `cpd_molregno`, `assay_chembl_id`, `activity_id`, and `activity_standard_type`


### CHEMBL_ASSAY_SUMMARY

Logic Description:

1 . Query the following field from  `CHEMBL_ASSAY_EXTRACT`

`MOLREGNO` `ACTIVITY_RECORD_ID` `TARGET_TAX_ID` `ASSAY_CHEMBL_ID` `TARGET_ORGANISM` `TARGET_DOMAIN_NAME` `CELL_NAME` `ASSAY_TYPE` `ASSAY_DESCRIPTION` `TARGET_TYPE` `TARGET_PREF_NAME` `ACTIVITY_STANDARD_TYPE` `ACTIVITY_STANDARD_RELATION`

2 . Grouping data according to `ACTIVITY_RECORD_ID`, `ASSAY_CHEMBL_ID`, `activity_id`

3 . Using statistics functions to calculate the `EC_RESPONSE_5P`  `EC_RESPONSE_95P` `EC_RESPONSE_95CI` `EC_RESPONSE_MEDIAN` `EC_RESPONSE_AVG` `EC_RESPONSE_STDEV` `EC_RESPONSE_MAX` `EC_RESPONSE_MIN` `EC_RESPONSE_TP_MEAN` `EC_RESPONSE_UNIT` `EC_RESPONSE_COUNT`





