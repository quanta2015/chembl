SELECT c.cas,
         b.chemical_id,
         b.chemical_name,
         a.species_id,
         a.target_organism AS species_common_name,
         a.species_latin_name,
         a.species_group,
         a.moa_assay_id,
         a.moa_assay_name,
         a.assay_function_aop,
         a.assay_component_name,
         a.assay_component_endpoint_name,
         a.cell_short_name,
         a.assay_function_type,
         a.intended_target_type,
         a.intended_target_type_sub,
         a.intended_target_family,
         a.intended_target_family_sub,
         a.biological_process_target,
         a.gene_id,
         a.entrez_gene_id,
         a.gene_name,
         a.gene_symbol,
         a.uniprot_accession_number,
         'ec50' endpoint, upper(a.signal_direction_type) signal_direction_type, 'gain' AS signal_direction, percentile_cont(0.05) within group (
ORDER BY  modl_ga_m asc) AS ec_response_5p , percentile_cont(0.95) within group (
ORDER BY  modl_ga_m asc) AS ec_response_95p, 1.96*stddev(modl_ga_m) AS ec_response_95ci, median(modl_ga_m) AS ec_response_median, avg (modl_ga_m) AS ec_response_mean, stddev(modl_ga_m)as ec_response_stdev, max(modl_ga_m) AS ec_response_max, min(modl_ga_m) AS ec_response_min, avg (modl_tp) AS ec_response_tp_mean, a.unit3 AS ec_response_unit, count(gene_symbol) AS ec_response_count

FROM CHEMBL_ASSAY_EXTRACT a, risk_assessment.chemical_identifiers b, risk_assessment.cas_numbers c

WHERE a.invalid is null
        AND a.c_casrn_id=c.cas(+)
        AND b.chemical_id =c.chemical_id
        AND modl_ga_m is NOT null
        AND hitc =1
        
GROUP BY  c.cas, b.chemical_id, b.chemical_name, a.species_id, a.organism, a.species_latin_name, a.species_group, a.moa_assay_id, a.assay_name, a.assay_function_aop, a.assay_component_name, a.assay_component_endpoint_name, a.cell_short_name, a.assay_function_type, a.intended_target_type, a.intended_target_type_sub, a.intended_target_family, a.intended_target_family_sub, a.biological_process_target, a.gene_id, a.entrez_gene_id, a.gene_name, a.gene_symbol, a.uniprot_accession_number, a.signal_direction_type, a.unit3