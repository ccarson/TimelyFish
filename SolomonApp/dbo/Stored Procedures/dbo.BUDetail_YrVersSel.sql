 /****** Object:  Stored Procedure dbo.BUDetail_YrVersSel    Script Date: 4/7/98 12:38:58 PM ******/
CREATE PROCEDURE BUDetail_YrVersSel
@parm1 varchar ( 10), @Parm2 varchar ( 4), @Parm3 varchar ( 10), @Parm4 varchar ( 24), @Parm5 varchar ( 10) AS
SELECT * FROM Accthist,account WHERE cpnyid = @parm1 And fiscyr = @Parm2 And ledgerid = @Parm3 And sub = @Parm4 And Accthist.Acct Like @Parm5 and accthist.acct = account.acct ORDER BY fiscyr, ledgerid, sub, accthist.Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BUDetail_YrVersSel] TO [MSDSL]
    AS [dbo];

