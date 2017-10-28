--*************************************************************
--	Purpose:PigSales Types
--	Author: Charity Anderson
--	Date: 10/28/2004
--	Usage: Pig Sales Entry		 
--	Parms: SalesTypeID
--*************************************************************

CREATE PROC dbo.CF_cftPSType_Type
	(@parm1 as varchar(2))
AS

Select * from cftPSType where SalesTypeID like @parm1 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF_cftPSType_Type] TO [MSDSL]
    AS [dbo];

