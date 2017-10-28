--*************************************************************
--	Purpose:PV for Pig Purchase Loadnbr
--	Author: Charity Anderson
--	Date: 6/6/2005
--	Usage: Pig Purchase Agreement
--	Parms: @parm1 (PMID)
--	      
--*************************************************************

CREATE PROC dbo.pCF102PM
	@parm1 as varchar(10)
	
AS
Select pm.*
FROM vCF507PigMovement pm WITH (NOLOCK) 
JOIN cftPM t WITH (NOLOCK) on pm.PMID=t.PMID
where pm.PMID like @parm1 
and left(t.TranSubTypeID,1)='P'
order by pm.PMID
