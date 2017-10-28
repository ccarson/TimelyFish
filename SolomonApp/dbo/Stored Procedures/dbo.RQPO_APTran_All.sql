 /****** Object:  Stored Procedure dbo.RQPO_APTran_All    Script Date: 9/4/2003 6:21:38 PM ******/

/****** Object:  Stored Procedure dbo.RQPO_APTran_All    Script Date: 7/5/2002 2:44:42 PM ******/

/****** Object:  Stored Procedure dbo.RQPO_APTran_All    Script Date: 1/7/2002 12:23:13 PM ******/

/****** Object:  Stored Procedure dbo.RQPO_APTran_All    Script Date: 1/2/01 9:39:38 AM ******/

/****** Object:  Stored Procedure dbo.RQPO_APTran_All    Script Date: 11/17/00 11:54:32 AM ******/
CREATE PROCEDURE RQPO_APTran_All  @parm1 varchar(10), @parm2 varchar(5)
 AS
Select * from APTran where
PONbr = @parm1 and
POLineRef = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQPO_APTran_All] TO [MSDSL]
    AS [dbo];

