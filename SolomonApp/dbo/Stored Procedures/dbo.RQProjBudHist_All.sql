 /****** Object:  Stored Procedure dbo.RQProjBudHist_All    Script Date: 9/4/2003 6:21:38 PM ******/

/****** Object:  Stored Procedure dbo.RQProjBudHist_All    Script Date: 7/5/2002 2:44:43 PM ******/

/****** Object:  Stored Procedure dbo.RQProjBudHist_All    Script Date: 1/7/2002 12:23:14 PM ******/

/****** Object:  Stored Procedure dbo.RQProjBudHist_All    Script Date: 1/2/01 9:39:39 AM ******/

/****** Object:  Stored Procedure dbo.RQProjBudHist_All    Script Date: 11/17/00 11:54:32 AM ******/

/****** Object:  Stored Procedure dbo.RQProjBudHist_All    Script Date: 10/25/00 8:32:18 AM ******/

/****** Object:  Stored Procedure dbo.RQProjBudHist_All    Script Date: 10/10/00 4:15:41 PM ******/

/****** Object:  Stored Procedure dbo.RQProjBudHist_All    Script Date: 10/2/00 4:58:17 PM ******/
CREATE PROCEDURE RQProjBudHist_All @parm1 varchar(16), @parm2 varchar(32), @parm3 varchar(10), @parm4 varchar(16)
as
Select * from rqprojbudhist where

project = @parm1 and
Task = @parm2 and
Acct = @parm3 and
AcctCategory = @parm4
order by Project, Task, Acct, AcctCategory



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQProjBudHist_All] TO [MSDSL]
    AS [dbo];

