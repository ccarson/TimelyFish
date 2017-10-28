CREATE PROCEDURE XDDEdiDataElemLU_Version_DE_V @parm1 varchar(6), @parm2 varchar(20), @parm3 smallint AS
  Select * from XDDEdiDataElemLU where EdiVersion = @parm1 and
  SolValue = @parm2 and
  DataElemRN = @parm3
  ORDER by EdiVersion, DataElemRN, SolValue

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDEdiDataElemLU_Version_DE_V] TO [MSDSL]
    AS [dbo];

