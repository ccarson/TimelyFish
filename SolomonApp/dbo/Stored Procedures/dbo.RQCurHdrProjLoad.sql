 /****** Object:  Stored Procedure dbo.RQCurHdrProjLoad    Script Date: 9/4/2003 6:21:19 PM ******/

/****** Object:  Stored Procedure dbo.RQCurHdrProjLoad    Script Date: 7/5/2002 2:44:38 PM ******/

/****** Object:  Stored Procedure dbo.RQCurHdrProjLoad    Script Date: 1/7/2002 12:23:08 PM ******/

/****** Object:  Stored Procedure dbo.RQCurHdrProjLoad    Script Date: 1/2/01 9:39:33 AM ******/

/****** Object:  Stored Procedure dbo.RQCurHdrProjLoad    Script Date: 11/17/00 11:54:28 AM ******/

/****** Object:  Stored Procedure dbo.RQCurHdrProjLoad    Script Date: 10/25/00 8:32:14 AM ******/

/****** Object:  Stored Procedure dbo.RQCurHdrProjLoad    Script Date: 10/10/00 4:15:36 PM ******/

/****** Object:  Stored Procedure dbo.RQCurHdrProjLoad    Script Date: 10/2/00 4:58:11 PM ******/

/****** Object:  Stored Procedure dbo.RQCurHdrProjLoad    Script Date: 9/1/00 9:39:18 AM ******/
CREATE procedure RQCurHdrProjLoad
@parm1 varchar(16), @parm2 varchar(2), @parm3 varchar(2)
as
Select * from RQitemreqhdr where
Project = @parm1 and
status = 'SA' and
AppvLevReq >= @parm2 and
AppvLevObt = @parm3
ORDER BY ItemReqNbr


