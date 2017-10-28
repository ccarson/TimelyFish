
CREATE PROCEDURE WS_ApproverOfPJExpDetN
@parm1 int
AS
	SELECT
		h.Approver,
		p.manager1,
		h.docnbr
	FROM
		PJEXPHDR h
		INNER JOIN PJEXPDET d
		ON h.docnbr = d.docnbr
		INNER JOIN PJPROJ p
		ON d.project = p.project
	WHERE
		d.NoteId = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_ApproverOfPJExpDetN] TO [MSDSL]
    AS [dbo];

