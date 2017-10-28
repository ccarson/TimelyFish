 /****** Object:  Stored Procedure dbo.ARDoc_LastApplBatSeq    Script Date: 4/7/98 12:30:33 PM ******/
Create proc ARDoc_LastApplBatSeq @parm1 varchar ( 10) As
 Select MAX(BatSeq) from ARDoc WHERE ARDoc.ApplBatNbr = @parm1


