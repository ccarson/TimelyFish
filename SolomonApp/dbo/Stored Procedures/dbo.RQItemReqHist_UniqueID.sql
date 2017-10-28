 /****** Object:  Stored Procedure dbo.RQItemReqHist_UniqueID    Script Date: 9/4/2003 6:21:20 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReqHist_UniqueID    Script Date: 7/5/2002 2:44:40 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReqHist_UniqueID    Script Date: 1/7/2002 12:23:11 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReqHist_UniqueID    Script Date: 1/2/01 9:39:36 AM ******/

/****** Object:  Stored Procedure dbo.RQItemReqHist_UniqueID    Script Date: 11/17/00 11:54:30 AM ******/

/****** Object:  Stored Procedure dbo.RQItemReqHist_UniqueID    Script Date: 10/25/00 8:32:16 AM ******/

/****** Object:  Stored Procedure dbo.RQItemReqHist_UniqueID    Script Date: 10/10/00 4:15:38 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReqHist_UniqueID    Script Date: 10/2/00 4:58:14 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReqHist_UniqueID    Script Date: 9/1/00 9:39:20 AM ******/

/****** Object:  Stored Procedure dbo.RQItemReqHist_UniqueID    Script Date: 03/31/2000 12:21:21 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReqHist_UniqueID    Script Date: 2/2/00 12:18:19 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReqHist_UniqueID    Script Date: 12/17/97 10:48:33 AM ******/
CREATE PROCEDURE RQItemReqHist_UniqueID
@Parm1 Varchar(10), @Parm2 Varchar(17), @Parm3 Varchar(47), @Parm4Beg SmallDateTime, @Parm4End SmallDateTime, @Parm5 Varchar(10) AS
SELECT * FROM RQItemReqHist WHERE
ItemReqNBR = @Parm1 and
(UniqueID = @Parm2 or UniqueID = '0000') and
TranDate Between @Parm4Beg and @Parm4End and
TranTime LIKE @Parm5 and
UserID LIKE @Parm3
Order BY ItemReqNbr, UniqueID, TranDate DESC, TranTime DESC, UserID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQItemReqHist_UniqueID] TO [MSDSL]
    AS [dbo];

