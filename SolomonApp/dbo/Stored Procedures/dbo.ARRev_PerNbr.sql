﻿ /****** Object:  Stored Procedure dbo.ARRev_PerNbr    Script Date: 4/7/98 12:30:33 PM ******/
CREATE PROC ARRev_PerNbr @parm1 varchar(10), @parm2 varchar(6), @parm3 varchar(6) AS
SELECT *
  FROM ARDoc
 WHERE CpnyId = @parm1
   AND PerPost  >= @parm2
   AND PerPost  <= @parm3
   AND Rlsed = 1
   AND Doctype IN ('PA','PP','CM','SB')
ORDER BY CustID, Refnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARRev_PerNbr] TO [MSDSL]
    AS [dbo];

