--*************************************************************
--	Purpose:Packer PV for Site Packer Certification
--	Author: Sue Matter
--	Date: 2/2/2006
--	Usage: Site Packer Override			 
--	Parms: PkrContactID
--*************************************************************

CREATE  PROC pXF207Packer
	(@parm1 as varchar(6))
AS
Select * from cftPacker 
JOIN cftContact on cftPacker.ContactID=cftContact.ContactID 
where cftPacker.ContactID like @parm1 order by cftPacker.ContactID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF207Packer] TO [MSDSL]
    AS [dbo];

