 /****** Object:  Stored Procedure dbo.RQAutoReqNbr    Script Date: 9/4/2003 6:21:18 PM ******/

/****** Object:  Stored Procedure dbo.RQAutoReqNbr    Script Date: 7/5/2002 2:44:38 PM ******/

/****** Object:  Stored Procedure dbo.RQAutoReqNbr    Script Date: 1/7/2002 12:23:08 PM ******/

/****** Object:  Stored Procedure dbo.RQAutoReqNbr    Script Date: 1/2/01 9:39:33 AM ******/

/****** Object:  Stored Procedure dbo.RQAutoReqNbr    Script Date: 11/17/00 11:54:28 AM ******/

/****** Object:  Stored Procedure dbo.RQAutoReqNbr    Script Date: 10/25/00 8:32:13 AM ******/

/****** Object:  Stored Procedure dbo.RQAutoReqNbr    Script Date: 10/10/00 4:15:35 PM ******/

/****** Object:  Stored Procedure dbo.RQAutoReqNbr    Script Date: 10/2/00 4:58:11 PM ******/

/****** Object:  Stored Procedure dbo.RQAutoReqNbr    Script Date: 9/1/00 9:39:17 AM ******/

/****** Object:  Stored Procedure dbo.RQAutoReqNbr    Script Date: 03/31/2000 12:21:20 PM ******/

/****** Object:  Stored Procedure dbo.RQAutoReqNbr    Script Date: 2/2/00 12:18:18 PM ******/

/****** Object:  Stored Procedure dbo.RQAutoReqNbr    Script Date: 12/17/97 10:48:24 AM ******/
CREATE PROC RQAutoReqNbr As
SELECT LastPONbr FROM POSetup
ORDER BY SetupId


