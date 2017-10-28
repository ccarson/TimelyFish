--*************************************************************
--	Purpose:PV for Pig Transaction Types
--		
--	Author: Charity Anderson
--	Date: 2/24/2005
--	Usage: 
--	Parms: TranTypeID
--*************************************************************

CREATE PROC dbo.pXP235PigTranTypePV
	(@parm1 as varchar(2))
AS
Select * from cftPigTranType where TranTypeID like @parm1 order by TranTypeID
