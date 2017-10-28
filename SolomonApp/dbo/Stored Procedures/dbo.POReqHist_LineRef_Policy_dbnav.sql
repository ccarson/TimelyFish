 /****** Object:  Stored Procedure dbo.POReqHist_LineRef_Policy_dbnav    Script Date: 12/17/97 10:48:51 AM ******/
CREATE PROCEDURE POReqHist_LineRef_Policy_dbnav @parm1 Varchar(10), @parm2 Varchar(5), @Parm3 Varchar(47),
@parm4Beg SmallDateTime, @Parm4End SmallDateTime, @Parm5 Varchar(10) AS
SELECT * FROM POReqHist
WHERE ReqNbr = @parm1 and
LineRef Like @parm2 and
TranDate Between @Parm4Beg and @Parm4End and
TranTime LIKE @Parm5 and
UserID LIKE @Parm3 and
ApprPath = 'P'
ORDER BY ReqNbr, LineRef, TranDate DESC, TranTime DESC, UserID, ApprPath


