--*************************************************************
--	Purpose:Retrieve Base Price for a Sales Entry
--	Author: Charity Anderson
--	Date: 10/15/2004
--	Usage: Pig Sales Entry		 
--	Parms: ContrNbr,KillDate
--*************************************************************

CREATE PROC dbo.pCF518GetBasePrice
	(@parm1 as varchar(10), @parm2 as smalldatetime)
AS
Select * from cftPSContrBPHist where ContrNbr=@parm1 and BPDate=@parm2
