 CREATE PROCEDURE SOHeader_OrdNbr_ASRReqEDD
	@parm1 varchar( 10 ),
	@parm2 varchar(15)
AS
	
	SELECT soheader.*
	FROM SOHeader join vs_asrreqedd on soheader.OrdNbr = vs_asrreqedd.OrdNbr 
	WHERE vs_asrreqedd.DocType = @Parm1 AND SOHeader.OrdNbr like @parm2 
	ORDER BY SOHeader.Ordnbr DESC
	
-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOHeader_OrdNbr_ASRReqEDD] TO [MSDSL]
    AS [dbo];

