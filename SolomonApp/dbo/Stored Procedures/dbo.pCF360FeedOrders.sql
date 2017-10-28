
--*************************************************************
--	Purpose:Unions FeedOrder Issues
--	Author: Charity Anderson
--	Date: 12/28/2004
--	Usage:Feed Order Exceptions CF360	 
--	Parms: @Dupes,@Bins,@Stage
--*************************************************************

CREATE  PROC dbo.pCF360FeedOrders
	(@Dupes as smallint,@Bins as smallint,@Stage as smallint, @Group as smallint)
AS
DECLARE @strSQL as varchar(1000)
SET @strSQL='Select * from vCF360DuplicateOrders where OrdNbr=0'
IF @Dupes=1
BEGIN
set @strSQL=@StrSQL + ' UNION Select * from vCF360DuplicateOrders'
END
IF @Bins=1
BEGIN
set @strSQL=@StrSQL + ' UNION Select * from vCF360BinCapacity'
END
IF @Stage=1
BEGIN
set @strSQL=@StrSQL + ' UNION Select * from vCF360StageIssues'
END
IF @Group=1
BEGIN
set @strSQL=@StrSQL + ' UNION Select * from vCF360GroupIssues'
END
set @strSQL=@StrSQL + ' Order by IssueType, ContactName, BinNbr, DateSched'


exec (@strSQL)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF360FeedOrders] TO [MSDSL]
    AS [dbo];

