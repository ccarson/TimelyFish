--*************************************************************
--	Purpose:Lookup PigSale with OrigRef
--	Author: Charity Anderson
--	Date: 10/22/2004
--	Usage: Pig Sales Entry		 
--	Parms: RefNbr
--*************************************************************

CREATE proc dbo.pCF518_OrigRefPV
	(@parm1 as varchar(10))
AS
Select * from vCF518_OrigRefPV where RefNbr like @parm1 

order by RefNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF518_OrigRefPV] TO [MSDSL]
    AS [dbo];

