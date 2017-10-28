 

/****** Object:  View dbo.vp_10400_UpdateARCOGS_INTran    Script Date: 7/13/98 11:18:43 AM ******/
CREATE VIEW vp_10400_UpdateARCOGS_INTran As

    SELECT T.BatNbr,
           T.CpnyId,
           CurPer = (RIGHT(RTRIM(S.PerNbr), 2)),
           CurYr = (SUBSTRING(S.PerNbr, 1, 4)),
           T.Id,
           FiscYr = (SUBSTRING(T.PerPost, 1, 4)),
	   T.InvtMult,
           T.JrnlType,
           T.LineNbr,
           S.PerNbr,
           T.PerPost,
           T.RefNbr,
           T.SlsperId,
           T.TranAmt,
           W.UserAddress
           FROM INTran T, WrkRelease W, INSetup S
          Where T.BatNbr = W.BatNbr
            And T.TranType = 'CG'
           

 
