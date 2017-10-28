

-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 03/23/2009
-- Description:	Selects Pig group  by PM LOAD ID
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_BY_PM_LOAD_ID_SELECT]
(
    @PMLoadID	char(10)
)
AS
BEGIN
SET NOCOUNT ON;

SELECT PG.PigGroupID
       ,PG.Description
       ,PG.EstStartDate
       ,PG.EstCloseDate
       ,PG.BarnNbr
       ,PG.PigProdPhaseID
	   ,case when rtrim(PG.PigProdPodID) = '' 
			then 0 
		else isnull(PG.pigprodpodid,0) 
		end as PigProdPodID
FROM [$(SolomonApp)].dbo.cftPigGroup PG
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPM PM ON PG.PigGroupID = PM.SourcePigGroupID
WHERE PMLoadID = @PMLoadID

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_BY_PM_LOAD_ID_SELECT] TO [db_sp_exec]
    AS [dbo];

