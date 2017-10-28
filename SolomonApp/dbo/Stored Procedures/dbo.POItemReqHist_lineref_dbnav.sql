 /****** Object:  Stored Procedure dbo.POItemReqHist_lineref_dbnav    Script Date: 12/17/97 10:48:50 AM ******/
CREATE PROCEDURE POItemReqHist_lineref_dbnav @parm1 Varchar(10), @parm2 Varchar(5), @parm3Beg SmallDAteTime,
@Parm3End SmallDateTime, @parm4 Varchar(10), @Parm5 Varchar(47) AS
SELECT * FROM POItemReqHist
WHERE ItemReqNbr = @parm1 and
LineRef Like @parm2 and
TranDate Between @Parm3Beg and @Parm3End and
TranTime LIKE @Parm4 and
UserID LIKE @Parm5
ORDER BY ItemReqNbr, LineRef, TranDate DESC, TranTime DESC, UserID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POItemReqHist_lineref_dbnav] TO [MSDSL]
    AS [dbo];

