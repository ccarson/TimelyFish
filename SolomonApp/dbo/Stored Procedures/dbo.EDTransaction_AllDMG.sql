 /****** Object:  Stored Procedure dbo.EDTransaction_All    Script Date: 5/28/99 1:17:46 PM ******/
CREATE Proc EDTransaction_AllDMG @Parm1 varchar(3), @Parm2 varchar(1) As Select * From EDTransaction
Where Trans Like @Parm1 And Direction Like @Parm2 Order By Trans, Direction



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDTransaction_AllDMG] TO [MSDSL]
    AS [dbo];

