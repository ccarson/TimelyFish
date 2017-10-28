 CREATE PROC ut_fieldlist @table_name VARCHAR(50), @Counter INT = 5, @Indent INT = 0
AS
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-2000 All Rights Reserved
**    Proc Name: ut_fieldlist
**++* Narrative: Internal developer tool used to make a common delimited column list.
*               Identity and timestamp columns are excluded. The output is suitable as a
*               value list for coding sql statements in stored procs or views.
**    Inputs   : @table_name VARCHAR(50) Workstation id of caller
*               @Counter    INT      	Number of columns per line, default 5
*               @Indent     INT    	number of spaces to indent each line, default 0
*
*/

DECLARE @Col_String VARCHAR(256)
DECLARE @Hold_Name  VARCHAR(50)
DECLARE @CurCount  INT

DECLARE Fld_Csr CURSOR KEYSET for
          SELECT name
            FROM SysColumns
           WHERE ID = OBJECT_ID(@table_name) AND xtype NOT IN (189) -- 189 tstamp
                                            AND AutoVal IS  NULL  --- identity
           ORDER BY colid

OPEN Fld_Csr

IF @@CURSOR_ROWS = 0
BEGIN
  PRINT 'Could Not Find Table'
  CLOSE Fld_Csr
  DEALLOCATE Fld_Csr
  GOTO FINISH
END
IF @@ERROR <> 0 GOTO FINISH

SELECT @CurCount = 0, @Col_String = SPACE(@Indent)

FETCH Fld_Csr
 INTO @Hold_name
IF @@ERROR <> 0 GOTO FINISH

WHILE @@FETCH_STATUS = 0
BEGIN
   IF @CurCount = @Counter
   BEGIN
      PRINT  @Col_String
      SELECT @Col_String = SPACE(@Indent), @CurCount = 0
   END
   SET @Col_String = @Col_String + @Hold_Name + ', '
   SET @CurCount = @CurCount + 1

   FETCH Fld_Csr
    INTO @Hold_name
   IF @@ERROR <> 0
   BEGIN
     CLOSE Fld_Csr
     DEALLOCATE Fld_Csr
     GOTO FINISH
   END
END
SELECT   @Col_String = SubString(@Col_String,1,DATALENGTH(@Col_String)-2)
Print @Col_String

CLOSE Fld_Csr
DEALLOCATE Fld_Csr

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ut_fieldlist] TO [MSDSL]
    AS [dbo];

