
CREATE proc WS_PreviousWeekEndDate 
@parm1 smalldatetime --Week end date
as  
Begin
	Select Max(we_date) FROM PJWEEK WHERE We_Date < @parm1
End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PreviousWeekEndDate] TO [MSDSL]
    AS [dbo];

