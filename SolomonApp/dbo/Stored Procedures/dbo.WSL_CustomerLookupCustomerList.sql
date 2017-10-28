
CREATE PROCEDURE WSL_CustomerLookupCustomerList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@Phone varchar(30)  
 ,@NameSeg1 varchar(20)
 ,@NameSeg2 varchar(20)  
 ,@NameSeg3 varchar(20)  
 ,@NameSeg4 varchar(20)  
 ,@NameSeg5 varchar(20)   
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'CustID'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
	  IF @NameSeg5 <> ''
	  BEGIN
		SET @STMT = 'WITH CustLkpTemp AS
		(
		  SELECT d1.CustID  
			FROM CustNameXref d1  
			JOIN CustNameXref d2 ON d2.CustID = d1.CustID  
			JOIN CustNameXref d3 ON d3.CustID = d1.CustID  
			JOIN CustNameXref d4 ON d4.CustID = d1.CustID  
			JOIN CustNameXref d5 ON d5.CustID = d1.CustID  
				WHERE d1.NameSeg LIKE ' + quotename(@NameSeg1,'''') + ' AND  
				d2.NameSeg LIKE ' + quotename(@NameSeg2,'''') + ' AND  
				d3.NameSeg LIKE ' + quotename(@NameSeg3,'''') + ' AND  
				d4.NameSeg LIKE ' + quotename(@NameSeg4,'''') + ' AND  
				d5.NameSeg LIKE ' + quotename(@NameSeg5,'''') + ' 
		)'
		goto SELECTIT
	  END
	  IF @NameSeg4 <> ''
	  BEGIN
		SET @STMT = 'WITH CustLkpTemp AS
		(
		  SELECT d1.CustID  
			FROM CustNameXref d1  
			JOIN CustNameXref d2 ON d2.CustID = d1.CustID  
			JOIN CustNameXref d3 ON d3.CustID = d1.CustID  
			JOIN CustNameXref d4 ON d4.CustID = d1.CustID  
				WHERE d1.NameSeg LIKE ' + quotename(@NameSeg1,'''') + ' AND  
				d2.NameSeg LIKE ' + quotename(@NameSeg2,'''') + ' AND  
				d3.NameSeg LIKE ' + quotename(@NameSeg3,'''') + ' AND  
				d4.NameSeg LIKE ' + quotename(@NameSeg4,'''') + '
		)'
		goto SELECTIT
	  END
	  IF @NameSeg3 <> ''
	  BEGIN
		SET @STMT = 'WITH CustLkpTemp AS
		(
		  SELECT d1.CustID  
			FROM CustNameXref d1  
			JOIN CustNameXref d2 ON d2.CustID = d1.CustID  
			JOIN CustNameXref d3 ON d3.CustID = d1.CustID  
				WHERE d1.NameSeg LIKE ' + quotename(@NameSeg1,'''') + ' AND  
				d2.NameSeg LIKE ' + quotename(@NameSeg2,'''') + ' AND  
				d3.NameSeg LIKE ' + quotename(@NameSeg3,'''') + ' 
		)'
		goto SELECTIT
	  END
	  IF @NameSeg2 <> ''
	  BEGIN
		SET @STMT = 'WITH CustLkpTemp AS
		(
		  SELECT d1.CustID  
			FROM CustNameXref d1  
			JOIN CustNameXref d2 ON d2.CustID = d1.CustID  
				WHERE d1.NameSeg LIKE ' + quotename(@NameSeg1,'''') + ' AND  
				d2.NameSeg LIKE ' + quotename(@NameSeg2,'''') + ' 
		)'
		goto SELECTIT
	  END
	  IF @NameSeg1 <> ''
	  BEGIN
		SET @STMT = 'WITH CustLkpTemp AS
		(
		  SELECT d1.CustID  
			FROM CustNameXref d1  
				WHERE d1.NameSeg LIKE ' + quotename(@NameSeg1,'''') + '
		)'
		goto SELECTIT
	  END
	  
SELECTIT:
 -- If no name segments were passed.  
 IF @NameSeg1 = ''  
  
 BEGIN  
  -- If no phone was passed.  
  IF @Phone = ''  
  BEGIN  
   SET @STMT = 'SELECT CustID [Customer ID], Name [Customer Name], Phone [Phone Number]  
   FROM Customer  
   ORDER BY ' + @sort 
  END  
  ELSE  
  BEGIN  
   SET @STMT = 'SELECT CustID [Customer ID], Name [Customer Name], Phone [Phone Number] 
   FROM Customer  
   WHERE Phone LIKE ' + quotename(@Phone,'''') + '  
   ORDER BY ' + @sort   
  END  
 END  
 ELSE  
 BEGIN  
  -- If one or more name segments were passed.  
  IF @sort = 'CustID' SET @sort = 'CustLkpTemp.CustID'
  -- If no phone was passed.  
  IF @Phone = ''  
  BEGIN  
   SET @STMT = @STMT + 'SELECT distinct CustLkpTemp.CustID [Customer ID], Name [Customer Name], Phone [Phone Number]
   FROM CustLkpTemp  
   LEFT JOIN Customer ON Customer.CustID = CustLkpTemp.CustID  
   ORDER BY ' + @sort   
  END  
  ELSE  
  BEGIN  
   SET @STMT = @STMT + 'SELECT distinct CustLkpTemp.CustID [Customer ID], Name [Customer Name], Phone [Phone Number] 
   FROM CustLkpTemp  
   LEFT JOIN Customer ON Customer.CustID = CustLkpTemp.CustID  
   WHERE Phone LIKE ' + quotename(@Phone,'''') + '  
   ORDER BY ' + @sort  
  END  
END  
	  END		 
  ELSE
	  BEGIN
			IF @page < 1 SET @page = 1
			IF @size < 1 SET @size = 1
			SET @lbound = (@page-1) * @size
			SET @ubound = @page * @size + 1
	IF @NameSeg5 <> ''
	  BEGIN
		SET @STMT = 'WITH CustLkpTemp AS
		(
		  SELECT d1.CustID  
			FROM CustNameXref d1  
			JOIN CustNameXref d2 ON d2.CustID = d1.CustID  
			JOIN CustNameXref d3 ON d3.CustID = d1.CustID  
			JOIN CustNameXref d4 ON d4.CustID = d1.CustID  
			JOIN CustNameXref d5 ON d5.CustID = d1.CustID  
				WHERE d1.NameSeg LIKE ' + quotename(@NameSeg1,'''') + ' AND  
				d2.NameSeg LIKE ' + quotename(@NameSeg2,'''') + ' AND  
				d3.NameSeg LIKE ' + quotename(@NameSeg3,'''') + ' AND  
				d4.NameSeg LIKE ' + quotename(@NameSeg4,'''') + ' AND  
				d5.NameSeg LIKE ' + quotename(@NameSeg5,'''') + ' 
		)'
		goto PAGING
	  END
	  IF @NameSeg4 <> ''
	  BEGIN
		SET @STMT = 'WITH CustLkpTemp AS
		(
		  SELECT d1.CustID  
			FROM CustNameXref d1  
			JOIN CustNameXref d2 ON d2.CustID = d1.CustID  
			JOIN CustNameXref d3 ON d3.CustID = d1.CustID  
			JOIN CustNameXref d4 ON d4.CustID = d1.CustID  
				WHERE d1.NameSeg LIKE ' + quotename(@NameSeg1,'''') + ' AND  
				d2.NameSeg LIKE ' + quotename(@NameSeg2,'''') + ' AND  
				d3.NameSeg LIKE ' + quotename(@NameSeg3,'''') + ' AND  
				d4.NameSeg LIKE ' + quotename(@NameSeg4,'''') + '
		)'
		goto PAGING
	  END
	  IF @NameSeg3 <> ''
	  BEGIN
		SET @STMT = 'WITH CustLkpTemp AS
		(
		  SELECT d1.CustID  
			FROM CustNameXref d1  
			JOIN CustNameXref d2 ON d2.CustID = d1.CustID  
			JOIN CustNameXref d3 ON d3.CustID = d1.CustID  
				WHERE d1.NameSeg LIKE ' + quotename(@NameSeg1,'''') + ' AND  
				d2.NameSeg LIKE ' + quotename(@NameSeg2,'''') + ' AND  
				d3.NameSeg LIKE ' + quotename(@NameSeg3,'''') + ' 
		)'
		goto PAGING
	  END
	  IF @NameSeg2 <> ''
	  BEGIN
		SET @STMT = 'WITH CustLkpTemp AS
		(
		  SELECT d1.CustID  
			FROM CustNameXref d1  
			JOIN CustNameXref d2 ON d2.CustID = d1.CustID  
				WHERE d1.NameSeg LIKE ' + quotename(@NameSeg1,'''') + ' AND  
				d2.NameSeg LIKE ' + quotename(@NameSeg2,'''') + ' 
		)'
		goto PAGING
	  END
	  IF @NameSeg1 <> ''
	  BEGIN
		SET @STMT = 'WITH CustLkpTemp AS
		(
		  SELECT d1.CustID  
			FROM CustNameXref d1  
				WHERE d1.NameSeg LIKE ' + quotename(@NameSeg1,'''') + '
		)'
		goto PAGING
	  END
	  
PAGING:
 -- If no name segments were passed.  
 IF @NameSeg1 = ''  
  
 BEGIN  
 			SET @STMT =  
				'WITH PagingCTE AS
				(
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ')'
  -- If no phone was passed.  
  IF @Phone = ''  
  BEGIN  
   SET @STMT = @STMT + ' CustID, Name, Phone
   ,ROW_NUMBER() OVER(
	ORDER BY ' + @sort + ') AS row    
   FROM Customer  
   )'
  END  
  ELSE  
  BEGIN  
   SET @STMT = @STMT + ' CustID, Name, Phone
   ,ROW_NUMBER() OVER(
	ORDER BY ' + @sort + ') AS row    
   FROM Customer  
   WHERE Phone LIKE ' + quotename(@Phone,'''') + '  
   )'  
  END  
 END  
 ELSE  
 BEGIN  
  -- If one or more name segments were passed.  
  			SET @STMT = @STMT + 
				', PagingCTE AS
				(
				SELECT distinct TOP(' + CONVERT(varchar(9), @ubound-1) + ')'
 IF @sort = 'CustID' SET @sort = 'CustLkpTemp.CustID'
  -- If no phone was passed.  
  IF @Phone = ''  
  BEGIN  
   SET @STMT = @STMT + ' CustLkpTemp.CustID, Name, Phone  
    ,ROW_NUMBER() OVER(
	ORDER BY ' + @sort + ') AS row  
   FROM CustLkpTemp  
   LEFT JOIN Customer ON Customer.CustID = CustLkpTemp.CustID  
   )'  
  END  
  ELSE  
  BEGIN  
   SET @STMT = @STMT + ' CustLkpTemp.CustID, Name, Phone
   ,ROW_NUMBER() OVER(
	ORDER BY ' + @sort + ') AS row  
   FROM CustLkpTemp  
   LEFT JOIN Customer ON Customer.CustID = CustLkpTemp.CustID  
   WHERE Phone LIKE ' + quotename(@Phone,'''') + '  
	)'
  END  
END  
			SET @STMT = @STMT + 
				'SELECT CustID [Customer ID], Name [Customer Name], Phone [Phone Number]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 
