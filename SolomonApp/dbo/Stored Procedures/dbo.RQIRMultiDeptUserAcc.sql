 /****** Object:  Stored Procedure dbo.RQIRMultiDeptUserAcc    Script Date: 9/4/2003 6:21:20 PM ******/

/****** Object:  Stored Procedure dbo.RQIRMultiDeptUserAcc    Script Date: 7/5/2002 2:44:40 PM ******/
CREATE PROCEDURE RQIRMultiDeptUserAcc @UserID varchar(47), @IRNbr varchar(10)  AS
SELECT  * FROM RQItemReqHdr
WHERE
RequstnrDept in (Select Deptid from RQDeptAssign where Userid like @UserID) and
ItemReqNbr Like @IRNbr
ORDER BY itemReqNbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQIRMultiDeptUserAcc] TO [MSDSL]
    AS [dbo];

