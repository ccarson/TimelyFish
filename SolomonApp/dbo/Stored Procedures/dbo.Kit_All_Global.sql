 /****** Object:  Stored Procedure dbo.Kit_All_Global    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.Kit_All_Global    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc Kit_All_Global @parm1 varchar ( 30) as
            Select * from Kit where KitId like @parm1
                and SiteId = 'GLOBAL'
                and Status = 'A'
                order by KitId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Kit_All_Global] TO [MSDSL]
    AS [dbo];

