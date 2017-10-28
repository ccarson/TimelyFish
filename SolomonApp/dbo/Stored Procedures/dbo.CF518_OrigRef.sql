--*************************************************************
--	Purpose:Lookup PigSale with OrigRef
--	Author: Charity Anderson
--	Date: 10/22/2004
--	Usage: Pig Sales Entry		 
--	Parms: RefNbr
--*************************************************************

CREATE PROC dbo.CF518_OrigRef
	(@parm1 as varchar(10))
AS
Select * from cftPigSale where RefNbr like @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF518_OrigRef] TO [MSDSL]
    AS [dbo];

