--*************************************************************
--	Purpose:Distinct List of PigGroups with effected Inventory
--	Author: Charity Anderson
--	Date: 10/28/2004
--	Usage: Pig Sales Entry		 
--	Parms: BatNbr
--*************************************************************

CREATE PROC dbo.pCF518PSInvGroups
	(@parm1 as varchar(10))
AS
Select Distinct PigGroupID
	from cftPigSale
	where BatNbr like @parm1 and PigGroupID is not null

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF518PSInvGroups] TO [MSDSL]
    AS [dbo];

