CREATE PROCEDURE XDDEdiVersion_EntryClass_Ver @parm1 varchar(4), @parm2 varchar(6) AS
  Select * from XDDEdiVersion where EntryClass = @parm1 and
  EDIVersion LIKE @parm2
  ORDER by EntryClass, EDIVersion

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDEdiVersion_EntryClass_Ver] TO [MSDSL]
    AS [dbo];

