 /****** Object:  Stored Procedure dbo.RQOvrReqDetDeptLoad    Script Date: 9/4/2003 6:21:37 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqDetDeptLoad    Script Date: 7/5/2002 2:44:41 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqDetDeptLoad    Script Date: 1/7/2002 12:23:12 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqDetDeptLoad    Script Date: 1/2/01 9:39:37 AM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqDetDeptLoad    Script Date: 11/17/00 11:54:31 AM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqDetDeptLoad    Script Date: 10/25/00 8:32:17 AM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqDetDeptLoad    Script Date: 10/10/00 4:15:39 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqDetDeptLoad    Script Date: 10/2/00 4:58:15 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqDetDeptLoad    Script Date: 9/1/00 9:39:22 AM ******/
CREATE PROCEDURE RQOvrReqDetDeptLoad
@parm1 varchar(10), @parm2 varchar(2), @parm3 varchar(10), @parm4 varchar(2), @parm5 varchar(1), @parm6 varchar(16)
 AS
select  * from RQreqdet
where
reqnbr = @parm1 and
Reqcntr = @parm2 and
dept = @parm3 and
status = 'SA'  and
AppvLevObt < AppvLevReq and
AppvLevObt <= @parm4 and
Budgeted = @parm5 and
(Project = '' Or Project = @parm6)
ORDER BY ReqNbr, ReqCntr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQOvrReqDetDeptLoad] TO [MSDSL]
    AS [dbo];

