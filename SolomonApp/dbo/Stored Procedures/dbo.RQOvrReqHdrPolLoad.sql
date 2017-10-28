 /****** Object:  Stored Procedure dbo.RQOvrReqHdrPolLoad    Script Date: 9/4/2003 6:21:38 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqHdrPolLoad    Script Date: 7/5/2002 2:44:42 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqHdrPolLoad    Script Date: 1/7/2002 12:23:12 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqHdrPolLoad    Script Date: 1/2/01 9:39:37 AM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqHdrPolLoad    Script Date: 11/17/00 11:54:31 AM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqHdrPolLoad    Script Date: 10/25/00 8:32:17 AM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqHdrPolLoad    Script Date: 10/10/00 4:15:39 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqHdrPolLoad    Script Date: 10/2/00 4:58:15 PM ******/

/****** Object:  Stored Procedure dbo.RQOvrReqHdrPolLoad    Script Date: 9/1/00 9:39:22 AM ******/
CREATE PROCEDURE RQOvrReqHdrPolLoad
@parm1 varchar(10), @parm2 varchar(2)
 AS
Select * from RQReqHdr
where
MaterialType = @parm1 and
PolicyLevObt < PolicyLevReq and
PolicyLevObt <= @parm2 and
status = 'SA'
ORDER BY ReqNbr, ReqCntr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQOvrReqHdrPolLoad] TO [MSDSL]
    AS [dbo];

