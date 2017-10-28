 /****** Object:  Stored Procedure dbo.ARRev_Invbnbr    Script Date: 4/7/98 12:30:33 PM ******/
CREATE PROC ARRev_Invbnbr @parm1 varchar(10) AS
SELECT *
  FROM ARAdjust
 WHERE adjdrefnbr = @parm1
   AND AdjdDoctype IN ('IN','DM','FI','NC')
ORDER BY AdjdRefnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARRev_Invbnbr] TO [MSDSL]
    AS [dbo];

