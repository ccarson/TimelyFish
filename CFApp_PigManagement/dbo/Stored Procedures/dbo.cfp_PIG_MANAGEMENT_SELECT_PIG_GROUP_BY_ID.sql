
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 03/11/2009
-- Description:   Selects Pig group by id 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_PIG_MANAGEMENT_SELECT_PIG_GROUP_BY_ID
(
    @PigGroupID   int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT PigGroupID,
       Description,
       EstStartDate,
       EstCloseDate,
       BarnNbr,
       PigProdPhaseID,
       PigProdPodID,
       '1' AS RoomNbr
FROM [$(SolomonApp)].dbo.cftPigGroup
WHERE PigGroupID = @PigGroupID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_MANAGEMENT_SELECT_PIG_GROUP_BY_ID] TO [db_sp_exec]
    AS [dbo];

