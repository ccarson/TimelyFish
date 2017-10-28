



--*************************************************************
--	Purpose:Site Packer Certification Record
--	Author: Sue Matter
--	Date: 2/2/2006
--	Usage: Site Packer Certification			 
--	Parms: SiteContactID, PackerContactID
--*************************************************************

CREATE  PROC pXF205SitePacker
	(@parm1 as varchar(6), @parm2 as varchar(6))
AS
Select * from cftSitePkrCert 
where SiteContactID=@parm1 AND PackerContactID=@parm2
order by PackerContactID


