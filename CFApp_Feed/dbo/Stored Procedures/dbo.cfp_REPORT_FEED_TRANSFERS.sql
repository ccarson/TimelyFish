-- =============================================
-- Author:	mdawson
-- Create date: 8/19/09
-- Description:	shows feed that has been transferred between groups
-- =============================================
CREATE PROCEDURE dbo.cfp_REPORT_FEED_TRANSFERS
@StartDate datetime,
@EndDate datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select distinct
		pjri.pjt_entity 'Return PigGroup'
	,	pjii.pjt_entity 'Destination PigGroup'
	,	pjri.tr_id04 'BatchID'
	,	gs.Qty
	,	gs.Wgt
	,	convert(varchar,pjri.Trans_Date,101) 'Trans_Date'
	,	pjri.units 'Return Units'
	,	pjii.units 'Destination Units'
	,	pjri.Unit_Of_Measure
	,	pjri.tr_comment 'Ration'
	,	pgri.pigprodphaseid 'Return Phase'
	,	pgii.pigprodphaseid 'Destination Phase'
	from [$(SolomonApp)].dbo.cfv_GroupStart gs (nolock)
	join [$(SolomonApp)].dbo.pjtran pjri (nolock) 
		on pjri.pjt_entity =gs.taskid 
		and pjri.batch_type = 'ri'
		and pjri.trans_date > '8/1/09'
		and pjri.acct = 'pig feed issue' 
	join [$(SolomonApp)].dbo.cftPigGroup pgri (nolock) 
		on pjri.pjt_entity = pgri.taskid
	join [$(SolomonApp)].dbo.pjtran pjii (nolock)
		on pjii.trans_date = pjri.trans_date
		and pjii.batch_type = 'ii'
		and pjii.trans_date > '8/1/09'
		and pjii.trans_date = pjri.trans_date
		and pjii.acct = 'pig feed issue' 
		and pjii.tr_comment = pjri.tr_comment
		and pjii.units = abs(pjri.units)
		and pjii.project = pjri.project
	join [$(SolomonApp)].dbo.cftPigGroup pgii (nolock) 
		on pjii.pjt_entity = pgii.taskid
	where	pgri.pigprodphaseid = pgii.pigprodphaseid
	and	pgri.pigprodphaseid in ('NUR','FIN')
	and not exists (select * from [$(SolomonApp)].dbo.cftFeedOrder (nolock) where TaskID = pjri.pjt_entity and DateOrd = pjri.trans_date)
	and pgri.BarnNbr = pgii.BarnNbr
	and pjri.Trans_Date between isnull(@StartDate,'1/1/1900') and isnull(@EndDate,'1/1/3000')
	order by pjri.tr_id04

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_FEED_TRANSFERS] TO [db_sp_exec]
    AS [dbo];

