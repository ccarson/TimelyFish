--*************************************************************
--	Purpose:Packer PV for Open Sales Order
--	Author: Charity Anderson
--	Date: 10/10/2004
--	Usage: Pig Sales Order			 
--	Parms: PkrContactID
--*************************************************************

CREATE PROC dbo.pCF519OpenPacker
	(@parm1 as varchar(10))
AS
Select * from cftPacker JOIN cftContact on cftPacker.ContactID=cftContact.ContactID where cftPacker.ContactID like @parm1 order by cftPacker.ContactID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF519OpenPacker] TO [MSDSL]
    AS [dbo];

