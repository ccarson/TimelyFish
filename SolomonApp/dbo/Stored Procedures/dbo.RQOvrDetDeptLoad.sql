 /****** Object:  Stored Procedure dbo.RQOvrDetDeptLoad    Script Date: 9/4/2003 6:21:37 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrDetDeptLoad    Script Date: 7/5/2002 2:44:41 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrDetDeptLoad    Script Date: 1/7/2002 12:23:11 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrDetDeptLoad    Script Date: 1/2/01 9:39:37 AM ******/

/****** Object:  Stored Procedure dbo.RQOvrDetDeptLoad    Script Date: 11/17/00 11:54:31 AM ******/

/****** Object:  Stored Procedure dbo.RQOvrDetDeptLoad    Script Date: 10/25/00 8:32:17 AM ******/

/****** Object:  Stored Procedure dbo.RQOvrDetDeptLoad    Script Date: 10/10/00 4:15:39 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrDetDeptLoad    Script Date: 10/2/00 4:58:15 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrDetDeptLoad    Script Date: 9/1/00 9:39:21 AM ******/
create procedure RQOvrDetDeptLoad
@parm1 varchar(10), @parm2 varchar(10), @parm3 varchar(2),
@parm4 varchar(16) as
Select * from RQItemreqdet where
ItemReqnbr = @parm1 and
dept = @parm2 and
status = 'SA' and
AppvLevObt < @parm3 and
(Project = ''Or Project = @parm4 )
ORDER BY ItemReqNbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQOvrDetDeptLoad] TO [MSDSL]
    AS [dbo];

