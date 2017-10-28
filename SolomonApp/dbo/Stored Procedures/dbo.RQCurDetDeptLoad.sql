 /****** Object:  Stored Procedure dbo.RQCurDetDeptLoad    Script Date: 9/4/2003 6:21:18 PM ******/

/****** Object:  Stored Procedure dbo.RQCurDetDeptLoad    Script Date: 7/5/2002 2:44:38 PM ******/

/****** Object:  Stored Procedure dbo.RQCurDetDeptLoad    Script Date: 1/7/2002 12:23:08 PM ******/

/****** Object:  Stored Procedure dbo.RQCurDetDeptLoad    Script Date: 1/2/01 9:39:33 AM ******/

/****** Object:  Stored Procedure dbo.RQCurDetDeptLoad    Script Date: 11/17/00 11:54:28 AM ******/

/****** Object:  Stored Procedure dbo.RQCurDetDeptLoad    Script Date: 10/25/00 8:32:13 AM ******/

/****** Object:  Stored Procedure dbo.RQCurDetDeptLoad    Script Date: 10/10/00 4:15:36 PM ******/

/****** Object:  Stored Procedure dbo.RQCurDetDeptLoad    Script Date: 10/2/00 4:58:11 PM ******/

/****** Object:  Stored Procedure dbo.RQCurDetDeptLoad    Script Date: 9/1/00 9:39:18 AM ******/

create procedure RQCurDetDeptLoad
@parm1 varchar(10), @parm2 varchar(10), @parm3 varchar(2),
@parm4 varchar(2), @parm5 varchar(16) as
Select * from RQItemreqdet where
ItemReqnbr = @parm1 and
dept = @parm2 and
status = 'SA' and
AppvLevReq >= @parm3 and
AppvLevObt = @parm4 and
(Project = ''Or Project = @parm5)
ORDER BY ItemReqNbr, LineNbr


