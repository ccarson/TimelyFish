 /****** Object:  Stored Procedure dbo.ARDoc_LastBatSeq    Script Date: 4/7/98 12:30:33 PM ******/
Create proc ARDoc_LastBatSeq @parm1 varchar ( 10) As
 Select MAX(BatSeq) from ARDoc WHERE ARDoc.BatNbr = @parm1


