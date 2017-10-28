--*************************************************************
--	Purpose:PV for Barn table			
--	Author: Charity Anderson
--	Date: 8/20/2004
--	Usage: PigTransportRecord 
--	Parms: @parm1 (SolomonContactID)
--	       @parm2 (BarnNbr)
--*************************************************************

CREATE PROC dbo.pXP135BarnPV
	@parm1 as varchar(6),
	@parm2 as varchar(10)
	AS
Select  b.*, c.ContactName from cftBarn b JOIN cftContact c
 on b.ContactID=c.ContactID 
where b.ContactID = @parm1 and b.BarnNbr like @parm2
and b.StatusTypeID='1'
order by b.BarnNbr, c.ContactName

