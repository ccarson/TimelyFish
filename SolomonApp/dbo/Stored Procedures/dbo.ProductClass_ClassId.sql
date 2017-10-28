 /****** Object:  Stored Procedure dbo.ProductClass_ClassId    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.ProductClass_ClassId    Script Date: 4/16/98 7:41:53 PM ******/
Create Procedure ProductClass_ClassId @parm1 varchar ( 6) As
        Select * from ProductClass where
                ClassId = @parm1
        Order by ClassId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProductClass_ClassId] TO [MSDSL]
    AS [dbo];

