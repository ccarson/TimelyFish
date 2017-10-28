--*************************************************************
--	Purpose:Pig Sales Order PV
--	Author: Charity Anderson
--	Date: 10/10/2004
--	Usage: Pig Sales Order			 
--	Parms: OrdNbr
--*************************************************************

CREATE PROC dbo.pCF519SalesOrderPV
	(@parm1 as varchar(10))
AS
Select * from cftPSOrdHdr where OrdNbr like @parm1 order by OrdNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF519SalesOrderPV] TO [MSDSL]
    AS [dbo];

