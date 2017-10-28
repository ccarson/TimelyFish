 /****** Object:  Stored Procedure dbo.BUDetail_EstProp    Script Date: 4/7/98 12:38:58 PM ******/
CREATE PROCEDURE BUDetail_EstProp @Parm1 varchar ( 24), @Parm2 varchar ( 4), @Parm3 varchar ( 10) AS
SELECT * FROM Accthist WHERE (YTDEstimated <> 0 Or Annbdgt <> 0) And sub = @Parm1 and fiscyr = @Parm2 And ledgerid = @Parm3 Order By fiscyr, ledgerid, sub, Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BUDetail_EstProp] TO [MSDSL]
    AS [dbo];

