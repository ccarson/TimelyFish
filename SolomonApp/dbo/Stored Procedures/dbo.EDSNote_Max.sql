 CREATE Proc EDSNote_Max @Table varchar(20), @Level varchar(20) As
Select Max(nID) From Snote Where sTablename = @Table And sLevelName = @Level



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSNote_Max] TO [MSDSL]
    AS [dbo];

