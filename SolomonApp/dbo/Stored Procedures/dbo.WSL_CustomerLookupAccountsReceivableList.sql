
CREATE PROCEDURE WSL_CustomerLookupAccountsReceivableList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@CpnyID varchar(10)  
 ,@RefNbr varchar(10)  
 ,@PerEnt varchar(6)  
 ,@ProjectID varchar(16)  
 ,@CustOrdNbr varchar(25)  
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @CpnyID = '' SET @CpnyID = '%'
	IF @RefNbr = '' SET @RefNbr = '%'
	IF @PerEnt = '' SET @PerEnt = '%'
	IF @ProjectID = '' SET @ProjectID = '%'
	IF @CustOrdNbr = '' SET @CustOrdNbr = '%'

    IF @sort = '' SET @sort = 'ARDoc.CustID, RefNbr'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT ARDoc.CustID [Customer ID], Customer.Name [Customer Name], Customer.Phone [Phone Number], RefNbr [Reference Number], 
				OrdNbr [Order Number], CustOrdNbr [Customer Order Number], ProjectID [Project ID], DocType [Document Type], 
				BankAcct [Bank Account], BankSub [Bank Sub Account], CuryOrigDocAmt [Original Document Amount], DocDate [Document Date]
			 FROM ARDoc(nolock) LEFT JOIN Customer ON Customer.CustID = ARDoc.CustID 
				WHERE CpnyID = ' + quotename(@CpnyID,'''') + ' AND  
					RefNbr LIKE ' + quotename(@RefNbr,'''') + ' AND  
					PerEnt > ' + quotename(@PerEnt,'''') + ' AND  
					ProjectID LIKE ' + quotename(@ProjectID,'''') + ' AND  
					CustOrdNbr LIKE ' + quotename(@CustOrdNbr,'''') + '  
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') ARDoc.CustID, Customer.Name, Customer.Phone, RefNbr, OrdNbr, CustOrdNbr, ProjectID,  
				DocType, BankAcct, BankSub, CuryOrigDocAmt, DocDate  
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM ARDoc(nolock) LEFT JOIN Customer ON Customer.CustID = ARDoc.CustID 
					WHERE CpnyID = ' + quotename(@CpnyID,'''') + ' AND  
					RefNbr LIKE ' + quotename(@RefNbr,'''') + ' AND  
					PerEnt > ' + quotename(@PerEnt,'''') + ' AND  
					ProjectID LIKE ' + quotename(@ProjectID,'''') + ' AND  
					CustOrdNbr LIKE ' + quotename(@CustOrdNbr,'''') + '
				) 
				SELECT CustID [Customer ID], Name [Customer Name], Phone [Phone Number], RefNbr [Reference Number], 
				OrdNbr [Order Number], CustOrdNbr [Customer Order Number], ProjectID [Project ID], DocType [Document Type], 
				BankAcct [Bank Account], BankSub [Bank Sub Account], CuryOrigDocAmt [Original Document Amount], DocDate [Document Date]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 
