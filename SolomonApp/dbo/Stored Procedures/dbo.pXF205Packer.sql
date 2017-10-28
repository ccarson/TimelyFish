--*************************************************************
--	Purpose:Packer PV for Site Packer Certification
--	Author: Sue Matter
--	Date: 2/2/2006
--	Usage: Site Packer Certification			 
--	Parms: PkrContactID
--*************************************************************

CREATE  PROC pXF205Packer
	(@parm1 as varchar(6))
AS
Select * from cftPacker 
JOIN cftContact on cftPacker.ContactID=cftContact.ContactID 
where cftPacker.ContactID like @parm1 order by cftPacker.ContactID


