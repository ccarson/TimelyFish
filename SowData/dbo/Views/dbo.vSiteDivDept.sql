CREATE view [dbo].[vSiteDivDept] 
	As
	SELECT * FROM [$(CentralData)].dbo.SiteDivDept	-- remove the earth reference 20130905 smr (saturn retirement)

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSiteDivDept] TO [se\analysts]
    AS [dbo];

