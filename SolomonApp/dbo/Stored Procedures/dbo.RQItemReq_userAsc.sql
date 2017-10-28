 /****** Object:  Stored Procedure dbo.RQItemReq_userAsc    Script Date: 9/4/2003 6:21:21 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReq_userAsc    Script Date: 7/5/2002 2:44:40 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReq_userAsc    Script Date: 1/7/2002 12:23:10 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReq_userAsc    Script Date: 1/2/01 9:39:36 AM ******/

/****** Object:  Stored Procedure dbo.RQItemReq_userAsc    Script Date: 11/17/00 11:54:30 AM ******/

/****** Object:  Stored Procedure dbo.RQItemReq_userAsc    Script Date: 10/25/00 8:32:16 AM ******/

/****** Object:  Stored Procedure dbo.RQItemReq_userAsc    Script Date: 10/10/00 4:15:38 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReq_userAsc    Script Date: 10/2/00 4:58:14 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReq_userAsc    Script Date: 9/1/00 9:39:20 AM ******/
CREATE PROCEDURE RQItemReq_userAsc
@parm1 varchar(10), @parm2 varchar(47), @parm3 varchar(10) AS
SELECT * FROM RQItemReqHdr
WHERE RequstnrDept Like @Parm1 and
Requstnr Like @Parm2 and
ItemReqNbr Like @parm3
ORDER BY itemReqNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQItemReq_userAsc] TO [MSDSL]
    AS [dbo];

