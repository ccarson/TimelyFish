 CREATE PROCEDURE rqreqhdr_open @parm1 varchar(10) AS
SELECT * FROM RQReqHdr
WHERE ReqNbr Like @parm1
and Status in ('OP', 'SB')
ORDER BY ReqNbr DESC, ReqCntr DESC

