 /****** Object:  Stored Procedure dbo.PIDetail_Location_Reset    Script Date: 4/17/98 10:58:19 AM ******/
Create Procedure PIDetail_Location_Reset @parm1 VarChar(10) as
   Update Location set Location.countstatus = 'A'
   	From Location, pidetail
    	Where pidetail.piid = @parm1
    	and Location.countstatus = 'P'
    	and Location.siteid = pidetail.siteid
    	and Location.invtid = pidetail.invtid
    	and Location.whseloc = pidetail.whseloc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PIDetail_Location_Reset] TO [MSDSL]
    AS [dbo];

