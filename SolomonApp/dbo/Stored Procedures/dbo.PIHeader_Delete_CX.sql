 /****** Object:  Stored Procedure dbo.PIHeader_Delete_CX    Script Date: 4/17/98 10:58:19 AM ******/
Create Proc PIHeader_Delete_CX @parm1 varchar (6) as
    Delete From PIHeader
	Where (PIHeader.Status = 'X' OR PIHeader.Status = 'C')
	And  PIHeader.PerClosed <= @Parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PIHeader_Delete_CX] TO [MSDSL]
    AS [dbo];

