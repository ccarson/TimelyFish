 /****** Object:  Stored Procedure dbo.PIAdj_Location_Reset    Script Date: 4/17/98 10:58:19 AM ******/
Create Proc PIAdj_Location_Reset @Parm1 Varchar(10),@Parm2 Varchar(10) as
   Update Location set countstatus = 'A'
	where location.siteid = @parm1 and location.whseloc = @Parm2
	and Location.countstatus = 'P'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PIAdj_Location_Reset] TO [MSDSL]
    AS [dbo];

