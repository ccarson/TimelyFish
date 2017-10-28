 /****** Object:  Stored Procedure dbo.RQFutDetDeptLoad    Script Date: 9/4/2003 6:21:20 PM ******/

/****** Object:  Stored Procedure dbo.RQFutDetDeptLoad    Script Date: 7/5/2002 2:44:39 PM ******/

/****** Object:  Stored Procedure dbo.RQFutDetDeptLoad    Script Date: 1/7/2002 12:23:10 PM ******/

/****** Object:  Stored Procedure dbo.RQFutDetDeptLoad    Script Date: 1/2/01 9:39:35 AM ******/

/****** Object:  Stored Procedure dbo.RQFutDetDeptLoad    Script Date: 11/17/00 11:54:29 AM ******/

/****** Object:  Stored Procedure dbo.RQFutDetDeptLoad    Script Date: 10/25/00 8:32:15 AM ******/

/****** Object:  Stored Procedure dbo.RQFutDetDeptLoad    Script Date: 10/10/00 4:15:37 PM ******/

/****** Object:  Stored Procedure dbo.RQFutDetDeptLoad    Script Date: 10/2/00 4:58:13 PM ******/

/****** Object:  Stored Procedure dbo.RQFutDetDeptLoad    Script Date: 9/1/00 9:39:19 AM ******/
create procedure RQFutDetDeptLoad
@parm1 varchar(10), @parm2 varchar(10), @parm3 varchar(2),
@parm4 varchar(2), @parm5 varchar(16) as
Select * from RQItemreqdet where
ItemReqnbr = @parm1 and
dept = @parm2 and
status = 'SA' and
AppvLevreq >= @parm3 and
AppvLevobt < @parm4 and
(Project = ''Or Project = @parm5 )
ORDER BY ItemReqNbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQFutDetDeptLoad] TO [MSDSL]
    AS [dbo];

