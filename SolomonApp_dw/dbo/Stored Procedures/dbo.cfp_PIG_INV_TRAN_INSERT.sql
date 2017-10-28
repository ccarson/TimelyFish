

-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 8/31/2011
-- Description:	Populates table in data warehouse.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_PIG_INV_TRAN_INSERT]
AS
BEGIN

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
INSERT INTO  dbo.cft_PIG_INV_TRAN
(	PigGroupID
	,Source
	,TranSubTypeID
	,Qty)

Select Distinct 
PigGroupID,
Case when SourcePigGroupID = '' then SourceProject else SourcePigGroupID end as 'Source',
TranSubTypeID,
Sum(Qty) as 'Qty'
from [$(SolomonApp)].dbo.cftPGInvTran
where TranTypeID = 'TI'
and Reversal <> '1'
group by
PigGroupID,
SourcePigGroupID,
SourceProject,
TranSubTypeID
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_INV_TRAN_INSERT] TO [db_sp_exec]
    AS [dbo];

