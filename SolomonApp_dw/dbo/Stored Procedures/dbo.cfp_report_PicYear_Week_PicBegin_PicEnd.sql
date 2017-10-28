












-- ==================================================================
-- Author:		Steve Ripley
-- Create date: 05/06/2014
-- Description:	Returns PicYear_week begin (52 weeks ago) and end (current week or current week- 8 weeks)
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_report_PicYear_Week_PicBegin_PicEnd]
	@PicYear_Week char(6)
AS


	-----------------------------------------------------------------
	-- Report Data
	-----------------------------------------------------------------
declare @daydate smalldatetime
declare @daydate_plus8 smalldatetime
declare @maxPicYear_week char(6)
declare @PicYear_week_plus8 char(6)
declare @PicBegin char(6)
declare @PicEnd char(6)



select @daydate = daydate from  dbo.cftDayDefinition_WithWeekInfo (nolock) where PicYear_week = @PicYear_Week and dayname = 'Saturday';
select @daydate_plus8 = convert(smalldatetime,CONVERT(char(10),dateadd(ww,8,@daydate), 101)) from  dbo.cftDayDefinition_WithWeekInfo (nolock) 
	where daydate = @daydate;
select @PicYear_week_plus8 = PicYear_Week from  dbo.cftDayDefinition_WithWeekInfo (nolock) where daydate =  @daydate_plus8;

--select @daydate, 'is @daydate'

select @maxPicYear_week = PicYear_Week from  dbo.cftDayDefinition_WithWeekInfo (nolock) 
	where CONVERT(char(10),daydate, 101) = CONVERT(char(10),dateadd(ww,-8,getdate()), 101);
	
	
--select @maxPicYear_week, 'is @maxPicYear_week'

--select CONVERT(char(10),@daydate, 101), 'is CONVERT(char(10),@daydate, 101)'

--select CONVERT(char(10),dateadd(ww,-8,getdate()), 101), 'is CONVERT(char(10),dateadd(ww,-8,getdate()), 101)'

select @PicEnd = dw.PicYear_week
from  dbo.cftDayDefinition_WithWeekInfo dw
where dw.dayname = 'saturday' and dw.PicYear_week = 
	case
		when @daydate_plus8 <= convert(smalldatetime,CONVERT(char(10),dateadd(ww,-8,getdate()), 101)) then @PicYear_Week_plus8
		else @maxPicYear_Week
	end
order by dw.PicYear_Week desc

select @PicBegin = dw.PicYear_Week
from  dbo.cftDayDefinition_WithWeekInfo dw
where dw.dayname = 'saturday' 
and dw.daydate = dateadd(ww,-104,@daydate)
order by dw.PicYear_Week desc

select @PicBegin as PicBegin, @PicEnd as PicEnd



















GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_report_PicYear_Week_PicBegin_PicEnd] TO [CorpReports]
    AS [dbo];

