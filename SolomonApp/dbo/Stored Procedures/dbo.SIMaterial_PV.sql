 /****** Object:  Stored Procedure dbo.SIMaterial_PV    Script Date: 12/17/97 10:48:35 AM ******/
Create Procedure SIMaterial_PV @Parm1 Varchar(10) as
Select * from SIMatlTypes where MaterialType like @Parm1
Order by MaterialType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SIMaterial_PV] TO [MSDSL]
    AS [dbo];

