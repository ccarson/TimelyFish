
/****** Object:  Stored Procedure dbo.pCF511GetMktMgr    Script Date: 9/16/2004 12:28:32 PM ******/

/****** Object:  Stored Procedure dbo.pCF511GetMktMgr    Script Date: 9/7/2004 11:11:52 AM ******/

CREATE   Procedure pCF511GetMktMgr
	@parm1 varchar(6),
	@parm2 smalldatetime
AS

Select c.ContactID, c.ContactName, st.SiteID, mk.EffectiveDate
From cftContact c
JOIN cftMktMgrAssign mk ON c.ContactID=mk.MktMgrContactID
JOIN cftSite st on mk.SiteContactID=st.ContactID
Where mk.SiteContactID=@parm1
AND mk.EffectiveDate<=@parm2
Order by mk.EffectiveDate Desc





