 /****** Object:  Stored Procedure dbo.RQLoadDept_Dept_User    Script Date: 9/4/2003 6:21:22 PM ******/

/****** Object:  Stored Procedure dbo.RQLoadDept_Dept_User    Script Date: 7/5/2002 2:44:41 PM ******/

/****** Object:  Stored Procedure dbo.RQLoadDept_Dept_User    Script Date: 1/7/2002 12:23:11 PM ******/

/****** Object:  Stored Procedure dbo.RQLoadDept_Dept_User    Script Date: 1/2/01 9:39:36 AM ******/

/****** Object:  Stored Procedure dbo.RQLoadDept_Dept_User    Script Date: 11/17/00 11:54:30 AM ******/

/****** Object:  Stored Procedure dbo.RQLoadDept_Dept_User    Script Date: 10/25/00 8:32:16 AM ******/

/****** Object:  Stored Procedure dbo.RQLoadDept_Dept_User    Script Date: 10/10/00 4:15:38 PM ******/

/****** Object:  Stored Procedure dbo.RQLoadDept_Dept_User    Script Date: 10/2/00 4:58:14 PM ******/

/****** Object:  Stored Procedure dbo.RQLoadDept_Dept_User    Script Date: 9/1/00 9:39:21 AM ******/

create procedure RQLoadDept_Dept_User
@parm1 varchar(10), @parm2 varchar(2), @parm3 varchar(47)
as
select * from RQDeptAuth where
DeptID = @parm1 And
DocType = @parm2 and
UserId = @parm3
ORDER BY DeptID, DocType, RequestType, Budgeted, Authority, UserID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQLoadDept_Dept_User] TO [MSDSL]
    AS [dbo];

