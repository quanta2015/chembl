### 多记录合并

| id | name |
|----|------|
| 1  | a    |
| 1  | b    |
| 1  | c    |
| 2  | aa   |
| 2  | bb   |

1 . 使用 `WM_CONCAT` 函数
```sql
SQL> select wmsys.wm_concat(distinct name) from t; 
SQL> select id,wmsys.wm_concat(distinct name) con_name from t group by id;  

ID   CON_NAME  
--------------  
1     a,b,c  
2     aa,bb  
```


2 . 使用 `STRAGG` 
```sql
SQL> SELECT TRIM(',' FROM SYS.STRAGG(NAME||NVL2(NAME,',',''))) CON_NAME FROM T;  
  
CON_NAME  
----------  
a,b,c,aa,bb  
```


3 . 使用 `partition by`
```sql
select id,sys_connect_by_path(name,'>')  con_name  
    from ( select id,name,row_number() over( partition by id order by name) rn  from (select id,name from t )) t  
start 
    with t.rn=1  
connect by 
    t.id=prior t.id and t.rn-1=prior t.rn  

    ID CON_NAME  
------- --------------------  
     1 >a  
     1 >a>b  
     1 >a>b>c  
     2 >aa  
     2 >aa>bb  
     2 >aa>bb>china  
     2 >aa>bb>china>china  

select id,substr(max(sys_connect_by_path(name,'>')),2)  con_name  
  from (select id,name,row_number() over(partition by id order by name) rn  from (select id,name from t ))t  
  start with t.rn=1  
  connect by t.id=prior t.id and t.rn-1=prior t.rn  
  group by id  

   ID CON_NAME  
------- --------------------  
    1 a>b>c  
    2 aa>bb>china>china  
```

4 . 使用 `XMLAGG` 函数
```sql
RTRIM(XMLAGG(XMLPARSE(CONTENT field || ',' WELLFORMED)) .GETCLOBVAL(), ',')
```

5 . 自定义类型 `VARCHAR2`
```sql
-- create function of strcat 
CREATE OR REPLACE FUNCTION strcat (input VARCHAR2) RETURN VARCHAR2 PARALLEL_ENABLE AGGREGATE USING strcat_type; 

-- create type define of strcat_type
create or replace type strcat_type as object 
( 
    currentstr varchar2(4000), 
    currentseprator varchar2(8), 
    static function ODCIAggregateInitialize(sctx IN OUT strcat_type) return number, 
    member function ODCIAggregateIterate(self IN OUT strcat_type,value IN VARCHAR2) return number, 
    member function ODCIAggregateTerminate(self IN strcat_type,returnValue OUT VARCHAR2, flags IN number) return number, 
    member function ODCIAggregateMerge(self IN OUT strcat_type,ctx2 IN strcat_type) return number 
) 

-- create type body of strcat_type
create or replace type body strcat_type is 
      static function ODCIAggregateInitialize(sctx IN OUT strcat_type) return number is 
      begin 
        sctx := strcat_type('',','); 
        return ODCIConst.Success; 
      end; 
      member function ODCIAggregateIterate(self IN OUT strcat_type, value IN VARCHAR2) return number is 
      begin 
        if self.currentstr is null then 
           self.currentstr := value; 
        else 
          self.currentstr := self.currentstr ||currentseprator || value; 
        end if; 
        return ODCIConst.Success; 
      end; 
      member function ODCIAggregateTerminate(self IN strcat_type, returnValue OUT VARCHAR2, flags IN number) return number is 
      begin 
        returnValue := self.currentstr; 
        return ODCIConst.Success; 
      end; 
      member function ODCIAggregateMerge(self IN OUT strcat_type, ctx2 IN strcat_type) return number is 
      begin 
        if ctx2.currentstr is null then 
          self.currentstr := self.currentstr; 
        elsif self.currentstr is null then 
          self.currentstr := ctx2.currentstr; 
        else 
          self.currentstr := self.currentstr || currentseprator || ctx2.currentstr; 
        end if; 
        return ODCIConst.Success; 
      end; 
      end; 
```

6 . 自定义类型 `clob`

```sql
-- create function of strcat 
CREATE OR REPLACE FUNCTION strcat (input VARCHAR2) RETURN clob PARALLEL_ENABLE AGGREGATE USING strcat_type;

-- create type define of strcat_type
create or replace type strcat_type as object
(
  CURR_STR clob,
  STATIC FUNCTION ODCIAGGREGATEINITIALIZE(SCTX IN OUT strcat_type) RETURN NUMBER,
  MEMBER FUNCTION ODCIAGGREGATEITERATE(SELF IN OUT strcat_type, P1 IN VARCHAR2) RETURN NUMBER,
  MEMBER FUNCTION ODCIAGGREGATETERMINATE(SELF IN strcat_type, RETURNVALUE OUT clob, FLAGS IN NUMBER) RETURN NUMBER,
  MEMBER FUNCTION ODCIAGGREGATEMERGE(SELF  IN OUT strcat_type, SCTX2 IN strcat_type) RETURN NUMBER
)

-- create type body of strcat_type
create or replace type body strcat_type is
  static function ODCIAggregateInitialize(sctx IN OUT strcat_type)
    return number is
  BEGIN
    SCTX := strcat_type(NULL);
    RETURN ODCICONST.SUCCESS;
  END;
  MEMBER FUNCTION ODCIAGGREGATEITERATE(SELF IN OUT strcat_type,P1 IN VARCHAR2) RETURN NUMBER IS
  BEGIN
    IF (CURR_STR IS NOT NULL) THEN
      CURR_STR := CURR_STR || ',' || P1;
    ELSE
      CURR_STR := P1;
    END IF;
    RETURN ODCICONST.SUCCESS;
  END;
  MEMBER FUNCTION ODCIAGGREGATETERMINATE(SELF IN strcat_type,  RETURNVALUE OUT clob,  FLAGS IN NUMBER) RETURN NUMBER IS
  BEGIN
    RETURNVALUE := CURR_STR;
    RETURN ODCICONST.SUCCESS;
  END;
  MEMBER FUNCTION ODCIAGGREGATEMERGE(SELF  IN OUT strcat_type, SCTX2 IN strcat_type) RETURN NUMBER IS
  BEGIN
    IF (SCTX2.CURR_STR IS NOT NULL) THEN
      SELF.CURR_STR := SELF.CURR_STR || ',' || SCTX2.CURR_STR;
    END IF;
    RETURN ODCICONST.SUCCESS;
  END;
END;
```


改clob为varchar2
```
alter table tablename add (new_column varchar2(4000));
update tablename set new_column=dbms_lob.substr(old_column,1000,1);
alter table tablename drop column old_column;
alter table tablename rename column new_column to old_column;
```