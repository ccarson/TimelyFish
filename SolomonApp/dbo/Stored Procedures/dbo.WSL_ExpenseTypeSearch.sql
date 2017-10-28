
CREATE PROCEDURE WSL_ExpenseTypeSearch 
 @page  int  
 ,@size  int  
 ,@sort   nvarchar(200)  
 ,@parm1 varchar (6) -- Expense Type, with % before and after
 ,@parm2 varchar (40) -- Description, with % before and after
AS  
  SET NOCOUNT ON  
  DECLARE  
    @STMT nvarchar(max),   
    @lbound int,  
    @ubound int ,
    @whereExpression nvarchar(180)
      
	SET @whereExpression = ''

	IF @parm1 IS NOT NULL AND LEN(@parm1) > 0
	BEGIN
		SET @whereExpression = @whereExpression + 'PJEXPTYP.Exp_type LIKE ' + QUOTENAME(@parm1, '''');
		IF @parm2 IS NOT NULL AND LEN(@parm2) > 0
			SET @whereExpression = @whereExpression + ' AND PJEXPTYP.desc_exp LIKE ' + QUOTENAME(@parm2, '''');
	ELSE IF @parm2 IS NOT NULL AND LEN(@parm2) > 0
		SET @whereExpression = @whereExpression + 'PJEXPTYP.desc_exp LIKE ' + QUOTENAME(@parm2, '''');
	END    

	IF @sort = '' 
	BEGIN
		IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'PJEXPTYP.desc_exp'
		ELSE SET @sort = 'PJEXPTYP.Exp_type'
	END

	IF @sort = 'Type' SET @sort = 'PJEXPTYP.Exp_type'
	ELSE IF @sort = 'Description' SET @sort = 'PJEXPTYP.desc_exp'
     
  IF @page = 0  -- Don't do paging  
   BEGIN  
  SET @STMT =   
   'SELECT exp_type [Type], desc_exp [Description], default_rate [Rate],
    case when exists(select * from PJ_Account where gl_acct in (select gl_acct from PJEXPTYP where exp_type like ' + quotename(@parm1,'''') + '))
	then 1 else 0 end [HasProjectAccount]
    FROM PJEXPTYP (nolock)  
    where ' + @whereExpression + '  
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
    SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') exp_type, desc_exp, default_rate,
	case when exists(select * from PJ_Account where gl_acct in (select gl_acct from PJEXPTYP where exp_type like ' + quotename(@parm1,'''') + '))
	then 1 else 0 end [HasProjectAccount]   
    ,ROW_NUMBER() OVER(  
    ORDER BY ' + @sort + ') AS row  
    FROM PJEXPTYP (nolock)  
    where ' + @whereExpression + '
    )   
    SELECT exp_type [Type], desc_exp [Description], default_rate [Rate], HasProjectAccount
    FROM PagingCTE                       
    WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND  
        row <  ' + CONVERT(varchar(9), @ubound) + '  
    ORDER BY row'  
   END      
  EXEC (@STMT)   

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ExpenseTypeSearch] TO [MSDSL]
    AS [dbo];

