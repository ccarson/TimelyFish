CREATE view [dbo].[vSowSvcMgrWithName]
AS
SELECT     ssm.ContactID, c.ContactName
	FROM dbo.SowSvcMgr ssm 
	INNER JOIN [$(CentralData)].dbo.Contact c ON ssm.ContactID = c.ContactID	-- removed the earth reference 20130905 smr (saturn retirement)
	
	UNION SELECT 0, 'Unknown'

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowSvcMgrWithName] TO [se\analysts]
    AS [dbo];

