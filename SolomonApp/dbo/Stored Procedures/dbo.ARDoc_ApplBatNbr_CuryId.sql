 /****** Object:  Stored Procedure dbo.ARDoc_ApplBatNbr_CuryId    Script Date: 4/7/98 12:30:32 PM ******/
Create proc ARDoc_ApplBatNbr_CuryId @parm1 varchar ( 10), @parm2 varchar ( 4) As
 Select * from ARDoc WHERE ARDoc.ApplBatNbr = @parm1
 and ARDoc.CuryId like @parm2
 Order By ApplBatNbr, CuryId, ApplBatSeq


