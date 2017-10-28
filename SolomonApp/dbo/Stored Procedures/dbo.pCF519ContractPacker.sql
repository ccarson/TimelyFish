--*************************************************************
--	Purpose:Packer PV for Contract Sales Order
--	Author: Charity Anderson
--	Date: 10/10/2004
--	Usage: Pig Sales Order			 
--	Parms: ContrNbr,PkrContactID
--*************************************************************

CREATE PROC dbo.pCF519ContractPacker
	(@parm1 as varchar(10),
	 @parm2 as varchar(6))
AS
Select * from cftPSContrPkr JOIN cftContact on cftPSContrPkr.PkrContactID=cftContact.ContactID where cftPSContrPkr.ContrNbr=@parm1 and cftPSContrPkr.PkrContactID like @parm2 order by PkrContactID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF519ContractPacker] TO [MSDSL]
    AS [dbo];

