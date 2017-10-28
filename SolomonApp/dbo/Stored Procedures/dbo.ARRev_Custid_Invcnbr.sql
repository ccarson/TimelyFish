 /****** Object:  Stored Procedure dbo.ARRev_Custid_Invcnbr    Script Date: 4/7/98 12:30:33 PM ******/
CREATE PROC ARRev_Custid_Invcnbr @parm1 varchar(15), @parm2 varchar(10) as
SELECT *
  FROM ARAdjust
 WHERE CustID = @parm1
   AND adjdrefnbr = @parm2
   AND AdjdDoctype IN ('IN','DM','FI','NC')
ORDER BY AdjdDoctype



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARRev_Custid_Invcnbr] TO [MSDSL]
    AS [dbo];

