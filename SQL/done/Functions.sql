-- strcat_type
-- strcat_typec
-- strcat
-- strcat_clob
-- StrClear
-- rm_same_str

-- define of strcat type
create or replace type strcat_type as object
( 
    currentstr varchar2(4000), 
    currentseprator varchar2(8), 
    static function ODCIAggregateInitialize(sctx IN OUT strcat_type) return number, 
    member function ODCIAggregateIterate(self IN OUT strcat_type,value IN VARCHAR2) return number, 
    member function ODCIAggregateTerminate(self IN strcat_type,returnValue OUT VARCHAR2, flags IN number) return number, 
    member function ODCIAggregateMerge(self IN OUT strcat_type,ctx2 IN strcat_type) return number 
) 

-- body of strcat type
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

-- strcat function
CREATE OR REPLACE FUNCTION strcat (input VARCHAR2) RETURN VARCHAR2 PARALLEL_ENABLE AGGREGATE USING strcat_type;

-- StrClear function
CREATE OR REPLACE FUNCTION StrClear(str clob)
       RETURN varchar2   --返回类型
AS
  v_pos number;
BEGIN
  v_pos := instr(str,';');
  IF v_pos=0 THEN
    return str;
  ELSE
    return substr(str,1,v_pos-1);
  END IF;
END StrClear;




-- rm_same_str function
create or replace function rm_same_str(oldStr clob, sign varchar2)
  return varchar2 is
    str          clob;
    currentIndex number;
    startIndex   number;
    endIndex     number;
    type str_type is table of varchar2(1000) index by binary_integer;
    arr str_type;
    Result varchar2(4000);
begin
    -- null string
    if oldStr is null then
    return('');
    end if;

    --string is too long
    if length(oldStr) > 32000 then
    return(oldStr);
    end if;
    str := oldStr;

    currentIndex := 0;
    startIndex   := 0;

    loop
    currentIndex := currentIndex + 1;
    endIndex     := instr(str, sign, 1, currentIndex);
    if (endIndex <= 0) then
      exit;
    end if;

    arr(currentIndex) :=substr(str,startIndex + 1,  endIndex - startIndex - 1);

    -- arr(currentIndex) := trim(substr(str,startIndex + 1,endIndex - startIndex - 1));
    startIndex := endIndex;
    end loop;

    --get the last string
    arr(currentIndex) := substr(str, startIndex + 1, length(str));

    --remove the same string
    for i in 1 .. currentIndex - 1 loop
    for j in i + 1 .. currentIndex loop
      if arr(i) = arr(j) then
        arr(j) := '';
      end if;
    end loop;
    end loop;

    str := '';
    for i in 1 .. currentIndex loop
    if arr(i) is not null then
      str := str || sign || arr(i);
      --set arrar to null:
      arr(i) := '';
    end if;
    end loop;

    --remove the prev mark
    Result := substr(str, 2, length(str));

    return(Result);
end rm_same_str;




-- create function strcat_clob
CREATE OR REPLACE FUNCTION strcat_clob (input VARCHAR2) RETURN clob PARALLEL_ENABLE AGGREGATE USING strcat_typec;


-- create type define
create or replace type strcat_typec as object
(
  CURR_STR clob,
  STATIC FUNCTION ODCIAGGREGATEINITIALIZE(SCTX IN OUT strcat_typec) RETURN NUMBER,
  MEMBER FUNCTION ODCIAGGREGATEITERATE(SELF IN OUT strcat_typec, P1 IN VARCHAR2) RETURN NUMBER,
  MEMBER FUNCTION ODCIAGGREGATETERMINATE(SELF IN strcat_typec, RETURNVALUE OUT clob, FLAGS IN NUMBER) RETURN NUMBER,
  MEMBER FUNCTION ODCIAGGREGATEMERGE(SELF  IN OUT strcat_typec, SCTX2 IN strcat_typec) RETURN NUMBER
)

-- create type body
create or replace type body strcat_typec is
  static function ODCIAggregateInitialize(sctx IN OUT strcat_typec)
    return number is
  BEGIN
    SCTX := strcat_typec(NULL);
    RETURN ODCICONST.SUCCESS;
  END;
  MEMBER FUNCTION ODCIAGGREGATEITERATE(SELF IN OUT strcat_typec,P1 IN VARCHAR2) RETURN NUMBER IS
  BEGIN
    IF (CURR_STR IS NOT NULL) THEN
      CURR_STR := CURR_STR || ',' || P1;
    ELSE
      CURR_STR := P1;
    END IF;
    RETURN ODCICONST.SUCCESS;
  END;
  MEMBER FUNCTION ODCIAGGREGATETERMINATE(SELF IN strcat_typec,  RETURNVALUE OUT clob,  FLAGS IN NUMBER) RETURN NUMBER IS
  BEGIN
    RETURNVALUE := CURR_STR;
    RETURN ODCICONST.SUCCESS;
  END;
  MEMBER FUNCTION ODCIAGGREGATEMERGE(SELF  IN OUT strcat_typec, SCTX2 IN strcat_typec) RETURN NUMBER IS
  BEGIN
    IF (SCTX2.CURR_STR IS NOT NULL) THEN
      SELF.CURR_STR := SELF.CURR_STR || ',' || SCTX2.CURR_STR;
    END IF;
    RETURN ODCICONST.SUCCESS;
  END;
END;