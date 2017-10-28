--*************************************************************
--	Purpose:Site Packer Certification Record
--	Author: Sue Matter
--	Date: 2/2/2006
--	Usage: Site Packer Certification			 
--	Parms: SiteContactID
--*************************************************************
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2012-03-14  Doran Dahle Added Execute As to handle SL Integrated Security method
===============================================================================
*/
CREATE  PROC [dbo].[pXF205SiteSWAP]
	@parm1 as varchar(6)
	WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS
Select c.* 
from cftContact c
JOIN CentralData.dbo.Permit p ON c.ContactID=p.SiteContactID
where SiteContactID=@parm1 AND PermitTypeID='16' AND ExpirationDate > GetDate()



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF205SiteSWAP] TO [MSDSL]
    AS [dbo];

