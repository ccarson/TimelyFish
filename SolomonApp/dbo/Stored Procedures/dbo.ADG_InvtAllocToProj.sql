CREATE PROCEDURE ADG_InvtAllocToProj
 @CpnyID varchar(10),
 @InvtID varchar(30),  
 @SiteID varchar(10),  
 @ProjectID varchar(16),  
 @TaskID varchar(32),  
 @StartDate smalldatetime,  
 @EndDate smalldatetime,  
 @NoQtyRemaining varchar(1)
AS  
 DECLARE @sql  VARCHAR(8000),  
  @wherestr VARCHAR(3000)  
  
 SELECT @wherestr = ' h.CpnyID = ' + QUOTENAME(@CpnyID, '''')  
  
 IF PATINDEX('%[%,_]%', @InvtID) = 0 -- @InvtID <> '%'  
  SELECT @wherestr = @wherestr + ' AND h.InvtID = ' + QUOTENAME(@InvtID, '''')  
 ELSE IF @InvtID <> '%'  
  SELECT @wherestr = @wherestr + ' AND h.InvtID LIKE ' + QUOTENAME(@InvtID, '''')  
  IF PATINDEX('%[%,_]%', @SiteID) = 0 -- @SiteID <> '%'  
  SELECT @wherestr = @wherestr + ' AND h.SiteID = ' + QUOTENAME(@SiteID, '''')  
 ELSE iF @SiteID <> '%'  
  SELECT @wherestr = @wherestr + ' AND h.SiteID LIKE ' + QUOTENAME(@SiteID, '''')  
 IF PATINDEX('%[%,_]%', @ProjectID) = 0 -- @ProjectID <> '%'  
  SELECT @wherestr = @wherestr + ' AND h.ProjectID = ' + QUOTENAME(@ProjectID, '''')  
 ELSE IF @ProjectID <> '%'  
  SELECT @wherestr = @wherestr + ' AND h.ProjectID LIKE ' + QUOTENAME(@ProjectID, '''')  
  IF PATINDEX('%[%,_]%', @TaskID) = 0 -- @TaskID <> '%'  
  SELECT @wherestr = @wherestr + ' AND h.TaskID = ' + QUOTENAME(@TaskID, '''')  
 ELSE IF @TaskID <> '%'  
  SELECT @wherestr = @wherestr + ' AND h.TaskID LIKE ' + QUOTENAME(@TaskID, '''')  
 IF @StartDate <> '01/01/1900'  
  SELECT @wherestr = @wherestr + ' AND h.SrcDate >= ' + QUOTENAME(@StartDate,'''')  
 IF @EndDate <> '01/01/1900'  
  SELECT @wherestr = @wherestr + ' AND h.SrcDate <= ' + QUOTENAME(@EndDate,'''' )  
  
 IF @NoQtyRemaining = '0'  
 BEGIN
  SELECT @sql = '
   SELECT h.*, v.QtyRemainToIssue
   FROM INPrjAllocHistory h WITH (NOLOCK)  
   INNER JOIN InvProjAlloc v WITH (NOLOCK)  
   ON v.srclineref = h.srclineref
   AND v.srcnbr = h.srcnbr
   And v.srctype = h.srctype
   WHERE ' + @wherestr + ' ORDER BY h.InvtID, h.SiteID, h.Whseloc, h.ProjectID, h.TaskID'  
 END  
 ELSE  
 BEGIN  
  SELECT @sql = '  
   SELECT h.*, CASE WHEN v.QtyRemainToIssue is null Then 0 Else v.QtyRemainToIssue End As QtyRemainToIssue
   FROM INPrjAllocHistory h WITH (NOLOCK)  
   LEFT OUTER JOIN InvProjAlloc v WITH (NOLOCK)  
   ON v.srclineref = h.srclineref
   AND v.srcnbr = h.srcnbr
   And v.srctype = h.srctype
   WHERE ' + @wherestr + '  ORDER BY h.InvtID, h.SiteID, h.Whseloc, h.ProjectID, h.TaskID'  
 END  
  
 EXEC (@sql)  

GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_InvtAllocToProj] TO [MSDSL]
    AS [dbo];

