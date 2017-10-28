CREATE PROCEDURE WSPDocURL @parm1 smallint
AS
	SELECT	URL = i.rootSiteUrl + CASE i.docLibOrSite
									WHEN 'D' THEN i.docLibName
									ELSE i.subSiteNamePrefix
									END
	FROM	WSPInstance i, WSPDoc d
	WHERE	d.Instance = i.SLTypeID AND d.DocumentID = @parm1
