
CREATE VIEW dbo.cfv_PIG_MASTER_GROUP_ELIGIBLE
AS

SELECT COUNT(PGStatusID) PGStatusIDCnt
	, MAX(PGStatusID) MaxPGStatusID
	, CF03 MasterGroup
	, max(PigProdPhaseID) PigProdPhaseID
	, COUNT(CostFlag) as PGCostFlagCt
	, MAX(CostFlag) as MaxPGCostFlag
FROM
      (SELECT DISTINCT PGStatusID, CF03, CostFlag, PigProdPhaseID
      FROM [$(SolomonApp)].dbo.cftPigGroup pg WITH (nolock)
      WHERE PGStatusID<>'X'
      ) pg1
GROUP BY
CF03

HAVING (COUNT(PGStatusID)=1
AND MAX(PGStatusID) = 'I'
AND COUNT(CostFlag) = 1
AND MAX(CostFlag) = 2)
OR
(COUNT(PGStatusID)=1
AND MAX(PGStatusID) = 'I'
AND max(PigProdPhaseID)='TEF')




