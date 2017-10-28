 /****** Object:  Stored Procedure dbo.SIMaterial_all    Script Date: 12/17/97 10:48:35 AM ******/
Create Procedure SIMaterial_all @Parm1 Varchar(10) as
Select * from SIMatlTypes where Status = 'A' and MaterialType like @Parm1
Order by MaterialType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SIMaterial_all] TO [MSDSL]
    AS [dbo];

