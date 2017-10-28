CREATE PROCEDURE WSL_FlexDefList  
 @page  int  
 ,@size  int  
 ,@sort   nvarchar(200)  
 ,@parm1 varchar (15) -- FieldClassName  
 AS  
  SET NOCOUNT ON  
  DECLARE  
    @STMT nvarchar(max),    -- SQL statement to execute  
    @lbound int,  
    @ubound int,  
    @fieldlist nvarchar(max) =   
    'Align00 [Alignment Segment 1],  
	  Align01 [Alignment Segment 2],  
	  Align02 [Alignment Segment 3],  
	  Align03 [Alignment Segment 4],  
	  Align04 [Alignment Segment 5],  
	  Align05 [Alignment Segment 6],  
	  Align06 [Alignment Segment 7],  
	  Align07 [Alignment Segment 8],  
	  Caption [Caption],  
	  Descr00 [Description Segment 1],  
	  Descr01 [Description Segment 2],  
	  Descr02 [Description Segment 3],  
	  Descr03 [Description Segment 4],  
	  Descr04 [Description Segment 5],  
	  Descr05 [Description Segment 6],  
	  Descr06 [Description Segment 7],  
	  Descr07 [Description Segment 8],  
	  EditMask00 [Edit Type  Segment 1],  
	  EditMask01 [Edit Type  Segment 2],  
	  EditMask02 [Edit Type  Segment 3],  
	  EditMask03 [Edit Type  Segment 4],  
	  EditMask04 [Edit Type  Segment 5],  
	  EditMask05 [Edit Type  Segment 6],  
	  EditMask06 [Edit Type  Segment 7],  
	  EditMask07 [Edit Type  Segment 8],  
	  FieldClassName [Field Type],  
	  FillChar00 [Fill Character Segment 1],  
	  FillChar01 [Fill Character Segment 2],  
	  FillChar02 [Fill Character Segment 3],  
	  FillChar03 [Fill Character Segment 4],  
	  FillChar04 [Fill Character Segment 5],  
	  FillChar05 [Fill Character Segment 6],  
	  FillChar06 [Fill Character Segment 7],  
	  FillChar07 [Fill Character Segment 8],  
	  MaxFieldLen [Maximum Field Length],  
	  MaxSegments [Maximum Segments],  
	  NumberSegments [Number of Segments],  
	  SegLength00 [Segment Length 1],  
	  SegLength01 [Segment Length 2],  
	  SegLength02 [Segment Length 3],  
	  SegLength03 [Segment Length 4],  
	  SegLength04 [Segment Length 5],  
	  SegLength05 [Segment Length 6],  
	  SegLength06 [Segment Length 7],  
	  SegLength07 [Segment Length 8],  
	  Seperator00 [Seperator Segment 1],  
	  Seperator01 [Seperator Segment 2],  
	  Seperator02 [Seperator Segment 3],  
	  Seperator03 [Seperator Segment 4],  
	  Seperator04 [Seperator Segment 5],  
	  Seperator05 [Seperator Segment 6],  
	  Seperator06 [Seperator Segment 7],  
	  User1 [User1],  
	  User2 [User2],  
	  User3 [User3],  
	  User4 [User4],  
	  Validate00 [Validate Segment 1],  
	  Validate01 [Validate Segment 2],  
	  Validate02 [Validate Segment 3],  
	  Validate03 [Validate Segment 4],  
	  Validate04 [Validate Segment 5],  
	  Validate05 [Validate Segment 6],  
	  Validate06 [Validate Segment 7],  
	  Validate07 [Validate Segment 8],  
	  ValidCombosRequired [Valid Combos Required]'  
      
    IF @sort = '' SET @sort = 'FieldClassName'  
   
  IF @page = 0  -- Don't do paging  
   BEGIN  
  SET @STMT =   
   'SELECT ' + @fieldlist + '  
    FROM FlexDef (nolock)  
    WHERE FieldClassName LIKE ' + quotename(@parm1,'''') + '   
    ORDER BY ' + @sort  
   END     
  ELSE  
   BEGIN  
   IF @page < 1 SET @page = 1  
   IF @size < 1 SET @size = 1  
   SET @lbound = (@page-1) * @size  
   SET @ubound = @page * @size + 1  
   SET @STMT =   
    'WITH PagingCTE AS  
    (  
    SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') *,  
    ROW_NUMBER() OVER(  
    ORDER BY ' + @sort + ') AS row  
    FROM FlexDef (nolock)  
       WHERE FieldClassName LIKE ' + quotename(@parm1,'''') + '   
    )   
    SELECT ' + @fieldlist + '
    FROM PagingCTE                       
    WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND  
        row <  ' + CONVERT(varchar(9), @ubound) + '  
    ORDER BY row'  
   END      
  EXEC (@STMT)   

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_FlexDefList] TO [MSDSL]
    AS [dbo];

