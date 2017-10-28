--*************************************************************
--	Purpose:Lookup PigSale with OrigRef
--	Author: Charity Anderson
--	Date: 10/22/2004
--	Usage: Pig Sales Entry		 
--	Parms: RefNbr
--*************************************************************

CREATE view dbo.vCF518_OrigRefPV

AS
Select ps.*,convert(char(20),s.ContactName) as Source,convert(char(20),p.ContactName) as Packer from cftPigSale ps JOIN cftContact s on ps.SiteContactID=s.ContactID
	JOIN cftContact p on ps.PkrContactID=p.ContactID
	where RefNbr not in 
	(Select Distinct OrigRefNbr from cftPigSale)
	and DocType<>'RE'  

