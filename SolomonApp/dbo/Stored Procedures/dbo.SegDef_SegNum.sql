 /****** Object:  Stored Procedure dbo.SegDef_SegNum    Script Date: 4/7/98 12:38:59 PM ******/
CREATE PROCEDURE SegDef_SegNum
@Parm1 Varchar ( 15), @Parm2 Varchar ( 2), @Parm3 Varchar ( 24) AS
SELECT * FROM SegDef WHERE FieldClassName = @Parm1 And SegNumber = @Parm2 And ID Like @Parm3 ORDER BY FieldClassName, SegNumber, ID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SegDef_SegNum] TO [MSDSL]
    AS [dbo];

