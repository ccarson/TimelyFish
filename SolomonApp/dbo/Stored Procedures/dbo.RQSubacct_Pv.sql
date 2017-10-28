 /****** Object:  Stored Procedure dbo.RQSubacct_Pv    Script Date: 9/4/2003 6:21:40 PM ******/

/****** Object:  Stored Procedure dbo.RQSubacct_Pv    Script Date: 7/5/2002 2:44:45 PM ******/

/****** Object:  Stored Procedure dbo.RQSubacct_Pv    Script Date: 1/7/2002 12:23:15 PM ******/

/****** Object:  Stored Procedure dbo.RQSubacct_Pv    Script Date: 1/2/01 9:39:40 AM ******/

/****** Object:  Stored Procedure dbo.RQSubacct_Pv    Script Date: 11/17/00 11:54:34 AM ******/

/****** Object:  Stored Procedure dbo.RQSubacct_Pv    Script Date: 10/25/00 8:32:20 AM ******/

/****** Object:  Stored Procedure dbo.RQSubacct_Pv    Script Date: 10/10/00 4:15:42 PM ******/

/****** Object:  Stored Procedure dbo.RQSubacct_Pv    Script Date: 10/2/00 4:58:18 PM ******/

/****** Object:  Stored Procedure dbo.RQSubacct_Pv    Script Date: 9/1/00 9:39:25 AM ******/

/****** Object:  Stored Procedure dbo.RQSubacct_Pv    Script Date: 03/31/2000 12:21:23 PM ******/

/****** Object:  Stored Procedure dbo.RQSubacct_Pv    Script Date: 2/2/00 12:18:21 PM ******/

/****** Object:  Stored Procedure dbo.RQSubacct_Pv    Script Date: 12/17/97 10:48:54 AM ******/
CREATE PROCEDURE RQSubacct_Pv
  @Parm1 varchar(25),  @Parm2 varchar(24) AS
SELECT * FROM SubAcct WHERE
  sub LIKE @Parm1 AND
  sub LIKE @Parm2 AND
  Active <> 0
  ORDER BY Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQSubacct_Pv] TO [MSDSL]
    AS [dbo];

