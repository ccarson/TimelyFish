 /****** Object:  Stored Procedure dbo.RQCurDetProjLoad    Script Date: 9/4/2003 6:21:19 PM ******/

/****** Object:  Stored Procedure dbo.RQCurDetProjLoad    Script Date: 7/5/2002 2:44:38 PM ******/

/****** Object:  Stored Procedure dbo.RQCurDetProjLoad    Script Date: 1/7/2002 12:23:08 PM ******/

/****** Object:  Stored Procedure dbo.RQCurDetProjLoad    Script Date: 1/2/01 9:39:33 AM ******/

/****** Object:  Stored Procedure dbo.RQCurDetProjLoad    Script Date: 11/17/00 11:54:28 AM ******/

/****** Object:  Stored Procedure dbo.RQCurDetProjLoad    Script Date: 10/25/00 8:32:13 AM ******/

/****** Object:  Stored Procedure dbo.RQCurDetProjLoad    Script Date: 10/10/00 4:15:36 PM ******/

/****** Object:  Stored Procedure dbo.RQCurDetProjLoad    Script Date: 10/2/00 4:58:11 PM ******/

/****** Object:  Stored Procedure dbo.RQCurDetProjLoad    Script Date: 9/1/00 9:39:18 AM ******/
create procedure RQCurDetProjLoad
@parm1 varchar(10), @parm2 varchar(16), @parm3 varchar(2), @parm4 varchar(2)
as
Select * from RQitemreqdet where
itemReqnbr = @parm1 and
Project = @parm2 and
status = 'SA' and
AppvLevReq >= @parm3 and
AppvLevObt = @parm4
ORDER BY ItemReqNbr, LineNbr


