 /****** Object:  Stored Procedure dbo.RQDeptAssgn_Dept_User_PV    Script Date: 9/4/2003 6:21:19 PM ******/

/****** Object:  Stored Procedure dbo.RQDeptAssgn_Dept_User_PV    Script Date: 7/5/2002 2:44:39 PM ******/

/****** Object:  Stored Procedure dbo.RQDeptAssgn_Dept_User_PV    Script Date: 1/7/2002 12:23:09 PM ******/

/****** Object:  Stored Procedure dbo.RQDeptAssgn_Dept_User_PV    Script Date: 1/2/01 9:39:35 AM ******/

/****** Object:  Stored Procedure dbo.RQDeptAssgn_Dept_User_PV    Script Date: 11/17/00 11:54:29 AM ******/
CREATE Procedure RQDeptAssgn_Dept_User_PV @Parm1 Varchar(10), @parm2 Varchar(47) as
Select * from RQDeptAssign  where DeptID  = @parm1 and UserID = @parm2
order by DeptID, UserID


