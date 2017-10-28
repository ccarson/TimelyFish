 /****** Object:  Stored Procedure dbo.GetTableNameFromIndex    Script Date: 4/17/98 12:50:25 PM ******/
/****** Object:  Stored Procedure dbo.GetTableNameFromIndex    Script Date: 4/7/98 12:56:04 PM ******/
---SYSTEMTABLE
--- This Stored Proc needs to go in both system & App db
Create Proc  GetTableNameFromIndex @parm1 varchar(32) as
Select CONVERT(varchar(30),name) from sysobjects where id =
(select id from sysindexes where name = @parm1 )



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetTableNameFromIndex] TO [MSDSL]
    AS [dbo];

