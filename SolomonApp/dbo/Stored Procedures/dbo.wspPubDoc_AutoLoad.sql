CREATE PROCEDURE wspPubDoc_AutoLoad @parm1 varchar(60), @parm2 smallint
AS 
	SELECT ISNull(wp.Status, 1) 'lStatus', 
		wd.DocumentType, 
		ISNULL(wp.LibraryName, wd.DocumentType) 'DocumentName',
		ISNULL(wp.LibraryRootUrl, '') 'LibraryRootUrl',
		ISNULL(wp.LibrarySubsite, '') 'LibrarySubsite',
		wd.DocumentID
	FROM wspdoc wd
		LEFT OUTER JOIN wsppubdoclib wp
			ON wd.DocumentID = wp.DocumentID
			AND wd.Instance = wp.SLTypeID
			AND wp.SLObjID = @parm1
	WHERE wd.Instance = @parm2
	ORDER BY wd.documentID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[wspPubDoc_AutoLoad] TO [MSDSL]
    AS [dbo];

