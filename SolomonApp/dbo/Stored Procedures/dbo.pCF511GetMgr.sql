
/****** Object:  Stored Procedure dbo.pCF511GetMgr    Script Date: 9/16/2004 9:52:52 AM ******/

/****** Object:  Stored Procedure dbo.pCF511GetMgr    Script Date: 9/7/2004 12:09:09 PM ******/

/****** Object:  Stored Procedure dbo.pCF511GetMgr    Script Date: 9/7/2004 11:11:52 AM ******/

CREATE    Procedure pCF511GetMgr
	@parm1 varchar(6),
	@parm2 smalldatetime
AS

Select c.ContactID, c.ContactName, st.SiteID, ss.EffectiveDate
From cftSiteSvcMgrAsn ss
JOIN cftContact c ON ss.SvcMgrContactID=c.ContactID
JOIN cftSite st on ss.SiteContactID=st.ContactID
Where ss.SiteContactID=@parm1
AND ss.EffectiveDate<=@parm2
Order by ss.EffectiveDate Desc


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF511GetMgr] TO [MSDSL]
    AS [dbo];

