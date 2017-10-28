 CREATE PROCEDURE rqreqhdr_open_cury_PV @parm1 varchar(4), @parm2 varchar(10)  AS
SELECT Dept, Project, CpnyID, CuryID FROM RQReqHdr
WHERE  CuryID = @parm1 and
ReqNbr Like @parm2 and
Status in ('OP', 'SB')
ORDER BY ReqNbr DESC, ReqCntr DESC

