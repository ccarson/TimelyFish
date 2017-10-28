 /****** Object:  Stored Procedure dbo.GetTableNameID    Script Date: 4/17/98 12:50:25 PM ******/
/****** Object:  Stored Procedure dbo.GetTableNameID    Script Date: 4/7/98 12:56:04 PM ******/
--SYSTEMTABLE
Create Proc  GetTableNameID as
Select CONVERT(varchar(30),name), id from sysobjects where type = 'U' order by name



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetTableNameID] TO [MSDSL]
    AS [dbo];

