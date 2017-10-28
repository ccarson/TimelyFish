--*************************************************************
--	Purpose:Load Nbr PV for Pig Sales Entry
--	Author: Charity Anderson
--	Date: 10/14/2004
--	Usage: Pig Sales Entry		 
--	Parms: PMID
--*************************************************************

CREATE PROC dbo.pCF518LoadNbrPV
		(@parm1 varchar(6))
AS
Select * from vCF518LoadNbrPV
where PMID like @parm1  
Order By PMID
