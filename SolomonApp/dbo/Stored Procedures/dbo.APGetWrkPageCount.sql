 /********* Object:  Stored Procedure dbo.APGetWrkPageCount   Script Date:  10/20/98 4:27pm *****/
CREATE PROCEDURE APGetWrkPageCount
@parm1 varchar(15), @parm2 varchar(1), @parm3 varchar(10)
-- parm1 is vendid, parm2 is the option
AS
IF (@parm2 = 'A') -- All documents
        SELECT COUNT(*) FROM APDoc
        WHERE VendId = @parm1 AND CpnyID LIKE @parm3 AND DocClass = 'N' AND Rlsed = 1
IF (@parm2 = 'O') -- Open documents
        SELECT COUNT(*) FROM APDoc
        WHERE VendId = @parm1 AND CpnyID LIKE @parm3 AND DocClass = 'N' AND Rlsed = 1 AND OpenDoc = 1
IF (@parm2 = 'C') -- Current and open documents
        SELECT COUNT(*) FROM APDoc
        WHERE VendId = @parm1 AND CpnyID LIKE @parm3 AND DocClass = 'N' AND Rlsed = 1 AND (OpenDoc = 1 OR CurrentNbr = 1)


