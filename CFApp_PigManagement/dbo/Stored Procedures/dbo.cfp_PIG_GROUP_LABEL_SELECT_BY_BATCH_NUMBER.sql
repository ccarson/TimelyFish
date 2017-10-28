-- ======================================================================
-- Author:		Brian Cesafsky
-- Create date: 05/27/2009
-- Description:	Returns Pig Group Data to print labels
-- ======================================================================
CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_LABEL_SELECT_BY_BATCH_NUMBER]
(
	@BatchNumber		varchar(10)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT PJPENT.pjt_entity_desc
		 , PJPENT.pjt_entity
		 , cftPigGroup.EstStartDate
	     , cftPGStatusUpd.PigGroupID
	     , cftPigGroup.CpnyID 
		 , cftPigGroup.PGStatusID 
		 , cftPigGroup.PigProdPhaseID
	FROM   {oj ([$(SolomonApp)].dbo.cftPGStatusUpd cftPGStatusUpd 
		LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigGroup cftPigGroup 
			ON cftPGStatusUpd.PigGroupID=cftPigGroup.PigGroupID) 
		LEFT OUTER JOIN [$(SolomonApp)].dbo.PJPENT PJPENT 
			ON cftPigGroup.TaskID=PJPENT.pjt_entity}
	WHERE  (cftPigGroup.PGStatusID='A' OR cftPGStatusUpd.PigGroupID='')
		AND  cftPGStatusUpd.BatNbr = @BatchNumber
	ORDER BY cftPGStatusUpd.PigGroupID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_LABEL_SELECT_BY_BATCH_NUMBER] TO [db_sp_exec]
    AS [dbo];

