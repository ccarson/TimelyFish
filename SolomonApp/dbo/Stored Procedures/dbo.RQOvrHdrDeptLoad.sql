 /****** Object:  Stored Procedure dbo.RQOvrHdrDeptLoad    Script Date: 9/4/2003 6:21:37 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrHdrDeptLoad    Script Date: 7/5/2002 2:44:41 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrHdrDeptLoad    Script Date: 1/7/2002 12:23:11 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrHdrDeptLoad    Script Date: 1/2/01 9:39:37 AM ******/

/****** Object:  Stored Procedure dbo.RQOvrHdrDeptLoad    Script Date: 11/17/00 11:54:31 AM ******/

/****** Object:  Stored Procedure dbo.RQOvrHdrDeptLoad    Script Date: 10/25/00 8:32:17 AM ******/

/****** Object:  Stored Procedure dbo.RQOvrHdrDeptLoad    Script Date: 10/10/00 4:15:39 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrHdrDeptLoad    Script Date: 10/2/00 4:58:15 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrHdrDeptLoad    Script Date: 9/1/00 9:39:22 AM ******/
CREATE procedure RQOvrHdrDeptLoad
@parm1 varchar(10), @parm2 varchar(2),
@parm3 varchar(16) as
Select * from RQItemreqhdr where
requstnrdept = @parm1 and
status = 'SA' and
AppvLevObt < @parm2 and
(Project = ''Or Project = @parm3 )
ORDER BY ItemReqNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQOvrHdrDeptLoad] TO [MSDSL]
    AS [dbo];

