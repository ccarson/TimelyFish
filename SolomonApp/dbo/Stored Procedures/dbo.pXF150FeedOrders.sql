
--*************************************************************
--	Purpose:Unions FeedOrder Issues
--	Author: Charity Anderson
--	Date: 12/28/2004
--	Usage:Feed Order Exceptions XF150	 
--	Parms: @Dupes,@Bins,@Hold,@Group
--*************************************************************

/********************* REVISIONS **********************
Date       User        Ref     Description
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
12/14/06   mdawson     Bug94   Added 'Hold for Bin Verification' for Exception Report
 
****************** END REVISIONS *********************/

CREATE PROC dbo.pXF150FeedOrders
	(@Dupes as smallint,@Bins as smallint,@Hold as smallint, @Group as smallint)
AS
DECLARE @strSQL as varchar(1000)
SET @strSQL='Select * from dbo.vXF150DuplicateOrders where OrdNbr=0'
IF @Dupes=1
BEGIN
set @strSQL=@StrSQL + ' UNION Select * from dbo.vXF150DuplicateOrders'
END
IF @Bins=1
BEGIN
set @strSQL=@StrSQL + ' UNION Select * from dbo.vXF150BinCapacity'
END
IF @Hold=1
BEGIN
set @strSQL=@StrSQL + ' UNION Select * from dbo.vXF150HoldVerification'
END
IF @Group=1
BEGIN
set @strSQL=@StrSQL + ' UNION Select * from dbo.vXF150GroupIssues'
END
set @strSQL=@StrSQL + ' Order by IssueType, ContactName, BinNbr, DateSched'

exec (@strSQL)
