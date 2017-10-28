
CREATE PROCEDURE WSL_ARDocumentsList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- CpnyId 
 ,@parm2 varchar (10) -- refnbr
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'refnbr DESC'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT ARDoc.RefNbr [Reference Nbr], ARDoc.CustId [Customer], ARDoc.CpnyId [Company], ARDoc.DocType [Doc Type], ARDoc.DocDate [Date]
			 FROM ARDoc(nolock)
			 Where CpnyId like ' + quotename(@parm1,'''') + ' 
			 and refnbr like ' + quotename(@parm2,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') ARDoc.RefNbr, ARDoc.CustId, ARDoc.CpnyId, ARDoc.DocType, ARDoc.DocDate
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM ARDoc(nolock)
					Where CpnyId like ' + quotename(@parm1,'''') + ' and refnbr like ' + quotename(@parm2,'''') + ' 
				) 
				SELECT RefNbr [Reference Nbr], CustId [Customer], CpnyId [Company], DocType [Doc Type], DocDate [Date]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 
