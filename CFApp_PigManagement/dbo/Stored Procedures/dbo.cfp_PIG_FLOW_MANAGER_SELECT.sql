

-- =====================================================================
-- Author:		Nick Honetschlager
-- Create date: 06/05/2017
-- Description:	Selects active flow managers to assign to a Pig Flow
-- =====================================================================
CREATE PROCEDURE [dbo].[cfp_PIG_FLOW_MANAGER_SELECT]
AS

SELECT 0 AS SvcContactID, ' ' AS SvcMgrName

UNION
	
SELECT DISTINCT ISNULL(c.ContactID, 0) AS SvcContactID, ISNULL(ContactName, ' ') AS SvcMgrName
FROM [$(CentralData)].dbo.Contact c
JOIN [$(CentralData)].dbo.ContactRoleType crt ON c.ContactID = crt.ContactID
JOIN [$(CentralData)].dbo.RoleType rt (NOLOCK) ON crt.RoleTypeID = rt.RoleTypeID
WHERE StatusTypeID = 1
AND rt.RoleTypeDescription LIKE '%Flow Manager%'

ORDER BY SvcMgrName


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_MANAGER_SELECT] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_MANAGER_SELECT] TO [db_sp_exec]
    AS [dbo];

