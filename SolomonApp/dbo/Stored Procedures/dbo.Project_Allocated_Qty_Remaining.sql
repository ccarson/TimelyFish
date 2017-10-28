CREATE PROCEDURE Project_Allocated_Qty_Remaining
        @InvtID varchar(30),
	@SiteID varchar(10),
	@RcptRefNbr varchar(15),
	@AllocDate varchar(10),
	@PoNbr varchar(10),
        @projectID varchar(16),
        @TaskID varchar(32),
        @WhseLoc varchar(10)
AS

	DECLARE	@sql 	VARCHAR(8000),
		@wherestr VARCHAR(3000)

	SELECT @wherestr = ' WHERE '

	IF PATINDEX('%[%]%', @RcptRefNbr) = 0 
		SELECT @wherestr = @wherestr + ' InvProjAlloc.SrcNbr = ' + QUOTENAME(@RcptRefNbr, '''')
	ELSE
		SELECT @wherestr = @wherestr + ' InvProjAlloc.SrcNbr LIKE ' + QUOTENAME(@RcptRefNbr, '''')
 	IF PATINDEX('%[%]%', @PoNbr) = 0 
		SELECT @wherestr = @wherestr + ' AND InvProjalloc.PoNbr = ' + QUOTENAME(@PoNbr, '''')
	ELSE
		SELECT @wherestr = @wherestr + ' AND InvProjAlloc.PoNbr LIKE ' + QUOTENAME(@PoNbr, '''')

	IF PATINDEX('%[%]%', @ProjectID) = 0 
		SELECT @wherestr = @wherestr + ' AND InvProjAlloc.ProjectID = ' + QUOTENAME(@ProjectID, '''')
	ELSE
		SELECT @wherestr = @wherestr + ' AND InvProjAlloc.ProjectID LIKE ' + QUOTENAME(@ProjectID, '''')
 	IF PATINDEX('%[%]%', @TaskID) = 0 
		SELECT @wherestr = @wherestr + ' AND InvProjAlloc.TaskID = ' + QUOTENAME(@TaskId, '''')
	ELSE
		SELECT @wherestr = @wherestr + ' AND InvProjAlloc.TaskId LIKE ' + QUOTENAME(@TaskID, '''')
 	
	If @AllocDate = '01/01/1900'
	   SELECT @wherestr = @wherestr + ' AND InvProjAlloc.SrcDate >= ' + QUOTENAME(@allocDate,'''')
	else
           SELECT @wherestr = @wherestr + ' AND InvProjAlloc.SrcDate = ' + QUOTENAME(@allocDate,'''')

	
	
	-- Inventory ID and site is passesd in.
	SELECT @wherestr = @wherestr + ' AND InvProjAlloc.InvtID = ' + QUOTENAME(@InvtID, '''')
	SELECT @wherestr = @wherestr + ' AND InvProjAlloc.SiteID = ' + QUOTENAME(@SiteID, '''')
        SELECT @wherestr = @wherestr + ' AND InvProjAlloc.WhseLoc = ' + QUOTENAME(@WhseLoc, '''')
	SELECT @sql = 'SELECT * FROM InvProjAlloc WITH (NOLOCK)'
			    	+ @wherestr + ' AND InvProjAlloc.QtyRemainToIssue > 0.00 ORDER BY InvProjAlloc.InvtId, InvProjAlloc.SiteId'
	
	EXEC (@sql)



