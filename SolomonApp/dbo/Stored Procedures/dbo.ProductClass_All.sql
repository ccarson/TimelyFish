 /****** Object:  Stored Procedure dbo.ProductClass_All    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.ProductClass_All    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc ProductClass_All @parm1 varchar ( 6) as
    Select * from ProductClass where ClassId like @parm1 order by ClassId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProductClass_All] TO [MSDSL]
    AS [dbo];

