 /****** Object:  Stored Procedure dbo.POReqHdr_Blkt_UserAccess    Script Date: 12/17/97 10:48:47 AM ******/
CREATE PROCEDURE POReqHdr_Blkt_UserAccess @parm1 Varchar(10), @Parm2 Varchar(47), @Parm3 Varchar(10), @Parm4 Varchar(10) AS
SELECT * FROM POReqHdr
WHERE RequstnrDept Like @Parm1 and
Requstnr Like @Parm2 and
CpnyID = @Parm3 and
ReqNbr Like @parm4
AND ((POType = 'BL' AND Status = 'PO') OR (POType = 'ST' AND Status = 'OP'))
ORDER BY ReqNbr DESC, ReqCntr DESC


