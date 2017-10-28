
CREATE PROCEDURE WS_ApproverOfPJLabDetN
@parm1 int
AS
	SELECT
		h.Approver,
		p.manager1,
		h.docnbr
	FROM
		PJLABHDR h
		INNER JOIN PJLABDET d
		ON h.docnbr = d.docnbr
		INNER JOIN PJPROJ p
		ON d.project = p.project
	WHERE
		d.NoteId = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_ApproverOfPJLabDetN] TO [MSDSL]
    AS [dbo];

