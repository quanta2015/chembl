1 . Connect to the database in SQL*Plus using `scott` accout  `as sysdba`  
2 . Create the tablespace  with following command
```sql
create temporary tablespace chembl_temp
tempfile 'D:\oracle\db\chembl_temp.dbf' 
size 50m 
autoextend on 
next 50m maxsize 20480m 
extent management local; 


create tablespace chembl_data 
logging 
datafile 'D:\oracle\db\chembl_data.dbf' 
size 50m 
autoextend on 
next 50m maxsize 20480m 
extent management local; 
```
3 . run the `pre_imp.sql` script
```sql
SQL> @pre_imp
```
4 . import the chembl database file
```bash
imp userid=chembl_22@orcl parfile=imp.par fromuser=chembl_22 touser=chembl_22
```



select 
    ( case when city='上海' then countryelse null end)  a 
from 
    V_TEST t