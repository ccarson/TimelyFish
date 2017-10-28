 /****** Object:  Stored Procedure dbo.RQOvrHdrProjLoad    Script Date: 9/4/2003 6:21:37 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrHdrProjLoad    Script Date: 7/5/2002 2:44:41 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrHdrProjLoad    Script Date: 1/7/2002 12:23:12 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrHdrProjLoad    Script Date: 1/2/01 9:39:37 AM ******/

/****** Object:  Stored Procedure dbo.RQOvrHdrProjLoad    Script Date: 11/17/00 11:54:31 AM ******/

/****** Object:  Stored Procedure dbo.RQOvrHdrProjLoad    Script Date: 10/25/00 8:32:17 AM ******/

/****** Object:  Stored Procedure dbo.RQOvrHdrProjLoad    Script Date: 10/10/00 4:15:39 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrHdrProjLoad    Script Date: 10/2/00 4:58:15 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrHdrProjLoad    Script Date: 9/1/00 9:39:22 AM ******/
CREATE procedure RQOvrHdrProjLoad
@parm1 varchar(16), @parm2 varchar(2)
as
select * from RQitemreqHdr where
Project = @parm1 and
status = 'SA' and
AppvLevObt < @parm2
ORDER BY ItemReqNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQOvrHdrProjLoad] TO [MSDSL]
    AS [dbo];

