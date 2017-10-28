--*************************************************************
--	Purpose:Packer PV for Open Sales Order
--	Author: Charity Anderson
--	Date: 10/13/2004
--	Usage: Pig Sales Entry		 
--	Parms: OrdNbr
--*************************************************************

CREATE PROC dbo.pCF518OrderNbr
	(@parm1 as varchar(10))
AS
Select * from cftPSOrdHdr join cftContact on cftPSOrdHdr.PkrContactID=cftContact.ContactID
where OrdNbr like @parm1 order by OrdNbr
