

-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 9/26/2012
-- Description:	Return Head and Source by Marketed Pig Group.
-- ===================================================================
CREATE FUNCTION [dbo].[cffn_MED_POH] (@PigGroupID varchar(5)) 
RETURNS @tblSowSourcePercent TABLE
(
	--Columns returned by the function
	PigGroupID char(10)
,     SourcePigGroupID char(10)
,     SourceProject char(16)
,	  Phase char(10)
,	  StartDate smalldatetime
,	  EndDate smalldatetime
,	  TransferHead float
,	  TotalHead float
,	  SourcePercent float
,     LoopNumber float 
)
AS
--Returns the PigGroupID, Source Site ID, and Sow Source Percent for the specifiec PigGroup
BEGIN

BEGIN
  
 DECLARE @SourceTable table
(     PigGroupID char(10)
,     SourcePigGroupID char(10)
,     SourceProject char(16)
,	  Phase char(10)
,	  StartDate smalldatetime
,	  EndDate smalldatetime
,	  TransferHead float
,	  TotalHead float
,	  SourcePercent float
,     LoopNumber float)

INSERT INTO @SourceTable (PigGroupID, SourcePigGroupID, SourceProject, Phase, StartDate, EndDate, TransferHead, TotalHead, SourcePercent, LoopNumber)
SELECT		@PigGroupID as 'PigGroupID', 
            cftPGInvTran.SourcePigGroupID as 'SourcePigGroupID1', 
            Case when cftPGInvTran.SourcePigGroupID = '' then cftPGInvTran.SourceProject else cftPigGroup.ProjectID end as 'SourceProject',
            Case when cftPGInvTran.SourcePigGroupID = '' then 'SOW' else cftPigGroup.PigProdPhaseID end as 'Phase',
            Case when cftPGInvTran.SourcePigGroupID = '' then
            Cast(DateAdd(day, -21, cftPGInvTran.TranDate) as smalldatetime) else cftPigGroup.ActStartDate end as 'StartDate',
            cftPGInvTran.TranDate as 'EndDate',
            Sum(cftPGInvTran.Qty) as 'TransferHead',
            Case when cftPGInvTran.SourcePigGroupID = '' then Sum(SowFarmTotalHead.Qty)
			else PigGroupTotalHead.Qty end as 'TotalHead',
			Case when isnull(Case when cftPGInvTran.SourcePigGroupID = '' then Sum(SowFarmTotalHead.Qty)
			else PigGroupTotalHead.Qty end,0) <> 0
			then (cast(isnull(Sum(cftPGInvTran.Qty),0) as numeric(14,2)) / cast(Case when cftPGInvTran.SourcePigGroupID = '' then Sum(SowFarmTotalHead.Qty)
			else PigGroupTotalHead.Qty end as numeric(14,2))) else 0 end as 'SourcePercent',
            1 as 'LoopNumber'
FROM  [$(SolomonApp)].dbo.cftPGInvTran cftPGInvTran (NOLOCK)

left join (Select Distinct PigGroupID, ProjectID, PigProdPhaseID, ActCloseDate, ActStartDate from [$(SolomonApp)].dbo.cftPigGroup) cftPigGroup
on rtrim(cftPGInvTran.SourcePigGroupID) = rtrim(cftPigGroup.PigGroupID)

left join (Select SourceProject, TranDate, Sum(Qty) as 'Qty' from [$(SolomonApp)].dbo.cftPGInvTran Where TranTypeID = 'TI' and Reversal <> '1' Group by SourceProject, TranDate) SowFarmTotalHead
on rtrim(cftPGInvTran.SourceProject) = rtrim(SowFarmTotalHead.SourceProject)
and SowFarmTotalHead.TranDate between Cast(DateAdd(day, -21, Cast(cftPGInvTran.TranDate as datetime)) as datetime) and cftPGInvTran.TranDate

left join (Select SourcePigGroupID, Sum(Qty) as 'Qty' from [$(SolomonApp)].dbo.cftPGInvTran Where TranTypeID in ('TI','MI') and Reversal <> '1' Group by SourcePigGroupID) PigGroupTotalHead
on rtrim(cftPGInvTran.SourcePigGroupID) = rtrim(PigGroupTotalHead.SourcePigGroupID)

WHERE RTRIM(cftPGInvTran.PigGroupID) = @PigGroupID
AND   cftPGInvTran.TranTypeID IN ('TI','MI','PP')
AND   cftPGInvTran.Reversal <> '1'
group by cftPGInvTran.SourcePigGroupID, 
Case when cftPGInvTran.SourcePigGroupID = '' then cftPGInvTran.SourceProject else cftPigGroup.ProjectID end,
Case when cftPGInvTran.SourcePigGroupID = '' then 'SOW' else cftPigGroup.PigProdPhaseID end,
Case when cftPGInvTran.SourcePigGroupID = '' then
Cast(DateAdd(day, -21, cftPGInvTran.TranDate) as smalldatetime) else cftPigGroup.ActStartDate end,
cftPGInvTran.TranDate,
PigGroupTotalHead.Qty 

WHILE (1=1)
BEGIN

INSERT INTO @SourceTable (PigGroupID, SourcePigGroupID, SourceProject, Phase, StartDate, EndDate, TransferHead, TotalHead, SourcePercent, LoopNumber)

SELECT		@PigGroupID as 'PigGroupID', 
            cftPGInvTran.SourcePigGroupID as 'SourcePigGroupID', 
            Case when cftPGInvTran.SourcePigGroupID = '' then cftPGInvTran.SourceProject else cftPigGroup.ProjectID end as 'SourceProject',
            Case when cftPGInvTran.SourcePigGroupID = '' then 'SOW' else cftPigGroup.PigProdPhaseID end as 'Phase',
            Case when cftPGInvTran.SourcePigGroupID = '' then
            Cast(DateAdd(day, -21, cftPGInvTran.TranDate) as smalldatetime) else cftPigGroup.ActStartDate end as 'StartDate',
            cftPGInvTran.TranDate as 'EndDate',
            cftPGInvTran.Qty as 'TransferHead',
            Case when cftPGInvTran.SourcePigGroupID = '' then Sum(SowFarmTotalHead.Qty)
			else PigGroupTotalHead.Qty end as 'TotalHead',
			Case when isnull(Case when cftPGInvTran.SourcePigGroupID = '' then Sum(SowFarmTotalHead.Qty)
			else PigGroupTotalHead.Qty end,0) <> 0
			then (cast(isnull(cftPGInvTran.Qty,0) as numeric(14,2)) / cast(Case when cftPGInvTran.SourcePigGroupID = '' then Sum(SowFarmTotalHead.Qty)
			else PigGroupTotalHead.Qty end as numeric(14,2))) else 0 end * SourceTable.SourcePercent as 'SourcePercent',
            (Select MAX(LoopNumber) from @SourceTable)+1 as 'LoopNumber'
FROM  (Select Distinct SourcePigGroupID, SourcePercent, LoopNumber from @SourceTable) SourceTable 

left join [$(SolomonApp)].dbo.cftPGInvTran cftPGInvTran (NOLOCK)
on rtrim(SourceTable.SourcePigGroupID) = rtrim(cftPGInvTran.PigGroupID)

left join (Select Distinct PigGroupID, ProjectID, PigProdPhaseID, ActCloseDate, ActStartDate from [$(SolomonApp)].dbo.cftPigGroup) cftPigGroup
on rtrim(cftPGInvTran.SourcePigGroupID) = rtrim(cftPigGroup.PigGroupID)

left join (Select SourceProject, TranDate, Sum(Qty) as 'Qty' from [$(SolomonApp)].dbo.cftPGInvTran Where TranTypeID = 'TI' and Reversal <> '1' Group by SourceProject, TranDate) SowFarmTotalHead
on rtrim(cftPGInvTran.SourceProject) = rtrim(SowFarmTotalHead.SourceProject)
and SowFarmTotalHead.TranDate between Cast(DateAdd(day, -21, Cast(cftPGInvTran.TranDate as datetime)) as datetime) and cftPGInvTran.TranDate

left join (Select SourcePigGroupID, Sum(Qty) as 'Qty' from [$(SolomonApp)].dbo.cftPGInvTran Where TranTypeID in ('TI','MI') and Reversal <> '1' Group by SourcePigGroupID) PigGroupTotalHead
on rtrim(cftPGInvTran.SourcePigGroupID) = rtrim(PigGroupTotalHead.SourcePigGroupID)

WHERE cftPGInvTran.TranTypeID IN ('TI','MI','PP')
AND   cftPGInvTran.Reversal <> '1'
AND   SourceTable.LoopNumber = (Select MAX(LoopNumber) from @SourceTable)
group by cftPGInvTran.SourcePigGroupID, 
Case when cftPGInvTran.SourcePigGroupID = '' then cftPGInvTran.SourceProject else cftPigGroup.ProjectID end,
Case when cftPGInvTran.SourcePigGroupID = '' then 'SOW' else cftPigGroup.PigProdPhaseID end,
Case when cftPGInvTran.SourcePigGroupID = '' then
Cast(DateAdd(day, -21, cftPGInvTran.TranDate) as smalldatetime) else cftPigGroup.ActStartDate end,
cftPGInvTran.TranDate,
cftPGInvTran.Qty,
PigGroupTotalHead.Qty,
SourceTable.SourcePercent 
	  
	  IF (SELECT MAX(SourcePigGroupID) from @SourceTable Where LoopNumber = (Select MAX(LoopNumber) from @SourceTable)) = ''
	  OR (SELECT MAX(LoopNumber) from @SourceTable) = 5
    
            BREAK
      ELSE
            CONTINUE

END

INSERT INTO @tblSowSourcePercent (PigGroupID, SourcePigGroupID, SourceProject, Phase, StartDate, EndDate, TransferHead, TotalHead, SourcePercent, LoopNumber)

	Select 
	@PigGroupID,
	SourcePigGroupID, 
	SourceProject,
	Phase,
	StartDate, 
	EndDate,  
	TransferHead, 
	TotalHead, 
	SourcePercent, 
	LoopNumber
	from @SourceTable 

	END;
	RETURN;
END
