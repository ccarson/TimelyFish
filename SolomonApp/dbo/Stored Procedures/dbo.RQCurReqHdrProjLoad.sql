﻿ /****** Object:  Stored Procedure dbo.RQCurReqHdrProjLoad    Script Date: 9/4/2003 6:21:19 PM ******/

/****** Object:  Stored Procedure dbo.RQCurReqHdrProjLoad    Script Date: 7/5/2002 2:44:38 PM ******/

/****** Object:  Stored Procedure dbo.RQCurReqHdrProjLoad    Script Date: 1/7/2002 12:23:09 PM ******/

/****** Object:  Stored Procedure dbo.RQCurReqHdrProjLoad    Script Date: 1/2/01 9:39:34 AM ******/

/****** Object:  Stored Procedure dbo.RQCurReqHdrProjLoad    Script Date: 11/17/00 11:54:28 AM ******/

/****** Object:  Stored Procedure dbo.RQCurReqHdrProjLoad    Script Date: 10/25/00 8:32:14 AM ******/

/****** Object:  Stored Procedure dbo.RQCurReqHdrProjLoad    Script Date: 10/10/00 4:15:36 PM ******/

/****** Object:  Stored Procedure dbo.RQCurReqHdrProjLoad    Script Date: 10/2/00 4:58:12 PM ******/

/****** Object:  Stored Procedure dbo.RQCurReqHdrProjLoad    Script Date: 9/1/00 9:39:18 AM ******/
CREATE PROCEDURE RQCurReqHdrProjLoad
@parm1 varchar(16), @parm2 varchar(1), @parm3 varchar(2),
@parm4 varchar(2), @parm5 varchar(2)  AS

Select * from RQreqhdr where
Project = @parm1 and
status = 'SA' and
Budgeted = @parm2 and
ReqType = @parm3 and
AppvLevReq >=  @parm4 and
AppvLevObt = @parm5
ORDER BY ReqNbr, ReqCntr


