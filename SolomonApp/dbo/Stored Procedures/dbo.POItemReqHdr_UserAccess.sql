 /****** Object:  Stored Procedure dbo.POItemReqHdr_UserAccess    Script Date: 12/17/97 10:49:09 AM ******/
CREATE PROCEDURE POItemReqHdr_UserAccess @parm1 Varchar(10), @Parm2 Varchar(47), @Parm3 Varchar(10) AS
SELECT * FROM POItemReqHdr
WHERE RequstnrDept Like @Parm1 AND
Requstnr Like @Parm2 AND
ItemReqNbr Like @parm3
ORDER BY ItemReqNbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POItemReqHdr_UserAccess] TO [MSDSL]
    AS [dbo];

