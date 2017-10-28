CREATE PROCEDURE GetDocLibURL @parm1 smallint, @parm2 varchar(60)
AS
	SELECT
		CASE RTRIM(LibrarySubsite)
		WHEN '' THEN
			(RTRIM([LibraryRootURL]) + '/' + RTRIM([LibraryName]))
		ELSE
			(RTRIM([LibraryRootURL]) + '/' + RTRIM([LibrarySubsite]) + '/' + RTRIM([LibraryName]))
		END
	FROM [WSPPubDocLib] WHERE [DocumentID] = @parm1 AND [SLObjID] = @parm2
