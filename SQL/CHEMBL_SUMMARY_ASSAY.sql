create or replace force view toxcast_summary_assay_jis2

cas, 
chemical_id, 
chemical_name, 
species_id, 
species_common_name, 
species_latin_name, 
species_group, 
moa_assay_id, 
moa_assay_name, 
assay_function_aop, 
assay_component_name, 
assay_component_endpoint_name, 
cell_short_name, 
assay_function_type, 
intended_target_type, 
intended_target_type_sub, 
intended_target_family, 
intended_target_family_sub, 
biological_process_target, 
gene_id, 
entrez_gene_id, 
gene_name, 
gene_symbol, 
uniprot_accession_number, 
endpoint, 
signal_direction_type, 
signal_direction, 
ec_response_5p, 
ec_response_95p, 
ec_response_95ci, 
ec_response_median, 
ec_response_mean, 
ec_response_stdev, 
ec_response_max, 
ec_response_min, 
ec_response_tp_mean,
ec_response_unit, 
ec_response_count

as 

    select c.cas,
             b.chemical_id,
             b.chemical_name,
             a.species_id,
             a.organism as species_common_name,
             a.species_latin_name,
             a.species_group,
             a.moa_assay_id,
             a.assay_name as moa_assay_name,
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
             'ec50' endpoint, upper(a.signal_direction_type) signal_direction_type, 'gain' as signal_direction, percentile_cont(0.05) within group (
    order by  modl_ga_m asc) as ec_response_5p , percentile_cont(0.95) within group (
    order by  modl_ga_m asc) as ec_response_95p, 1.96*stddev(modl_ga_m) as ec_response_95ci, median(modl_ga_m) as ec_response_median, avg (modl_ga_m) as ec_response_mean, stddev(modl_ga_m)as ec_response_stdev, max(modl_ga_m) as ec_response_max, min(modl_ga_m) as ec_response_min, avg (modl_tp) as ec_response_tp_mean, a.unit3 as ec_response_unit, count(gene_symbol) as ec_response_count
    from toxcast.extract1_m_jis a, risk_assessment.chemical_identifiers b, risk_assessment.cas_numbers c
    where a.invalid is null
            and a.c_casrn_id=c.cas(+)
            and b.chemical_id =c.chemical_id
            and modl_ga_m is not null
            and hitc =1
    group by  c.cas, b.chemical_id, b.chemical_name, a.species_id, a.organism, a.species_latin_name, a.species_group, a.moa_assay_id, a.assay_name, a.assay_function_aop, a.assay_component_name, a.assay_component_endpoint_name, a.cell_short_name, a.assay_function_type, a.intended_target_type, a.intended_target_type_sub, a.intended_target_family, a.intended_target_family_sub, a.biological_process_target, a.gene_id, a.entrez_gene_id, a.gene_name, a.gene_symbol, a.uniprot_accession_number, a.signal_direction_type, a.unit3

    -----
    
union
  
    select c.cas,
             b.chemical_id,
             b.chemical_name,
             a.species_id,
             a.organism as species_common_name,
             a.species_latin_name,
             a.species_group,
             a.moa_assay_id,
             a.assay_name as moa_assay_name,
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
             'ec50' endpoint, upper(a.signal_direction_type) signal_direction_type, 'loss' as signal_direction, percentile_cont(0.05) within group (
    order by  modl_la_m asc) as ec_response_5p , percentile_cont(0.95) within group (
    order by  modl_la_m asc) as ec_response_95p, 1.96*stddev(modl_la_m) as ec_response_95ci, median(modl_la_m) as ec_response_median, avg (modl_la_m) as ec_response_mean, stddev(modl_la_m)as ec_response_stdev, max(modl_la_m) as ec_response_max, min(modl_la_m) as ec_response_min, avg (modl_tp) as ec_response_tp_mean, a.unit3 as ec_response_unit, count(gene_symbol) as ec_response_count
    from toxcast.extract1_m_jis a, risk_assessment.chemical_identifiers b, risk_assessment.cas_numbers c
    where a.invalid is null
            and a.c_casrn_id=c.cas(+)
            and b.chemical_id =c.chemical_id
            and modl_la_m is not null
            and hitc =1
    group by  c.cas, b.chemical_id, b.chemical_name, a.species_id, a.organism, a.species_latin_name, a.species_group, a.moa_assay_id, a.assay_name, a.assay_function_aop, a.assay_component_name, a.assay_component_endpoint_name, a.cell_short_name, a.assay_function_type, a.intended_target_type, a.intended_target_type_sub, a.intended_target_family, a.intended_target_family_sub, a.biological_process_target, a.gene_id, a.entrez_gene_id, a.gene_name, a.gene_symbol, a.uniprot_accession_number, a.signal_direction_type, a.unit3
        
    ------------------------------
    
union
    
    select c.cas,
             b.chemical_id,
             b.chemical_name,
             a.species_id,
             a.organism as species_common_name,
             a.species_latin_name,
             a.species_group,
             a.moa_assay_id,
             a.assay_name as moa_assay_name,
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
             'ec50' endpoint, upper(a.signal_direction_type) signal_direction_type, 'neg_resp' as signal_direction, percentile_cont(0.05) within group (
    order by  c_max asc) as ec_response_5p , percentile_cont(0.95) within group (
    order by  c_max asc) as ec_response_95p, 1.96*stddev(c_max) as ec_response_95ci, median(c_max) as ec_response_median, avg (c_max) as ec_response_mean, stddev(c_max)as ec_response_stdev, max(c_max) as ec_response_max, min(c_max) as ec_response_min, avg (modl_tp) as ec_response_tp_mean, a.unit3 as ec_response_unit, count(gene_symbol) as ec_response_count
    from toxcast.extract1_m_jis a, risk_assessment.chemical_identifiers b, risk_assessment.cas_numbers c
    where a.invalid is null
            and a.c_casrn_id=c.cas(+)
            and b.chemical_id =c.chemical_id
            and hitc =0
    group by  c.cas, b.chemical_id, b.chemical_name, a.species_id, a.organism, a.species_latin_name, a.species_group, a.moa_assay_id, a.assay_name, a.assay_function_aop, a.assay_component_name, a.assay_component_endpoint_name, a.cell_short_name, a.assay_function_type, a.intended_target_type, a.intended_target_type_sub, a.intended_target_family, a.intended_target_family_sub, a.biological_process_target, a.gene_id, a.entrez_gene_id, a.gene_name, a.gene_symbol, a.uniprot_accession_number, a.signal_direction_type, a.unit3;