 /****** Object:  Stored Procedure dbo.RQDad_DBNAV    Script Date: 9/4/2003 6:21:19 PM ******/

/****** Object:  Stored Procedure dbo.RQDad_DBNAV    Script Date: 7/5/2002 2:44:38 PM ******/

/****** Object:  Stored Procedure dbo.RQDad_DBNAV    Script Date: 1/7/2002 12:23:09 PM ******/

/****** Object:  Stored Procedure dbo.RQDad_DBNAV    Script Date: 1/2/01 9:39:34 AM ******/

/****** Object:  Stored Procedure dbo.RQDad_DBNAV    Script Date: 11/17/00 11:54:29 AM ******/

/****** Object:  Stored Procedure dbo.RQDad_DBNAV    Script Date: 10/25/00 8:32:14 AM ******/

/****** Object:  Stored Procedure dbo.RQDad_DBNAV    Script Date: 10/10/00 4:15:36 PM ******/

/****** Object:  Stored Procedure dbo.RQDad_DBNAV    Script Date: 10/2/00 4:58:12 PM ******/

/****** Object:  Stored Procedure dbo.RQDad_DBNAV    Script Date: 9/1/00 9:39:18 AM ******/

/****** Object:  Stored Procedure dbo.RQDad_DBNAV    Script Date: 03/31/2000 12:21:20 PM ******/

/****** Object:  Stored Procedure dbo.RQDad_DBNAV    Script Date: 2/2/00 12:18:18 PM ******/

/****** Object:  Stored Procedure dbo.RQDad_DBNAV    Script Date: 12/17/97 10:48:58 AM ******/
CREATE PROCEDURE RQDad_DBNAV @parm1 VarChar(10), @parm2 VarChar(47), @parm3 VarChar(47),
@parm4startdate SmallDateTime, @parm4enddate SmallDateTime as
Select * from RQDAdefer where Deptid like @parm1 and
UserId like @parm2 and
DeferUserID like @parm3 and
StartDate between @parm4startdate and @parm4enddate
Order by DeptId,userid,DeferUserID, startdate


