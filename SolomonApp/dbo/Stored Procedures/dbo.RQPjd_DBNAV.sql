 /****** Object:  Stored Procedure dbo.RQPjd_DBNAV    Script Date: 9/4/2003 6:21:38 PM ******/

/****** Object:  Stored Procedure dbo.RQPjd_DBNAV    Script Date: 7/5/2002 2:44:42 PM ******/

/****** Object:  Stored Procedure dbo.RQPjd_DBNAV    Script Date: 1/7/2002 12:23:12 PM ******/

/****** Object:  Stored Procedure dbo.RQPjd_DBNAV    Script Date: 1/2/01 9:39:37 AM ******/

/****** Object:  Stored Procedure dbo.RQPjd_DBNAV    Script Date: 11/17/00 11:54:32 AM ******/

/****** Object:  Stored Procedure dbo.RQPjd_DBNAV    Script Date: 10/25/00 8:32:17 AM ******/

/****** Object:  Stored Procedure dbo.RQPjd_DBNAV    Script Date: 10/10/00 4:15:40 PM ******/

/****** Object:  Stored Procedure dbo.RQPjd_DBNAV    Script Date: 10/2/00 4:58:16 PM ******/

/****** Object:  Stored Procedure dbo.RQPjd_DBNAV    Script Date: 9/1/00 9:39:22 AM ******/

/****** Object:  Stored Procedure dbo.RQPjd_DBNAV    Script Date: 03/31/2000 12:21:22 PM ******/

/****** Object:  Stored Procedure dbo.RQPjd_DBNAV    Script Date: 2/2/00 12:18:19 PM ******/

/****** Object:  Stored Procedure dbo.RQPjd_DBNAV    Script Date: 12/17/97 10:49:05 AM ******/
CREATE PROCEDURE RQPjd_DBNAV @parm1 VarChar(10), @parm2 VarChar(47), @parm3 VarChar(47),
@parm4startdate SmallDateTime, @parm4enddate SmallDateTime as
Select * from RQPJdefer where Project like @parm1 and
UserId like @parm2 and
DeferUserID like @parm3 and
StartDate between @parm4startdate and @parm4enddate
Order by Project, userid, DeferUserID, startdate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQPjd_DBNAV] TO [MSDSL]
    AS [dbo];

