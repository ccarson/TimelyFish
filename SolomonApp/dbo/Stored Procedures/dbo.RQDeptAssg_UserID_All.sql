 /****** Object:  Stored Procedure dbo.RQDeptAssg_UserID_All    Script Date: 9/4/2003 6:21:19 PM ******/

/****** Object:  Stored Procedure dbo.RQDeptAssg_UserID_All    Script Date: 7/5/2002 2:44:39 PM ******/

/****** Object:  Stored Procedure dbo.RQDeptAssg_UserID_All    Script Date: 1/7/2002 12:23:09 PM ******/

/****** Object:  Stored Procedure dbo.RQDeptAssg_UserID_All    Script Date: 1/2/01 9:39:34 AM ******/

/****** Object:  Stored Procedure dbo.RQDeptAssg_UserID_All    Script Date: 11/17/00 11:54:29 AM ******/

/****** Object:  Stored Procedure dbo.RQDeptAssg_UserID_All    Script Date: 10/25/00 8:32:14 AM ******/

/****** Object:  Stored Procedure dbo.RQDeptAssg_UserID_All    Script Date: 10/10/00 4:15:37 PM ******/

/****** Object:  Stored Procedure dbo.RQDeptAssg_UserID_All    Script Date: 10/2/00 4:58:12 PM ******/

/****** Object:  Stored Procedure dbo.RQDeptAssg_UserID_All    Script Date: 9/1/00 9:39:19 AM ******/

/****** Object:  Stored Procedure dbo.RQDeptAssg_UserID_All    Script Date: 03/31/2000 12:21:20 PM ******/

/****** Object:  Stored Procedure dbo.RQDeptAssg_UserID_All    Script Date: 2/2/00 12:18:18 PM ******/

/****** Object:  Stored Procedure dbo.RQDeptAssg_UserID_All    Script Date: 12/17/97 10:48:59 AM ******/
CREATE Procedure RQDeptAssg_UserID_All @Parm1 Varchar(47), @Parm2 Varchar(10) As
Select RQDept.* From RQDept, RQDeptAssign WHERE RQDept.DeptID = RQDeptAssign.DeptID and RQDeptAssign.UserID = @Parm1
and RQDept.DeptID LIKE @Parm2 Order By RQDept.DeptID


