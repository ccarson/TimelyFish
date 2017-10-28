 /****** Object:  Stored Procedure dbo.Note_All_by_TableName    Script Date: 4/17/98 12:50:25 PM ******/
create Proc Note_All_by_TableName as
    select sTableName, nID from snote order by sTableName



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Note_All_by_TableName] TO [MSDSL]
    AS [dbo];

