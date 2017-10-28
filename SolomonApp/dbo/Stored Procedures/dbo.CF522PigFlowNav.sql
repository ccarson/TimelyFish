--*************************************************************
--	Purpose:DBNav for Pig Flow Type
--	Author: Charity Anderson
--	Date: 10/21/2004
--	Usage: Pig Flow Type Maintenance 
--	Parms: PigFlowID
--*************************************************************

CREATE PROC dbo.CF522PigFlowNav
	(@parm1 as varchar(3))
	
AS
Select * from cftPigFlow where PigFlowID like @parm1
