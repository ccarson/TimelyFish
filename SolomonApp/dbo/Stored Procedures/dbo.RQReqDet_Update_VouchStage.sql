 /****** Object:  Stored Procedure dbo.RQReqDet_Update_VouchStage    Script Date: 9/4/2003 6:21:39 PM ******/

/****** Object:  Stored Procedure dbo.RQReqDet_Update_VouchStage    Script Date: 7/5/2002 2:44:44 PM ******/

/****** Object:  Stored Procedure dbo.RQReqDet_Update_VouchStage    Script Date: 1/7/2002 12:23:14 PM ******/

/****** Object:  Stored Procedure dbo.RQReqDet_Update_VouchStage    Script Date: 1/2/01 9:39:39 AM ******/

/****** Object:  Stored Procedure dbo.RQReqDet_Update_VouchStage    Script Date: 11/17/00 11:54:33 AM ******/
CREATE PROCEDURE RQReqDet_Update_VouchStage @parm1 varchar(10), @parm2 varchar(4), @parm3 varchar(1)  AS

Update RQReqDet
set Vouchstage = @parm3
where
ReqNbr = @parm1 and
SeqNbr =  @parm2

