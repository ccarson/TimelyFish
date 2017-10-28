 /****** Object:  Stored Procedure dbo.GetProcSource    Script Date: 4/17/98 12:50:25 PM ******/
/****** Object:  Stored Procedure dbo.GetProcSource    Script Date: 4/7/98 12:56:04 PM ******/
---SYSTEMTABLE
--- This Stored Proc needs to go in both system & App db
Create Proc  GetProcSource @parm1 varchar(32) as
Select text from syscomments where id = object_id( @parm1) order by colid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetProcSource] TO [MSDSL]
    AS [dbo];

