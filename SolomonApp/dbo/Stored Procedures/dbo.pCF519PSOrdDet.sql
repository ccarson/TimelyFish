--*************************************************************
--	Purpose:Retrieve Sales Order Date Detail
--	Author: Charity Anderson
--	Date: 10/10/2004
--	Usage: Pig Sales Order			 
--	Parms: ordnbr,saledate (min, max)
--*************************************************************

CREATE PROC dbo.pCF519PSOrdDet
	(@parm1 as varchar(10),
	 @parm2 as smalldatetime,
	 @parm3 as smalldatetime)
AS
Select * from cftPSOrdDet where OrdNbr=@parm1 and SaleDate Between @parm2 and @parm3 order by SaleDate 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF519PSOrdDet] TO [MSDSL]
    AS [dbo];

