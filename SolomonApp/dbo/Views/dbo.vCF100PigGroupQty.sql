--*************************************************************
--	Purpose:View for Qty/InvEffect for pig group projected movements			
--	Author: Charity Anderson
--	Date: 3/15/2004
--	Usage: Tranportation Module 
--	Parms: 
--	       
--*************************************************************

CREATE VIEW dbo.vCF100PigGroupQty
AS
Select SourcePigGroupID as PigGroupID,-1* EstimatedQty as Qty from cftPM
	where SourcePigGroupID>''
UNION
Select DestPigGroupID as PigGroupID, EstimatedQty as Qty from cftPM
	where DestPigGroupID>''
