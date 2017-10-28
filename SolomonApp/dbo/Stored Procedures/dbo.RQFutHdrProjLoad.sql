 /****** Object:  Stored Procedure dbo.RQFutHdrProjLoad    Script Date: 9/4/2003 6:21:20 PM ******/

/****** Object:  Stored Procedure dbo.RQFutHdrProjLoad    Script Date: 7/5/2002 2:44:40 PM ******/

/****** Object:  Stored Procedure dbo.RQFutHdrProjLoad    Script Date: 1/7/2002 12:23:10 PM ******/

/****** Object:  Stored Procedure dbo.RQFutHdrProjLoad    Script Date: 1/2/01 9:39:35 AM ******/

/****** Object:  Stored Procedure dbo.RQFutHdrProjLoad    Script Date: 11/17/00 11:54:29 AM ******/

/****** Object:  Stored Procedure dbo.RQFutHdrProjLoad    Script Date: 10/25/00 8:32:15 AM ******/

/****** Object:  Stored Procedure dbo.RQFutHdrProjLoad    Script Date: 10/10/00 4:15:37 PM ******/

/****** Object:  Stored Procedure dbo.RQFutHdrProjLoad    Script Date: 10/2/00 4:58:13 PM ******/

/****** Object:  Stored Procedure dbo.RQFutHdrProjLoad    Script Date: 9/1/00 9:39:19 AM ******/
CREATE procedure RQFutHdrProjLoad
@parm1 varchar(16), @parm2 varchar(2), @parm3 varchar(2)
as
select * from RQitemreqHdr where
Project = @parm1 and
status = 'SA' and
AppvLevReq >= @parm2 and
AppvLevobt < @parm3
ORDER BY ItemReqNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQFutHdrProjLoad] TO [MSDSL]
    AS [dbo];

