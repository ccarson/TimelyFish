 /****** Object:  Stored Procedure dbo.Kit_All    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.Kit_All    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc Kit_All @parm1 varchar ( 30) as
            Select * from Kit where KitId like @parm1
                order by KitId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Kit_All] TO [MSDSL]
    AS [dbo];

