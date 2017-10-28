 CREATE PROCEDURE RQIRMultiDeptUserAcc_CF @UserID varchar(47), @IRNbr varchar(10)  AS

SELECT RQItemReqHdr.*, Vendor.Name FROM RQItemReqHdr LEFT OUTER JOIN vendor ON RQItemReqHdr.Vendid = Vendor.vendid
WHERE
RequstnrDept in (Select Deptid from RQDeptAssign where Userid like @UserID) and
ItemReqNbr Like @IRNbr
ORDER BY itemReqNbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQIRMultiDeptUserAcc_CF] TO [MSDSL]
    AS [dbo];

