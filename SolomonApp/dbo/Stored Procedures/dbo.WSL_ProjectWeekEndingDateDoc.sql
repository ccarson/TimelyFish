  
CREATE PROCEDURE WSL_ProjectWeekEndingDateDoc
 @page  int  
 ,@size  int  
 ,@sort   nvarchar(200)  
 ,@parm1 smalldatetime -- Post Date
 ,@parm2 varchar(10) -- Employee ID 
 AS  
  SET NOCOUNT ON  
  DECLARE  
    @STMT nvarchar(max),   
    @lbound int,  
    @ubound int  
      
    IF @sort = '' SET @sort = 'PJLABHDR.docnbr'  
     
  IF @page = 0  -- Don't do paging  
   BEGIN  
  SET @STMT =   
   'SELECT docnbr [Doc Number]  
    FROM PJLABHDR(nolock)  
    where pe_date = ' + quotename(@parm1,'''') + '
		and employee = ' + quotename(@parm2,'''') + ' 
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
    SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') docnbr  
    ,ROW_NUMBER() OVER(  
    ORDER BY ' + @sort + ') AS row  
    FROM PJLABHDR(nolock)  
     where pe_date = ' + quotename(@parm1,'''') + '   
		and employee = ' + quotename(@parm2,'''') + '
    )   
    SELECT docnbr [Doc Number]  
    FROM PagingCTE                       
    WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND  
        row <  ' + CONVERT(varchar(9), @ubound) + '  
    ORDER BY row'  
   END      
  EXEC (@STMT)   

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectWeekEndingDateDoc] TO [MSDSL]
    AS [dbo];

