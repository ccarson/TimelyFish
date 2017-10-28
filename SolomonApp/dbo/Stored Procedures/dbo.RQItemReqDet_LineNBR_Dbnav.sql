 /****** Object:  Stored Procedure dbo.RQItemReqDet_LineNBR_Dbnav    Script Date: 9/4/2003 6:21:20 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReqDet_LineNBR_Dbnav    Script Date: 7/5/2002 2:44:40 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReqDet_LineNBR_Dbnav    Script Date: 1/7/2002 12:23:11 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReqDet_LineNBR_Dbnav    Script Date: 1/2/01 9:39:36 AM ******/

/****** Object:  Stored Procedure dbo.RQItemReqDet_LineNBR_Dbnav    Script Date: 11/17/00 11:54:30 AM ******/

/****** Object:  Stored Procedure dbo.RQItemReqDet_LineNBR_Dbnav    Script Date: 10/25/00 8:32:16 AM ******/

/****** Object:  Stored Procedure dbo.RQItemReqDet_LineNBR_Dbnav    Script Date: 10/10/00 4:15:38 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReqDet_LineNBR_Dbnav    Script Date: 10/2/00 4:58:14 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReqDet_LineNBR_Dbnav    Script Date: 9/1/00 9:39:20 AM ******/

/****** Object:  Stored Procedure dbo.RQItemReqDet_LineNBR_Dbnav    Script Date: 03/31/2000 12:21:21 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReqDet_LineNBR_Dbnav    Script Date: 2/2/00 12:18:19 PM ******/

/****** Object:  Stored Procedure dbo.RQItemReqDet_LineNBR_Dbnav    Script Date: 12/17/97 10:48:31 AM ******/
Create Procedure RQItemReqDet_LineNBR_Dbnav
@Parm1 Varchar(10), @Parm2Min SmallInt, @Parm2Max SmallInt as
Select * from RQItemReqDet  where ItemReqNbr = @Parm1
and LineNbr BETWEEN @Parm2Min and @Parm2Max
Order By ItemReqNbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQItemReqDet_LineNBR_Dbnav] TO [MSDSL]
    AS [dbo];

