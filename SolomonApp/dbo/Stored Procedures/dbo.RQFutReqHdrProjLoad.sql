 /****** Object:  Stored Procedure dbo.RQFutReqHdrProjLoad    Script Date: 9/4/2003 6:21:20 PM ******/

/****** Object:  Stored Procedure dbo.RQFutReqHdrProjLoad    Script Date: 7/5/2002 2:44:40 PM ******/

/****** Object:  Stored Procedure dbo.RQFutReqHdrProjLoad    Script Date: 1/7/2002 12:23:10 PM ******/

/****** Object:  Stored Procedure dbo.RQFutReqHdrProjLoad    Script Date: 1/2/01 9:39:36 AM ******/

/****** Object:  Stored Procedure dbo.RQFutReqHdrProjLoad    Script Date: 11/17/00 11:54:30 AM ******/

/****** Object:  Stored Procedure dbo.RQFutReqHdrProjLoad    Script Date: 10/25/00 8:32:15 AM ******/

/****** Object:  Stored Procedure dbo.RQFutReqHdrProjLoad    Script Date: 10/10/00 4:15:38 PM ******/

/****** Object:  Stored Procedure dbo.RQFutReqHdrProjLoad    Script Date: 10/2/00 4:58:13 PM ******/

/****** Object:  Stored Procedure dbo.RQFutReqHdrProjLoad    Script Date: 9/1/00 9:39:20 AM ******/
CREATE PROCEDURE RQFutReqHdrProjLoad
@parm1 varchar(16), @parm2 varchar(1), @parm3 varchar(2), @parm4 varchar(2), @parm5 varchar(2)
AS
Select * from RQReqHdr
where
Project = @parm1 and
status = 'SA' and
Budgeted = @parm2 and
ReqType = @parm3 and
AppvLevReq >= @parm4 and
AppvLevObt < @parm5
ORDER BY ReqNbr, ReqCntr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQFutReqHdrProjLoad] TO [MSDSL]
    AS [dbo];

