 CREATE PROCEDURE SOShipHeader_InvcNbr_ASRReqEDD
	@InvcNbr varchar(10)
AS
	SELECT SOShipHeader.*
	FROM SOShipHeader
	join vs_asrreqedd on SOShipHeader.InvcNbr = vs_asrreqedd.InvNbr and vs_asrreqedd.DocType = 'O1'
	WHERE 	InvcNbr LIKE @InvcNbr and InvcNbr <> ''
	ORDER BY InvcNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipHeader_InvcNbr_ASRReqEDD] TO [MSDSL]
    AS [dbo];

