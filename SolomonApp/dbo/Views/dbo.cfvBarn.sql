

/****** Object:  View dbo.cfvBarn    Script Date: 12/8/2004 8:28:45 PM ******/
CREATE  View [dbo].[cfvBarn] (BarnNbr, ContactID, Descr, DfltRation, MgrContactID, SpecRat, SpecRatBeg, SpecRatEnd, Tstamp) as
/* Used in programs:  CF300, CF303
   Referenced in:
*/
    Select b.BarnNbr, c.ContactID, Coalesce(b.BarnDescription, ''), Coalesce(b.DfltRation, ''), Coalesce(b.BarnMgrContactID, ''), 
	Coalesce(b.SpecialRation, '' ), Coalesce(b.SpecialRationBegin, ''), Coalesce(b.SpecialRationEnd, ''), Convert(timestamp, 0)
	from cftBarn b Join cftContact c on b.ContactId = c.ContactId


 
