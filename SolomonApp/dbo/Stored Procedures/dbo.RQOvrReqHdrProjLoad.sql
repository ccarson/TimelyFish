 /****** Object:  Stored Procedure dbo.RQOvrReqHdrProjLoad    Script Date: 9/4/2003 6:21:38 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqHdrProjLoad    Script Date: 7/5/2002 2:44:42 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqHdrProjLoad    Script Date: 1/7/2002 12:23:12 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqHdrProjLoad    Script Date: 1/2/01 9:39:37 AM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqHdrProjLoad    Script Date: 11/17/00 11:54:31 AM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqHdrProjLoad    Script Date: 10/25/00 8:32:17 AM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqHdrProjLoad    Script Date: 10/10/00 4:15:40 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqHdrProjLoad    Script Date: 10/2/00 4:58:15 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqHdrProjLoad    Script Date: 9/1/00 9:39:22 AM ******/
CREATE PROCEDURE RQOvrReqHdrProjLoad
@parm1 varchar(16), @parm2 varchar(1), @parm3 varchar(2), @parm4 varchar(2)
 AS
Select  * from RQReqHdr
where
Project = @parm1 and
(status = 'SA' or Status = 'RA') and
Budgeted = @parm2 and
ReqType = @parm3 and
AppvLevObt < AppvLevReq and
AppvLevObt <= @parm4
ORDER BY ReqNbr, ReqCntr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQOvrReqHdrProjLoad] TO [MSDSL]
    AS [dbo];

