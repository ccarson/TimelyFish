 /****** Object:  Stored Procedure dbo.POReqHdr_Dbnav    Script Date: 12/17/97 10:48:45 AM ******/
CREATE PROCEDURE POReqHdr_Dbnav @parm1 Varchar(10), @parm2 Varchar(2), @parm3 Varchar(2) AS
SELECT * FROM POReqHdr
WHERE ReqNbr Like @parm1
 AND ReqCntr Like @parm2
 AND Status Like @parm3
ORDER BY Reqnbr DESC, ReqCntr DESC


