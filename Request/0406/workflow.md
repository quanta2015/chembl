my work flow is as following: 

1. put the records with same record_id in a group
2. remove the record in the group exctpt 

    a. pchembl_value is not null
    b. standard_type = 'Efficacy'
    c. relation_type = '>'
3. make a new field ACTIVITY_EFFICIACY with STANDARD_VALUE, when STANDARD_TYPE='Efficacy' 