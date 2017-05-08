
  CREATE OR REPLACE FORCE VIEW "RISK_ASSESSMENT"."TOXCAST_SUMMARY_ASSAY_JIS2" ("CAS", "CHEMICAL_ID", "CHEMICAL_NAME", "SPECIES_ID", "SPECIES_COMMON_NAME", "SPECIES_LATIN_NAME", "SPECIES_GROUP", "MOA_ASSAY_ID", "MOA_ASSAY_NAME", "ASSAY_FUNCTION_AOP", "ASSAY_COMPONENT_NAME", "ASSAY_COMPONENT_ENDPOINT_NAME", "CELL_SHORT_NAME", "ASSAY_FUNCTION_TYPE", "INTENDED_TARGET_TYPE", "INTENDED_TARGET_TYPE_SUB", "INTENDED_TARGET_FAMILY", "INTENDED_TARGET_FAMILY_SUB", "BIOLOGICAL_PROCESS_TARGET", "GENE_ID", "ENTREZ_GENE_ID", "GENE_NAME", "GENE_SYMBOL", "UNIPROT_ACCESSION_NUMBER", "ENDPOINT", "SIGNAL_DIRECTION_TYPE", "SIGNAL_DIRECTION", "EC_RESPONSE_5P", "EC_RESPONSE_95P", "EC_RESPONSE_95CI", "EC_RESPONSE_MEDIAN", "EC_RESPONSE_MEAN", "EC_RESPONSE_STDEV", "EC_RESPONSE_MAX", "EC_RESPONSE_MIN", "EC_RESPONSE_TP_MEAN", "EC_RESPONSE_UNIT", "EC_RESPONSE_COUNT") AS 


  SELECT c.cas,
    b.chemical_id,
    b.chemical_name,
    a.SPECIES_ID,
     a.ORGANISM AS SPECIES_COMMON_NAME,   
     a.SPECIES_LATIN_NAME,
    a.SPECIES_GROUP,  
    a.MOA_ASSAY_ID, 
    a.ASSAY_NAME as MOA_ASSAY_NAME,
    a.ASSAY_FUNCTION_AOP,
    a.assay_component_name,
     a.assay_component_endpoint_name,
     a.CELL_SHORT_NAME,
    a.ASSAY_FUNCTION_TYPE,
    a.INTENDED_TARGET_TYPE,
    a.INTENDED_TARGET_TYPE_SUB,
    a.INTENDED_TARGET_FAMILY,
    a.INTENDED_TARGET_FAMILY_SUB,
    a.BIOLOGICAL_PROCESS_TARGET,
    a.GENE_ID,
    a.ENTREZ_GENE_ID,
    a.GENE_NAME,
    a.gene_symbol,
    a.UNIPROT_ACCESSION_NUMBER,
    'EC50' ENDPOINT,
    upper(a.signal_direction_type) signal_direction_type,
    'GAIN' AS signal_direction,    
  
    PERCENTILE_CONT(0.05) WITHIN GROUP (
  ORDER BY modl_ga_m ASC) AS EC_RESPONSE_5P ,
    PERCENTILE_CONT(0.95) WITHIN GROUP (
  ORDER BY modl_ga_m ASC) AS EC_RESPONSE_95P,
    1.96*STDDEV(modl_ga_m)  AS EC_RESPONSE_95CI,
    MEDIAN(modl_ga_m) as EC_RESPONSE_MEDIAN,
    AVG (modl_ga_m) as EC_RESPONSE_MEAN,
    STDDEV(modl_ga_m)as EC_RESPONSE_STDEV,
        MAX(modl_ga_m) as EC_RESPONSE_MAX,
    MIN(modl_ga_m) AS EC_RESPONSE_MIN,
    AVG (modl_tp) as EC_RESPONSE_TP_MEAN,
    a.unit3 AS EC_RESPONSE_UNIT,
    COUNT(gene_symbol) AS EC_RESPONSE_COUNT

  FROM toxcast.extract1_M_JIS a,
    RISK_ASSESSMENT.chemical_identifiers b,
    RISK_ASSESSMENT.cas_numbers c
  WHERE a.INVALID IS NULL
  AND a.c_casrn_id=c.cas(+)
  AND b.chemical_id =c.chemical_id
  AND modl_ga_m    IS NOT NULL
  AND hitc          =1
    --and b.chemical_id<640
  GROUP BY    
    c.cas,
    b.chemical_id,
    b.chemical_name,
    a.SPECIES_ID,
     a.ORGANISM,   
     a.SPECIES_LATIN_NAME,
    a.SPECIES_GROUP,  
    a.MOA_ASSAY_ID, 
    a.ASSAY_NAME,
    a.ASSAY_FUNCTION_AOP,
    a.assay_component_name,
     a.assay_component_endpoint_name,
     a.CELL_SHORT_NAME,
    a.ASSAY_FUNCTION_TYPE,
    a.INTENDED_TARGET_TYPE,
    a.INTENDED_TARGET_TYPE_SUB,
    a.INTENDED_TARGET_FAMILY,
    a.INTENDED_TARGET_FAMILY_SUB,
    a.BIOLOGICAL_PROCESS_TARGET,
    a.GENE_ID,
    a.ENTREZ_GENE_ID,
    a.GENE_NAME,
    a.gene_symbol,
    a.UNIPROT_ACCESSION_NUMBER,
    a.signal_direction_type,
    --a.signal_direction,
    a.unit3
   
    
    -----
    
  UNION
  
    SELECT c.cas,
    b.chemical_id,
    b.chemical_name,
    a.SPECIES_ID,
      a.ORGANISM AS SPECIES_COMMON_NAME,   
     a.SPECIES_LATIN_NAME,
    a.SPECIES_GROUP,  
    a.MOA_ASSAY_ID, 
    a.ASSAY_NAME as MOA_ASSAY_NAME,
    a.ASSAY_FUNCTION_AOP,
    a.assay_component_name,
     a.assay_component_endpoint_name,
     a.CELL_SHORT_NAME,
    a.ASSAY_FUNCTION_TYPE,
    a.INTENDED_TARGET_TYPE,
    a.INTENDED_TARGET_TYPE_SUB,
    a.INTENDED_TARGET_FAMILY,
    a.INTENDED_TARGET_FAMILY_SUB,
    a.BIOLOGICAL_PROCESS_TARGET,
    a.GENE_ID,
    a.ENTREZ_GENE_ID,
    a.GENE_NAME,
    a.gene_symbol,
    a.UNIPROT_ACCESSION_NUMBER,
    'EC50' ENDPOINT,
    upper(a.signal_direction_type) signal_direction_type,
    'LOSS' AS signal_direction,    
   
    
    
    PERCENTILE_CONT(0.05) WITHIN GROUP (
  ORDER BY modl_la_m ASC) AS EC_RESPONSE_5P ,
    PERCENTILE_CONT(0.95) WITHIN GROUP (
  ORDER BY modl_la_m ASC) AS EC_RESPONSE_95P,
    1.96*STDDEV(modl_la_m)  AS EC_RESPONSE_95CI,
    MEDIAN(modl_la_m) as EC_RESPONSE_MEDIAN,
    AVG (modl_la_m) as EC_RESPONSE_MEAN,
    STDDEV(modl_la_m)as EC_RESPONSE_STDEV,
        MAX(modl_la_m) as EC_RESPONSE_MAX,
    MIN(modl_la_m) AS EC_RESPONSE_MIN,
    AVG (modl_tp) as EC_RESPONSE_TP_MEAN,
    a.unit3 AS EC_RESPONSE_UNIT,
    COUNT(gene_symbol) AS EC_RESPONSE_COUNT

  FROM toxcast.extract1_M_JIS a,
    RISK_ASSESSMENT.chemical_identifiers b,
    RISK_ASSESSMENT.cas_numbers c
  WHERE a.INVALID IS NULL
  AND a.c_casrn_id=c.cas(+)
  AND b.chemical_id =c.chemical_id
  AND modl_la_m    IS NOT NULL
  AND hitc          =1
    --and b.chemical_id<640
  GROUP BY    
    c.cas,
    b.chemical_id,
    b.chemical_name,
    a.SPECIES_ID,
     a.ORGANISM,   
     a.SPECIES_LATIN_NAME,
    a.SPECIES_GROUP,  
    a.MOA_ASSAY_ID, 
    a.ASSAY_NAME,
    a.ASSAY_FUNCTION_AOP,
    a.assay_component_name,
     a.assay_component_endpoint_name,
     a.CELL_SHORT_NAME,
    a.ASSAY_FUNCTION_TYPE,
    a.INTENDED_TARGET_TYPE,
    a.INTENDED_TARGET_TYPE_SUB,
    a.INTENDED_TARGET_FAMILY,
    a.INTENDED_TARGET_FAMILY_SUB,
    a.BIOLOGICAL_PROCESS_TARGET,
    a.GENE_ID,
    a.ENTREZ_GENE_ID,
    a.GENE_NAME,
    a.gene_symbol,
    a.UNIPROT_ACCESSION_NUMBER,
    a.signal_direction_type,
   --a.signal_direction,
    a.unit3
    
    ------------------------------
    
    UNION
    
        SELECT c.cas,
    b.chemical_id,
    b.chemical_name,
    a.SPECIES_ID,
     a.ORGANISM AS SPECIES_COMMON_NAME,   
     a.SPECIES_LATIN_NAME,
    a.SPECIES_GROUP,  
    a.MOA_ASSAY_ID, 
    a.ASSAY_NAME as MOA_ASSAY_NAME,
    a.ASSAY_FUNCTION_AOP,
    a.assay_component_name,
     a.assay_component_endpoint_name,
     a.CELL_SHORT_NAME,
    a.ASSAY_FUNCTION_TYPE,
    a.INTENDED_TARGET_TYPE,
    a.INTENDED_TARGET_TYPE_SUB,
    a.INTENDED_TARGET_FAMILY,
    a.INTENDED_TARGET_FAMILY_SUB,
    a.BIOLOGICAL_PROCESS_TARGET,
    a.GENE_ID,
    a.ENTREZ_GENE_ID,
    a.GENE_NAME,
    a.gene_symbol,
    a.UNIPROT_ACCESSION_NUMBER,
    'EC50' ENDPOINT,
    upper(a.signal_direction_type) signal_direction_type,
    'NEG_RESP' AS signal_direction,    
   
    
    
    PERCENTILE_CONT(0.05) WITHIN GROUP (
  ORDER BY C_MAX ASC) AS EC_RESPONSE_5P ,
    PERCENTILE_CONT(0.95) WITHIN GROUP (
  ORDER BY C_MAX ASC) AS EC_RESPONSE_95P,
    1.96*STDDEV(C_MAX)  AS EC_RESPONSE_95CI,
    MEDIAN(C_MAX) as EC_RESPONSE_MEDIAN,
    AVG (C_MAX) as EC_RESPONSE_MEAN,
    STDDEV(C_MAX)as EC_RESPONSE_STDEV,
        MAX(C_MAX) as EC_RESPONSE_MAX,
    MIN(C_MAX) AS EC_RESPONSE_MIN,
    AVG (modl_tp) as EC_RESPONSE_TP_MEAN,
    a.unit3 AS EC_RESPONSE_UNIT,
    COUNT(gene_symbol) AS EC_RESPONSE_COUNT

  FROM toxcast.extract1_M_JIS a,
    RISK_ASSESSMENT.chemical_identifiers b,
    RISK_ASSESSMENT.cas_numbers c
  WHERE a.INVALID IS NULL  
  AND a.c_casrn_id=c.cas(+)
  AND b.chemical_id =c.chemical_id
  AND hitc          =0
    --and b.chemical_id<640
  GROUP BY    
    c.cas,
    b.chemical_id,
    b.chemical_name,
    a.SPECIES_ID,
     a.ORGANISM,   
     a.SPECIES_LATIN_NAME,
    a.SPECIES_GROUP,  
    a.MOA_ASSAY_ID, 
    a.ASSAY_NAME,
    a.ASSAY_FUNCTION_AOP,
    a.assay_component_name,
     a.assay_component_endpoint_name,
     a.CELL_SHORT_NAME,
    a.ASSAY_FUNCTION_TYPE,
    a.INTENDED_TARGET_TYPE,
    a.INTENDED_TARGET_TYPE_SUB,
    a.INTENDED_TARGET_FAMILY,
    a.INTENDED_TARGET_FAMILY_SUB,
    a.BIOLOGICAL_PROCESS_TARGET,
    a.GENE_ID,
    a.ENTREZ_GENE_ID,
    a.GENE_NAME,
    a.gene_symbol,
    a.UNIPROT_ACCESSION_NUMBER,
    a.signal_direction_type,
    --a.signal_direction,
    a.unit3;
