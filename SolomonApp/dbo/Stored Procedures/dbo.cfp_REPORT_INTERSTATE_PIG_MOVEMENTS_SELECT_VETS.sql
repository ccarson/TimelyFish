-- ===================================================================
-- Author:	Rewritten by Brian Diehl
-- Create date: 11/06/2011
-- Description:	Eliminated use of temp tables - was running in 8 minutes, now 2 seconds.
-- ===================================================================

CREATE procedure [dbo].[cfp_REPORT_INTERSTATE_PIG_MOVEMENTS_SELECT_VETS]
(	@StartDate datetime
,	@EndDate datetime
,	@SourceState varchar(8000) = NULL
,	@DestState varchar(8000) = NULL)
as

declare @SelectSQL varchar(8000)
declare @SourceStateJoin varchar(1000)
declare @DestStateJoin varchar(1000)
declare @OrderBy varchar(1000)

DECLARE 
	@pStartDate		datetime = @StartDate
  , @pEndDate		datetime = @EndDate
  , @pSourceState	varchar(8000) = @SourceState 
  , @pDestState		varchar(8000) = @DestState 

set @SelectSQL = 'select distinct v.VetContactID, v.VetName '
		+ 'from cfv_REPORT_INTERSTATE_PIG_MOVEMENTS v '
		+ 'where (v.MovementDate between ''' + cast(@pStartDate as varchar) + ''' and ''' + cast(@pEndDate as varchar) + ''') '

IF @SourceState IS NOT NULL
begin
    SET @SourceStateJoin = 'v.SState in ('
	SELECT @SourceStateJoin = @SourceStateJoin + dbo.cff_IN_STRING_SPLIT(@pSourceState,',')
	SET @SourceStateJoin = @SourceStateJoin + ')'
	SET @SelectSQL = @SelectSQL + ' and ' + @SourceStateJoin
end

IF @DestState IS NOT NULL
begin
    SET @DestStateJoin = 'v.DState in ('
	SELECT @DestStateJoin = @DestStateJoin + dbo.cff_IN_STRING_SPLIT(@pDestState,',')
	SET @DestStateJoin = @DestStateJoin + ')'
	SET @SelectSQL = @SelectSQL + ' and ' + @DestStateJoin
end

SET @SelectSQL = @SelectSQL + ' OPTION ( RECOMPILE ) ;'

print @SelectSQL
print @SourceState
print @DestState

EXECUTE (@SelectSQL)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_REPORT_INTERSTATE_PIG_MOVEMENTS_SELECT_VETS] TO [MSDSL]
    AS [dbo];

