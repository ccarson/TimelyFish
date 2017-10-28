 CREATE PROCEDURE RQItemReqHdr_UserAccess_CF @parm1 Varchar(10), @Parm2 Varchar(47), @Parm3 Varchar(10) AS
SELECT RQItemReqHdr.*, Vendor.Name FROM RQItemReqHdr LEFT OUTER JOIN vendor ON RQItemReqHdr.Vendid = Vendor.vendid
WHERE RequstnrDept Like @Parm1 and
Requstnr Like @Parm2 and
ItemReqNbr Like @parm3
ORDER BY ItemReqNbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQItemReqHdr_UserAccess_CF] TO [MSDSL]
    AS [dbo];

