
CREATE PROCEDURE WSL_OrderLookupSummary
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@CpnyID varchar(10)  
 ,@CustID varchar(15) 
 ,@CustOrdNbr varchar(25)  
 ,@Status varchar(1)  
 ,@LineStatus varchar(1)  
 ,@InvtID varchar(30)  
 ,@SiteID varchar(10)  
 ,@InvcNbr varchar(10)  
 ,@OrdDateFrom smalldatetime  
 ,@OrdDateTo smalldatetime
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
    @wherestr VARCHAR(3000)
    
    IF @CpnyID = '' SET @CpnyID = '%'
	IF @CustID = '' SET @CustID = '%'
	IF @CustOrdNbr = '' SET @CustOrdNbr = '%'
	IF @Status = '' SET @Status = '%'
	IF @LineStatus = '' SET @LineStatus = '%'
	IF @InvtID = '' SET @InvtID = '%'
	IF @SiteID = '' SET @SiteID = '%'
	IF @InvcNbr = '' SET @InvcNbr = '%'
	IF @OrdDateFrom = '' SET @OrdDateFrom = '01/01/1900'
	IF @OrdDateTo = '' SET @OrdDateTo = '01/01/2079'
    
    IF @sort = '' SET @sort = 'SOHeader.OrdNbr'
    
     SET @wherestr = ' WHERE '  
  
 IF PATINDEX('%[%]%', @CpnyID) = 0 -- @CpnyID <> '%'  
  SET @wherestr = @wherestr + ' SOHeader.CpnyID = ' + QUOTENAME(@CpnyID, '''')  
 ELSE  
  SET @wherestr = @wherestr + ' SOHeader.CpnyID LIKE ' + QUOTENAME(@CpnyID, '''')  
  IF PATINDEX('%[%]%', @CustID) = 0 -- @CustID <> '%'  
  SET @wherestr = @wherestr + ' AND SOHeader.CustID = ' + QUOTENAME(@CustID, '''')  
 ELSE  
  SET @wherestr = @wherestr + ' AND SOHeader.CustID LIKE ' + QUOTENAME(@CustID, '''')  
  
 IF PATINDEX('%[%]%', @CustOrdNbr) = 0 -- @custordnbr <> '%'  
  SET @wherestr = @wherestr + ' AND SOHeader.CustOrdNbr = ' + QUOTENAME(@CustOrdNbr, '''')  
 ELSE  
  SET @wherestr = @wherestr + ' AND SOHeader.CustOrdNbr LIKE ' + QUOTENAME(@CustOrdNbr, '''')  
  IF PATINDEX('%[%]%', @Status) = 0 -- @status <> '%'  
  SET @wherestr = @wherestr + ' AND SOHeader.Status = ' + QUOTENAME(@Status, '''')  
 ELSE  
  SET @wherestr = @wherestr + ' AND SOHeader.Status LIKE ' + QUOTENAME(@Status, '''')  
  IF @LineStatus <> '%'  
  SET @wherestr = @wherestr + ' AND SOLine.Status = ' + QUOTENAME(@LineStatus, '''')  
  
 SET @wherestr = @wherestr + ' AND SOHeader.OrdDate >= ' + QUOTENAME(@OrdDateFrom,'''')  
 SET @wherestr = @wherestr + ' AND SOHeader.OrdDate <= ' + QUOTENAME(@OrdDateTo,'''')  
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		 -- User did not specify inventory ID, site or invoice number.  
 IF @LineStatus = '%' AND @InvtID = '%' AND @SiteID = '%' AND @InvcNbr = '%'  
 BEGIN  
  SET @STMT = '  
   SELECT SOHeader.OrdNbr [Order Number], SOHeader.SOTypeID [Order Type], SOHeader.OrdDate [Order Date], SOHeader.Status [Status],
SOHeader.CustID [Customer ID], SOHeader.AdminHold [Admin Hold], SOHeader.CustOrdNbr [Cusomter PO], SOHeader.ShipName [Ship-to Name],
SOHeader.ContractNbr [Contract Number], SOHeader.BuyerName [Buyer Name] FROM SOHeader WITH (NOLOCK) '  
   + @wherestr + ' ORDER BY ' + @sort    
 END  
  
 -- User specified an invoice number.  
 IF @LineStatus = '%' AND @InvtID = '%' AND @SiteID = '%' AND @InvcNbr <> '%'  
 BEGIN  
  SET @wherestr = @wherestr + ' AND SOShipHeader.InvcNbr LIKE ' + QUOTENAME(@InvcNbr, '''')  
  SET @STMT = '  
   SELECT SOHeader.OrdNbr [Order Number], SOHeader.SOTypeID [Order Type], SOHeader.OrdDate [Order Date], SOHeader.Status [Status],
SOHeader.CustID [Customer ID], SOHeader.AdminHold [Admin Hold], SOHeader.CustOrdNbr [Cusomter PO], SOHeader.ShipName [Ship-to Name],
SOHeader.ContractNbr [Contract Number], SOHeader.BuyerName [Buyer Name] FROM SOHeader WITH (NOLOCK)  
     LEFT JOIN SOShipHeader WITH (NOLOCK) ON SOShipHeader.CpnyID = SOHeader.CpnyID AND SOShipHeader.OrdNbr = SOHeader.OrdNbr '  
   + @wherestr + ' ORDER BY ' + @sort    
 END  
  
 -- User specified inventory ID or site.  
 IF (@LineStatus <> '%' OR @InvtID <> '%' OR @SiteID <> '%') AND @InvcNbr = '%'  
 BEGIN  
  SET @wherestr = @wherestr + ' AND SOLine.InvtID LIKE ' + QUOTENAME(@InvtID, '''')  
  SET @wherestr = @wherestr + ' AND SOLine.SiteID LIKE ' + QUOTENAME(@SiteID, '''')  
  SET @STMT = '  
   SELECT SOHeader.OrdNbr [Order Number], SOHeader.SOTypeID [Order Type], SOHeader.OrdDate [Order Date], SOHeader.Status [Status],
SOHeader.CustID [Customer ID], SOHeader.AdminHold [Admin Hold], SOHeader.CustOrdNbr [Cusomter PO], SOHeader.ShipName [Ship-to Name],
SOHeader.ContractNbr [Contract Number], SOHeader.BuyerName [Buyer Name] FROM SOHeader WITH (NOLOCK)  
     LEFT JOIN SOLine WITH (NOLOCK) ON SOLine.CpnyID = SOHeader.CpnyID AND SOLine.OrdNbr = SOHeader.OrdNbr '  
   + @wherestr + ' ORDER BY ' + @sort    
 END  
  
 -- User specified inventory ID or site and also invoice number.  
 IF (@LineStatus <> '%' OR @InvtID <> '%' OR @SiteID <> '%') AND @InvcNbr <> '%'  
 BEGIN  
  SET @wherestr = @wherestr + ' AND SOShipHeader.InvcNbr LIKE ' + QUOTENAME(@InvcNbr, '''')  
  SET @wherestr = @wherestr + ' AND SOLine.InvtID LIKE ' + QUOTENAME(@InvtID, '''')  
  SET @wherestr = @wherestr + ' AND SOLine.SiteID LIKE ' + QUOTENAME(@SiteID, '''')  
  SET @STMT = '  
   SELECT SOHeader.OrdNbr [Order Number], SOHeader.SOTypeID [Order Type], SOHeader.OrdDate [Order Date], SOHeader.Status [Status],
SOHeader.CustID [Customer ID], SOHeader.AdminHold [Admin Hold], SOHeader.CustOrdNbr [Cusomter PO], SOHeader.ShipName [Ship-to Name],
SOHeader.ContractNbr [Contract Number], SOHeader.BuyerName [Buyer Name] FROM SOHeader WITH (NOLOCK)  
     LEFT JOIN SOLine WITH (NOLOCK) ON SOLine.CpnyID = SOHeader.CpnyID AND SOLine.OrdNbr = SOHeader.OrdNbr  
     LEFT JOIN SOShipHeader WITH (NOLOCK) ON SOShipHeader.CpnyID = SOHeader.CpnyID AND SOShipHeader.OrdNbr = SOHeader.OrdNbr  '  
   + @wherestr + '  ORDER BY ' + @sort  
 END
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ')'
				
-- User did not specify inventory ID, site or invoice number.  
 IF @LineStatus = '%' AND @InvtID = '%' AND @SiteID = '%' AND @InvcNbr = '%'  
 BEGIN  
  SET @STMT = @STMT + '  
   SOHeader.OrdNbr, SOHeader.SOTypeID, SOHeader.OrdDate, SOHeader.Status, SOHeader.CustID, SOHeader.AdminHold,
 SOHeader.CustOrdNbr, SOHeader.ShipName, SOHeader.ContractNbr, SOHeader.BuyerName ,ROW_NUMBER() OVER(ORDER BY ' + @sort + ') AS row FROM SOHeader WITH (NOLOCK) '  
   + @wherestr + ')'   
 END  
  
 -- User specified an invoice number.  
 IF @LineStatus = '%' AND @InvtID = '%' AND @SiteID = '%' AND @InvcNbr <> '%'  
 BEGIN  
  SET @wherestr = @wherestr + ' AND SOShipHeader.InvcNbr LIKE ' + QUOTENAME(@InvcNbr, '''')  
  SET @STMT = @STMT + '  
   SOHeader.OrdNbr, SOHeader.SOTypeID, SOHeader.OrdDate, SOHeader.Status, SOHeader.CustID, SOHeader.AdminHold,
 SOHeader.CustOrdNbr, SOHeader.ShipName, SOHeader.ContractNbr, SOHeader.BuyerName ,ROW_NUMBER() OVER(ORDER BY ' + @sort + ') AS row FROM SOHeader WITH (NOLOCK)  
     LEFT JOIN SOShipHeader WITH (NOLOCK) ON SOShipHeader.CpnyID = SOHeader.CpnyID AND SOShipHeader.OrdNbr = SOHeader.OrdNbr '  
   + @wherestr + ')'  
 END  
  
 -- User specified inventory ID or site.  
 IF (@LineStatus <> '%' OR @InvtID <> '%' OR @SiteID <> '%') AND @InvcNbr = '%'  
 BEGIN  
  SET @wherestr = @wherestr + ' AND SOLine.InvtID LIKE ' + QUOTENAME(@InvtID, '''')  
  SET @wherestr = @wherestr + ' AND SOLine.SiteID LIKE ' + QUOTENAME(@SiteID, '''')  
  SET @STMT = @STMT + '  
   SOHeader.OrdNbr, SOHeader.SOTypeID, SOHeader.OrdDate, SOHeader.Status, SOHeader.CustID, SOHeader.AdminHold,
 SOHeader.CustOrdNbr, SOHeader.ShipName, SOHeader.ContractNbr, SOHeader.BuyerName ,ROW_NUMBER() OVER(ORDER BY ' + @sort + ') AS row FROM SOHeader WITH (NOLOCK)  
     LEFT JOIN SOLine WITH (NOLOCK) ON SOLine.CpnyID = SOHeader.CpnyID AND SOLine.OrdNbr = SOHeader.OrdNbr '  
   + @wherestr + ')'   
 END  
  
 -- User specified inventory ID or site and also invoice number.  
 IF (@LineStatus <> '%' OR @InvtID <> '%' OR @SiteID <> '%') AND @InvcNbr <> '%'  
 BEGIN  
  SET @wherestr = @wherestr + ' AND SOShipHeader.InvcNbr LIKE ' + QUOTENAME(@InvcNbr, '''')  
  SET @wherestr = @wherestr + ' AND SOLine.InvtID LIKE ' + QUOTENAME(@InvtID, '''')  
  SET @wherestr = @wherestr + ' AND SOLine.SiteID LIKE ' + QUOTENAME(@SiteID, '''')  
  SET @STMT = @STMT + '  
   SOHeader.OrdNbr, SOHeader.SOTypeID, SOHeader.OrdDate, SOHeader.Status, SOHeader.CustID, SOHeader.AdminHold,
 SOHeader.CustOrdNbr, SOHeader.ShipName, SOHeader.ContractNbr, SOHeader.BuyerName ,ROW_NUMBER() OVER(ORDER BY ' + @sort + ') AS row FROM SOHeader WITH (NOLOCK)  
     LEFT JOIN SOLine WITH (NOLOCK) ON SOLine.CpnyID = SOHeader.CpnyID AND SOLine.OrdNbr = SOHeader.OrdNbr  
     LEFT JOIN SOShipHeader WITH (NOLOCK) ON SOShipHeader.CpnyID = SOHeader.CpnyID AND SOShipHeader.OrdNbr = SOHeader.OrdNbr  '  
   + @wherestr + ')' 
 END
			SET @STMT = @STMT +  
				' 
				SELECT OrdNbr [Order Number], SOTypeID [Order Type], OrdDate [Order Date], Status [Status],
CustID [Customer ID], AdminHold [Admin Hold], CustOrdNbr [Cusomter PO], ShipName [Ship-to Name],
ContractNbr [Contract Number], BuyerName [Buyer Name]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 
