
--*************************************************************
--	Purpose:Lookup PigSale with OrigRef
--	Author: Charity Anderson
--	Date: 10/22/2004
--	Usage: Pig Sales Entry		 
--	Parms: RefNbr
--*************************************************************

CREATE PROC dbo.CF518_OrigRefPV
	(@parm1 as varchar(10))
AS
Select * from cftPigSale JOIN cftContact as cftContacts on cftPigSale.SiteContactID=cftContacts.ContactID
	JOIN cftContact as cftContactP on cftPigSale.PkrContactID=cftContactP.ContactID where RefNbr like @parm1
	order by RefNbr

