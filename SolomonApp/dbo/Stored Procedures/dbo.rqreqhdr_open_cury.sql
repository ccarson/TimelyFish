 CREATE PROCEDURE rqreqhdr_open_cury @parm1 varchar(4), @parm2 varchar(10)  AS
SELECT * FROM RQReqHdr
WHERE  CuryID = @parm1 and
ReqNbr Like @parm2 and
Status in ('OP', 'SB')
ORDER BY ReqNbr DESC, ReqCntr DESC

