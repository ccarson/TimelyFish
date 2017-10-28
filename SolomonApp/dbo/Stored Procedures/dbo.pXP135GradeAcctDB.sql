--*************************************************************
--	Purpose:DBNav for PigGradeCatType Acct Cat		
--	Author: Charity Anderson
--	Date: 8/20/2004
--	Usage: PigTransportRecord 
--	Parms: @parm1 (PigGradeCatTypeID)
--	       @parm2 (Acct)
--*************************************************************

CREATE PROC dbo.pXP135GradeAcctDB
	@parm1 as varchar(2),
	@parm2 as varchar(16)
	AS
Select  * from cftPigGradeAcct
where PigGradeCatTypeID=@parm1
and Acct like @parm2
Order by PigGradeCatTypeID,acct

