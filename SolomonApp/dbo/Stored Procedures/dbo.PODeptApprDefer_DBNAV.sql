 /****** Object:  Stored Procedure dbo.PODeptApprDefer_DBNAV    Script Date: 12/17/97 10:48:58 AM ******/
CREATE PROCEDURE PODeptApprDefer_DBNAV @parm1 VarChar(10), @parm2 VarChar(47), @parm3 VarChar(47),
@parm4startdate SmallDateTime, @parm4enddate SmallDateTime as
Select * from PODeptApprDefer where Deptid like @parm1 and
UserId like @parm2 and
DeferUserID like @parm3 and
StartDate between @parm4startdate and @parm4enddate
Order by DeptId,userid,DeferUserID, startdate


