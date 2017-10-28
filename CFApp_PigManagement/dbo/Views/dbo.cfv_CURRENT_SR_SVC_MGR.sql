
CREATE VIEW [dbo].[cfv_CURRENT_SR_SVC_MGR]
AS
	SELECT 
		s.SiteID
		, s.ContactID
		, c.ContactName
		, SSM.SrSvcContactID
		, SSM.SrSvcName
		, SSM.EffectiveDate SrSvcMgrEffectiveDate
		, SM.SvcContactID
		, SM.SvcMgrName
		, SM.EffectiveDate SvcMrgEffectiveDate
	FROM [$(CentralData)].dbo.Site s
	LEFT JOIN [$(CentralData)].dbo.Contact c 
		ON s.ContactID = c.ContactID
	LEFT JOIN
		(SELECT sm1.SiteContactID
			, c2.ContactName SiteName
			, sm2.ProdSvcMgrContactID
			, sm2.EffectiveDate
			, c.ContactID SrSvcContactID
			, c.ContactName SrSvcName
		FROM
			(SELECT SiteContactID
				, Max(EffectiveDate) EffectiveDate
			FROM [$(CentralData)].dbo.ProdSvcMgrAssignment
			GROUP BY
			SiteContactID) sm1
		LEFT JOIN [$(CentralData)].dbo.ProdSvcMgrAssignment sm2 
			ON sm2.SiteContactID=sm1.SiteContactID AND sm2.EffectiveDate=sm1.EffectiveDate
		LEFT JOIN [$(CentralData)].dbo.Contact c 
			ON c.ContactID=sm2.ProdSvcMgrContactID
		LEFT JOIN [$(CentralData)].dbo.Contact c2 
			ON c2.ContactID=sm1.SiteContactID) SSM
		ON SSM.SiteContactID=s.ContactID

	LEFT JOIN
		(SELECT sm1.SiteContactID
			, c2.ContactName SiteName
			, sm2.SvcMgrContactID
			, sm2.EffectiveDate
			, c.ContactID SvcContactID
			, c.ContactName SvcMgrName
		FROM
			(SELECT SiteContactID
				, Max(EffectiveDate) EffectiveDate
			FROM [$(CentralData)].dbo.SiteSvcMgrAssignment
			GROUP BY
			SiteContactID) sm1
		LEFT JOIN [$(CentralData)].dbo.SiteSvcMgrAssignment sm2 
			ON sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
		LEFT JOIN [$(CentralData)].dbo.Contact c 
			ON c.ContactID=sm2.SvcMgrContactID
		LEFT JOIN [$(CentralData)].dbo.Contact c2 
			ON c2.ContactID=sm1.SiteContactID) SM
	ON SM.SiteContactID=s.ContactID

	WHERE c.StatusTypeID='1'
	AND Siteid not in ('9999','1660','8000','8010','0001','9998','9997')

