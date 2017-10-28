 /****** Object:  Stored Procedure dbo.BUDetail_YrVersSel2    Script Date: 4/7/98 12:38:58 PM ******/
CREATE PROCEDURE BUDetail_YrVersSel2
@parm1 varchar ( 10), @Parm2 varchar ( 4), @Parm3 varchar ( 10), @Parm4 varchar ( 24), @Parm5 varchar ( 10) AS
SELECT * FROM accthist, account WHERE Annbdgt <> 0 AND CpnyID = @parm1 AND fiscyr = @Parm2 AND ledgerid = @Parm3 AND sub = @Parm4 AND Accthist.Acct Like @Parm5 and accthist.acct = account.acct ORDER BY fiscyr, ledgerid, sub, accthist.Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BUDetail_YrVersSel2] TO [MSDSL]
    AS [dbo];

