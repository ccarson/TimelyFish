
CREATE PROCEDURE WSL_OrderLookupDetail
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
 ,@OrdDateFrom varchar(10)  
 ,@OrdDateTo varchar(10) 
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
  SET @wherestr = @wherestr + ' AND SOLine.Status = ' + QUOTENAME(@LineStatus, '''') + ' AND SOSched.Status = ' + QUOTENAME(@LineStatus, '''')  
  
 IF PATINDEX('%[%]%', @InvtID) = 0 -- @invtid  <> '%'  
  SET @wherestr = @wherestr + ' AND SOLine.InvtID = ' + QUOTENAME(@InvtID, '''')  
 ELSE  
  SET @wherestr = @wherestr + ' AND SOLine.InvtID LIKE ' + QUOTENAME(@InvtID, '''')  
  IF PATINDEX('%[%]%', @SiteID) = 0 -- @siteid  <> '%'  
  SET @wherestr = @wherestr + ' AND SOLine.SiteID = ' + QUOTENAME(@SiteID, '''')  
 ELSE  
  SET @wherestr = @wherestr + ' AND SOLine.SiteID LIKE ' + QUOTENAME(@SiteID, '''')  
  SET @wherestr = @wherestr + ' AND SOHeader.OrdDate >= ' + QUOTENAME(@OrdDateFrom,'''')  
 SET @wherestr = @wherestr + ' AND SOHeader.OrdDate <= ' + QUOTENAME(@OrdDateTo,'''')  
    
    IF @sort = '' SET @sort = 'SOSched.OrdNbr'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
 IF @InvcNbr = '%'  
 BEGIN  
  SET @STMT = '  
   SELECT SOSched.OrdNbr [Order Number], SOSched.Status [Status], SOSched.LineRef [Line Number], SOSched.Hold [Hold Schedule],
 SOSched.QtyShip [Quantity], SOSched.PromDate [Date Promised], SOSched.ReqDate [Date Requested], SOSched.ShipViaID [Ship Via],
 SOSched.SiteID [Site ID], SOSched.WeekendDelivery [Weekend Delivery], SOSched.TransitTime [Transit Time],  
    SOHeader.CustID [Customer ID],  
    SOLine.InvtID [Inventory ID],  
    SOLine.Descr [Description],  
    SOHeader.ShipName [Ship-to Name],  
    SOLine.UnitDesc [UOM],  
    SOHeader.Status [Order Status]  
   FROM SOSched WITH (NOLOCK)  
     LEFT JOIN SOHeader WITH (NOLOCK) ON SOHeader.CpnyID = SOSched.CpnyID AND SOHeader.OrdNbr = SOSched.OrdNbr  
     LEFT JOIN SOLine WITH (NOLOCK) ON SOLine.CpnyID = SOSched.CpnyID AND SOLine.OrdNbr = SOSched.OrdNbr AND SOLine.LineRef = SOSched.LineRef '  
   + @wherestr + ' ORDER BY ' + @sort  
 END  
 ELSE  
 BEGIN  
  SET @wherestr = @wherestr + ' AND SOShipHeader.InvcNbr LIKE ' + QUOTENAME(@InvcNbr, '''')  
  SET @STMT = '  
    SELECT SOSched.OrdNbr [Order Number], SOSched.Status [Status], SOSched.LineRef [Line Number], SOSched.Hold [Hold Schedule],
 SOSched.QtyShip [Quantity], SOSched.PromDate [Date Promised], SOSched.ReqDate [Date Requested], SOSched.ShipViaID [Ship Via],
 SOSched.SiteID [Site ID], SOSched.WeekendDelivery [Weekend Delivery], SOSched.TransitTime [Transit Time],  
    SOHeader.CustID [Customer ID],  
    SOLine.InvtID [Inventory ID],  
    SOLine.Descr [Description],  
    SOHeader.ShipName [Ship-to Name],  
    SOLine.UnitDesc [UOM],  
    SOHeader.Status [Order Status]    
   FROM SOSched WITH (NOLOCK)  
     LEFT JOIN SOHeader WITH (NOLOCK) ON SOHeader.CpnyID = SOSched.CpnyID AND SOHeader.OrdNbr = SOSched.OrdNbr  
     LEFT JOIN SOLine WITH (NOLOCK) ON SOLine.CpnyID = SOSched.CpnyID AND SOLine.OrdNbr = SOSched.OrdNbr AND SOLine.LineRef = SOSched.LineRef  
     LEFT JOIN SOShipHeader WITH (NOLOCK) ON SOShipHeader.CpnyID = SOSched.CpnyID AND SOShipHeader.OrdNbr = SOSched.OrdNbr  '  
   + @wherestr + ' ORDER BY ' + @sort  
 END 
	  END		 
  ELSE
	  BEGIN
			IF @page < 1 SET @page = 1
			IF @size < 1 SET @size = 1
			SET @lbound = (@page-1) * @size
			SET @ubound = @page * @size + 1
IF @InvcNbr = '%'  
 BEGIN  
  SET @STMT = '  
    WITH PagingCTE AS
	(
	SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') SOSched.OrdNbr, SOSched.Status, SOSched.LineRef, SOSched.Hold,
	SOSched.QtyShip, SOSched.PromDate, SOSched.ReqDate, SOSched.ShipViaID,
	SOSched.SiteID, SOSched.WeekendDelivery, SOSched.TransitTime,  
    SOHeader.CustID,  
    SOLine.InvtID,  
    SOLine.Descr,  
    SOHeader.ShipName,  
    SOLine.UnitDesc,  
    SOHeader.Status [Order Status] 
    ,ROW_NUMBER() OVER(
	ORDER BY ' + @sort + ') AS row 
   FROM SOSched WITH (NOLOCK)  
     LEFT JOIN SOHeader WITH (NOLOCK) ON SOHeader.CpnyID = SOSched.CpnyID AND SOHeader.OrdNbr = SOSched.OrdNbr  
     LEFT JOIN SOLine WITH (NOLOCK) ON SOLine.CpnyID = SOSched.CpnyID AND SOLine.OrdNbr = SOSched.OrdNbr AND SOLine.LineRef = SOSched.LineRef '  
   + @wherestr
 END  
 ELSE  
 BEGIN  
  SET @wherestr = @wherestr + ' AND SOShipHeader.InvcNbr LIKE ' + QUOTENAME(@InvcNbr, '''')  
  SET @STMT = '  
    WITH PagingCTE AS
	(
	SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') SOSched.OrdNbr, SOSched.Status, SOSched.LineRef, SOSched.Hold,
	SOSched.QtyShip, SOSched.PromDate, SOSched.ReqDate, SOSched.ShipViaID,
	SOSched.SiteID, SOSched.WeekendDelivery, SOSched.TransitTime,  
    SOHeader.CustID,  
    SOLine.InvtID,  
    SOLine.Descr,  
    SOHeader.ShipName,  
    SOLine.UnitDesc,  
    SOHeader.Status [Order Status] 
    ,ROW_NUMBER() OVER(
	ORDER BY ' + @sort + ') AS row  
   FROM SOSched WITH (NOLOCK)  
     LEFT JOIN SOHeader WITH (NOLOCK) ON SOHeader.CpnyID = SOSched.CpnyID AND SOHeader.OrdNbr = SOSched.OrdNbr  
     LEFT JOIN SOLine WITH (NOLOCK) ON SOLine.CpnyID = SOSched.CpnyID AND SOLine.OrdNbr = SOSched.OrdNbr AND SOLine.LineRef = SOSched.LineRef  
     LEFT JOIN SOShipHeader WITH (NOLOCK) ON SOShipHeader.CpnyID = SOSched.CpnyID AND SOShipHeader.OrdNbr = SOSched.OrdNbr  '  
   + @wherestr 
 END 
			SET @STMT = @STMT + 
				') 
				SELECT OrdNbr [Order Number], Status [Status], LineRef [Line Number], Hold [Hold Schedule],
				QtyShip [Quantity], PromDate [Date Promised], ReqDate [Date Requested], ShipViaID [Ship Via],
				SiteID [Site ID], WeekendDelivery [Weekend Delivery], TransitTime [Transit Time],  
				CustID [Customer ID],  
				InvtID [Inventory ID],  
				Descr [Description],  
				ShipName [Ship-to Name],  
				UnitDesc [UOM],  
				[Order Status]  
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 
