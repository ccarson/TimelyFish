


-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_ADG_rpt2.5
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE  PROCEDURE [dbo].[cfp_Get_Eval_Counts]
@PicBegin char(6),@PicEnd char(6),  @sitecontactid char(6)

AS
BEGIN

select lv1.picyear_week, count(1) nbrevals
from
	(SELECT picyear_week, eval_id,count(1) nbrevals
	  FROM [dbo].[cft_eval_dw] 
	   where sitecontactid = @sitecontactid
	   and picyear_week between @PicBegin and @PicEnd
	 group by picyear_week, eval_id) lv1
group by lv1.picyear_week
order by lv1.picyear_week





END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_Get_Eval_Counts] TO [CorpReports]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_Get_Eval_Counts] TO [db_sp_exec]
    AS [dbo];

