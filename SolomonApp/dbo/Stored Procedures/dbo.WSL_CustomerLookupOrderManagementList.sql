
CREATE PROCEDURE WSL_CustomerLookupOrderManagementList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@CpnyID varchar(10)  
 ,@OrdNbr varchar(15)  
 ,@InvcNbr varchar(10)  
 ,@ProjectID varchar(16)  
 ,@CustOrdNbr varchar(15)  
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @CpnyID = '' SET @CpnyID = '%'
	IF @OrdNbr = '' SET @OrdNbr = '%'
	IF @InvcNbr = '' SET @InvcNbr = '%'
	IF @ProjectID = '' SET @ProjectID = '%'
	IF @CustOrdNbr = '' SET @CustOrdNbr = '%'
    
    IF @sort = '' SET @sort = 'SOHeader.CustID, SOHeader.OrdNbr'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT SOHeader.CustID [Customer ID], Customer.Name [Customer Name], Customer.Phone [Phone Number], SOShipHeader.InvcNbr [Invoice Number],
					SOHeader.OrdNbr [Order Number], SOHeader.CustOrdNbr [Customer Order Number], SOHeader.ProjectID [Project ID], 
					SOHeader.SOTypeID [Sales Order Type ID], SOHeader.CuryTotOrd [Total Order], SOHeader.OrdDate [Order Date] 
			 FROM SOHeader(nolock) LEFT JOIN Customer ON Customer.CustID = SOHeader.CustID  
					LEFT JOIN SOShipHeader ON SOShipHeader.OrdNbr = SOHeader.OrdNbr  
			 WHERE SOHeader.CpnyID = ' + quotename(@CpnyID,'''') + ' AND  
				SOHeader.OrdNbr LIKE ' + quotename(@OrdNbr,'''') + ' AND  
				SOHeader.ProjectID LIKE ' + quotename(@ProjectID,'''') + ' AND  
				SOHeader.CustOrdNbr LIKE ' + quotename(@CustOrdNbr,'''')  
		IF @InvcNbr <> '%' SET @STMT = @STMT + ' AND SOShipHeader.InvcNbr LIKE ' + quotename(@InvcNbr,'''')
		SET @STMT = @STMT + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') SOHeader.CustID, Customer.Name, Customer.Phone, SOShipHeader.InvcNbr, SOHeader.OrdNbr, SOHeader.CustOrdNbr,  
					SOHeader.ProjectID, SOHeader.SOTypeID, SOHeader.CuryTotOrd, SOHeader.OrdDate 
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM SOHeader(nolock) LEFT JOIN Customer ON Customer.CustID = SOHeader.CustID  
					LEFT JOIN SOShipHeader ON SOShipHeader.OrdNbr = SOHeader.OrdNbr  
					WHERE SOHeader.CpnyID = ' + quotename(@CpnyID,'''') + ' AND  
					SOHeader.OrdNbr LIKE ' + quotename(@OrdNbr,'''') + ' AND  
					SOHeader.ProjectID LIKE ' + quotename(@ProjectID,'''') + ' AND  
					SOHeader.CustOrdNbr LIKE ' + quotename(@CustOrdNbr,'''')  
			IF @InvcNbr <> '%' SET @STMT = @STMT + ' AND SOShipHeader.InvcNbr LIKE ' + quotename(@InvcNbr,'''')
			SET @STMT = @STMT + ' 
				) 
				SELECT CustID [Customer ID], Name [Customer Name], Phone [Phone Number], InvcNbr [Invoice Number],
					OrdNbr [Order Number], CustOrdNbr [Customer Order Number], ProjectID [Project ID], 
					SOTypeID [Sales Order Type ID], CuryTotOrd [Total Order], OrdDate [Order Date] 
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 
