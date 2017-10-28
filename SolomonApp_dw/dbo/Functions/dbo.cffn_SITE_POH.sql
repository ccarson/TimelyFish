


-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 12/15/2011
-- Description:	Return Sow Source Percent by Marketed Pig Group.
-- ===================================================================
CREATE FUNCTION [dbo].[cffn_SITE_POH] (@PigGroupID varchar(5)) 
RETURNS @tblSowSourcePercent TABLE
(
	--Columns returned by the function
	PigGroupID varchar(50),
	SourceProject varchar(50),
	POH float 
)
AS
--Returns the PigGroupID, Source Site ID, and Sow Source Percent for the specifiec PigGroup
BEGIN

BEGIN
  
  DECLARE @SourceTable table
(     PigGroupID char(10)
,     SourcePigGroupID char(10)
,     SourceProject char(16)
,     POH float
,	  TPOH float
,     LoopNumber float)


INSERT INTO @SourceTable (PigGroupID, SourcePigGroupID, SourceProject, POH, TPOH, LoopNumber)
--,pohag)
SELECT      @PigGroupID, 
            SourcePigGroupID, 
            SourceProject,
            cast(sum(cftPGInvTran.qty)as float)/SUM(SUM(cftPGInvTran.qty)) over (partition by cftPGInvTran.PigGroupID),
            cast(sum(cftPGInvTran.qty)as float)/SUM(SUM(cftPGInvTran.qty)) over (partition by cftPGInvTran.PigGroupID),
            1
            --cast(sum(cftPGInvTran.qty)as float)/SUM(SUM(cftPGInvTran.qty)) over (partition by cftPGInvTran.PigGroupID)
FROM  [$(SolomonApp)].dbo.cftPGInvTran cftPGInvTran (NOLOCK)
WHERE RTRIM(cftPGInvTran.PigGroupID) = RTRIM(@PigGroupID)
AND   cftPGInvTran.TranTypeID IN ('TI','MI','PP')
AND   cftPGInvTran.Reversal <> '1'
group by cftPGInvTran.PigGroupID,cftPGInvTran.SourcePigGroupID,cftPGInvTran.SourceProject
WHILE (1=1)
BEGIN

      INSERT INTO @SourceTable (PigGroupID, SourcePigGroupID, SourceProject, POH, TPOH, LoopNumber)
      --, pohag)
      SELECT DISTINCT cftPGInvTran.PigGroupID, 
                                cftPGInvTran.SourcePigGroupID, 
                                cftPGInvTran.SourceProject,
                                (cast(sum(cftPGInvTran.qty)as float)/SUM(SUM(cftPGInvTran.qty)) over (partition by cftPGInvTran.PigGroupID)) 
                                * 
                                (Select Count(*) from (Select SourcePigGroupID
								from @SourceTable where SourcePigGroupID = SourceTable.SourcePigGroupID
								and LoopNumber = (Select MAX(LoopNumber) from @SourceTable)) a),
                                TPOH = SourceTable.TPOH * (cast(sum(cftPGInvTran.qty)as float)/SUM(SUM(cftPGInvTran.qty)) over (partition by cftPGInvTran.PigGroupID))
                                *
                                (Select Count(*) from (Select SourcePigGroupID
								from @SourceTable where SourcePigGroupID = SourceTable.SourcePigGroupID
								and LoopNumber = (Select MAX(LoopNumber) from @SourceTable)) a),
                                (Select MAX(LoopNumber) from @SourceTable)+1
                                --(SourceTable.poh * (cast(sum(cftPGInvTran.qty)as float)/SUM(SUM(cftPGInvTran.qty)) over (partition by cftPGInvTran.PigGroupID)))
      FROM  [$(SolomonApp)].dbo.cftPGInvTran cftPGInvTran (NOLOCK)
      INNER JOIN (Select Distinct PigGroupID, SourcePigGroupID, TPOH, LoopNumber from @SourceTable) SourceTable
            ON SourceTable.SourcePigGroupID = cftPGInvTran.PigGroupID
      left join @SourceTable SourceTable2
			ON SourceTable.SourcePigGroupID = SourceTable2.PigGroupID
			and SourceTable.LoopNumber = (Select MAX(LoopNumber) from @SourceTable)
        WHERE cftPGInvTran.Reversal <> '1'
        AND   cftPGInvTran.TranTypeID IN ('TI','MI','PP')
        AND   SourceTable.LoopNumber = (Select MAX(LoopNumber) from @SourceTable)
        group by cftPGInvTran.PigGroupID,cftPGInvTran.SourcePigGroupID,cftPGInvTran.SourceProject,SourceTable.SourcePigGroupID,SourceTable.TPOH
	  IF (SELECT MAX(SourcePigGroupID) from @SourceTable Where LoopNumber = (Select MAX(LoopNumber) from @SourceTable)) = ''
	  OR (SELECT MAX(LoopNumber) from @SourceTable) = 5
    
      --IF (SELECT COUNT(*) RecCt FROM @SourceTable A WHERE RTRIM(A.SourcePigGroupID) <> '' AND NOT EXISTS (SELECT * FROM @SourceTable B WHERE B.PigGroupID = A.SourcePigGroupID)) = 0
            BREAK
      ELSE
            CONTINUE

END

INSERT INTO @tblSowSourcePercent (PigGroupID, SourceProject, POH)

	Select
	@PigGroupID, 
	SourceProject,
	SUM(TPOH)/(Select SUM(TPOH) from @SourceTable where SourceProject <> '' and SourcePigGroupID = '') 
	from @SourceTable 
	Where SourceProject <> ''
	and SourcePigGroupID = ''
	Group by
	SourceProject

	END;
	RETURN;
END

