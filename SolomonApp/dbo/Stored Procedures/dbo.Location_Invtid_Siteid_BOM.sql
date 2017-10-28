 /****** Object:  Stored Procedure dbo.Location_Invtid_Siteid_BOM    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.Location_Invtid_Siteid_BOM    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc Location_Invtid_Siteid_BOM @parm1 varchar ( 30), @parm2 varchar ( 10) as
Select * from location where invtid = @parm1 and siteid like @parm2 order by
        invtid, siteid, whseloc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Location_Invtid_Siteid_BOM] TO [MSDSL]
    AS [dbo];

