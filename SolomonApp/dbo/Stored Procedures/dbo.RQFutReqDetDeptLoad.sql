 /****** Object:  Stored Procedure dbo.RQFutReqDetDeptLoad    Script Date: 9/4/2003 6:21:20 PM ******/

/****** Object:  Stored Procedure dbo.RQFutReqDetDeptLoad    Script Date: 7/5/2002 2:44:40 PM ******/

/****** Object:  Stored Procedure dbo.RQFutReqDetDeptLoad    Script Date: 1/7/2002 12:23:10 PM ******/

/****** Object:  Stored Procedure dbo.RQFutReqDetDeptLoad    Script Date: 1/2/01 9:39:35 AM ******/

/****** Object:  Stored Procedure dbo.RQFutReqDetDeptLoad    Script Date: 11/17/00 11:54:29 AM ******/

/****** Object:  Stored Procedure dbo.RQFutReqDetDeptLoad    Script Date: 10/25/00 8:32:15 AM ******/

/****** Object:  Stored Procedure dbo.RQFutReqDetDeptLoad    Script Date: 10/10/00 4:15:37 PM ******/

/****** Object:  Stored Procedure dbo.RQFutReqDetDeptLoad    Script Date: 10/2/00 4:58:13 PM ******/

/****** Object:  Stored Procedure dbo.RQFutReqDetDeptLoad    Script Date: 9/1/00 9:39:19 AM ******/
CREATE PROCEDURE RQFutReqDetDeptLoad
@parm1 varchar(10), @parm2 varchar(2), @parm3 varchar(10), @parm4 varchar(1), @parm5 varchar(2), @parm6 varchar(2), @parm7 varchar(16)
 AS
Select * from RQreqdet
where
Reqnbr = @parm1 and
ReqCntr = @parm2 and
dept = @parm3 and
status = 'SA' and
Budgeted = @parm4 and
AppvLevReq >= @parm5 and
AppvLevObt < @parm6 and
(Project = '' Or Project = @parm7)
ORDER BY ReqNbr, ReqCntr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQFutReqDetDeptLoad] TO [MSDSL]
    AS [dbo];

