
/****** Object:  Stored Procedure dbo.pXP135TranDetailRev    Script Date: 2/27/2006 2:01:02 PM ******/


--*************************************************************
--	Purpose: Batch Release Lookup Reversals
--	Author: Sue Matter
--	Date: 12/22/2005
--	Usage: PigTransportRecord app 
--	Parms:BatchNbr, RefNbr, Line, Account
--*************************************************************
CREATE     PROCEDURE pXP135TranDetailRev
	@parm1 as varchar(10),
	@parm2 as varchar(10)

AS
Select t.* 
From cftPMTranspRecord t 
JOIN cftPMTranspRecord r on r.OrigRefNbr=t.RefNbr
Where r.BatchNbr=@parm1 AND r.RefNbr=@parm2
AND r.DocType='RE'

