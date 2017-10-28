 Create Proc Comp_Comp_Stat_Dates @CmpnentID varchar (30), @StopDate smalldatetime as
	Select * from Component where
		Cmpnentid like @CmpnentID
        		and ((Status = 'P' and StartDate between '01/02/1900' and @StopDate)
			  or (Status = 'A' and StopDate between '01/02/1900' and @StopDate))
        	order by Cmpnentid, Siteid, Status



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Comp_Comp_Stat_Dates] TO [MSDSL]
    AS [dbo];

