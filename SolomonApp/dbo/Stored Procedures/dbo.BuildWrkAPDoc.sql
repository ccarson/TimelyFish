 /********* Object:  Stored Procedure dbo.BuildWrkAPDoc  Script Date:  10/20/98 4:27pm  ******/
/** Added Company support DCR 10/23/98 **/
CREATE PROCEDURE BuildWrkAPDoc
@parm1 varchar(15), @parm2 int, @parm3 int, @parm4 varchar(1), @parm5 int, @parm6 varchar(10)
-- parm1 is vendid, parm2 the page requested (1+), parm3 is accessnbr
-- parm4 is the option, parm5 is the number of records per page
-- parm6 is companyid
AS
BEGIN
-- set nocount to prevent return to app on each fetch
SET NOCOUNT ON
-- set number of records per page
-- DECLARE @recsperpage int
-- SELECT @recsperpage = 200

DELETE FROM WrkAPDoc WHERE AccessNbr = @parm3

-- declarations for cursor
DECLARE @refnbr varchar(10), @doctype varchar(2)

-- count number of records to skip (presumably already seen by app)
DECLARE @skip int, @counter int
SELECT @skip = (@parm2 - 1) * @parm5
SELECT @counter = 0

-- declare and open cursor
IF (@parm4 = 'A') -- All documents
DECLARE ApDocs_Cursor CURSOR STATIC FOR
	SELECT RefNbr, DocType FROM APDoc
	WHERE VendId = @parm1 AND CpnyID LIKE @parm6 AND DocClass = 'N' AND Rlsed = 1
	ORDER BY BatNbr, RefNbr
IF (@parm4 = 'O') -- Open documents
DECLARE ApDocs_Cursor CURSOR STATIC FOR
	SELECT RefNbr, DocType FROM APDoc
	WHERE VendId = @parm1 AND CpnyID LIKE @parm6 AND DocClass = 'N' AND Rlsed = 1 AND OpenDoc = 1
	ORDER BY BatNbr, RefNbr
IF (@parm4 = 'C') -- Current and open documents
DECLARE ApDocs_Cursor CURSOR STATIC FOR
	SELECT RefNbr, DocType FROM APDoc
	WHERE VendId = @parm1 AND CpnyID LIKE @parm6 AND DocClass = 'N' AND Rlsed = 1 AND (OpenDoc = 1 OR CurrentNbr = 1)
	ORDER BY BatNbr, RefNbr

OPEN ApDocs_Cursor

-- scroll through list
FETCH ApDocs_Cursor INTO @refnbr, @doctype
WHILE (@@fetch_status <> -1)
BEGIN
	IF (@@fetch_status <> -2)
	BEGIN
		-- fetched valid record, add to document list if skip not exceeded
		-- if retrieved enough documents, exit loop
		SELECT @counter = @counter + 1
		IF (@counter > @skip + @parm5)
			BREAK
		IF (@counter > @skip)
			INSERT INTO WrkAPDoc (AccessNbr, DocType, RefNbr)
			VALUES (@parm3, @doctype, @refnbr)
	END
	FETCH ApDocs_Cursor INTO @refnbr, @doctype
END
CLOSE ApDocs_Cursor
DEALLOCATE ApDocs_Cursor
END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BuildWrkAPDoc] TO [MSDSL]
    AS [dbo];

