 /****** Object:  Stored Procedure dbo.POProjApprDefer_DBNAV    Script Date: 12/17/97 10:48:58 AM ******/
CREATE PROCEDURE POProjApprDefer_DBNAV @parm1 VarChar(16), @parm2 VarChar(47), @parm3 VarChar(47),
@parm4startdate SmallDateTime, @parm4enddate SmallDateTime as
Select * from POProjApprDefer where Project like @parm1 and
UserId like @parm2 and
DeferUserID like @parm3 and
StartDate between @parm4startdate and @parm4enddate
Order by Project,userid,DeferUserID, startdate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POProjApprDefer_DBNAV] TO [MSDSL]
    AS [dbo];

