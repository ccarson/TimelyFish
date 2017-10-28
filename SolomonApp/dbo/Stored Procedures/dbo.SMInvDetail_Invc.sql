 CREATE PROCEDURE SMInvDetail_Invc
	@parm1 varchar(10),
	@parm2 varchar(10)
AS
	SELECT * FROM SMInvDetail
	WHERE 	Refnbr = @parm1 and DocumentID = @parm2
	ORDER BY refnbr, DocumentID, LineID


