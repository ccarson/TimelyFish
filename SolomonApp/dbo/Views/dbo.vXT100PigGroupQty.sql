--*************************************************************
--	Purpose:View for Qty/InvEffect for pig group projected movements			
--	Author: Charity Anderson
--	Date: 3/15/2004
--	Usage: Tranportation Module 
--	Parms: 
--	       
--*************************************************************

CREATE VIEW dbo.vXT100PigGroupQty
AS
Select SourcePigGroupID as PigGroupID,-1* EstimatedQty as Qty, MovementDate from cftPM WITH (NOLOCK) 
	where SourcePigGroupID>'' and Highlight<>255
UNION ALL
Select DestPigGroupID as PigGroupID, EstimatedQty as Qty, MovementDate from cftPM WITH (NOLOCK) 
	where DestPigGroupID>'' and Highlight<>255
