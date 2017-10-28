 

CREATE VIEW vp_10400_UpdateARCOGS_ARTran As
    SELECT T.Id,
           T.ARLineId,
           T.RefNbr,
           ExtCost = Sum(T.TranAmt),
           W.UserAddress
           FROM INTran T, WrkRelease W
          Where T.TranType = 'CG'               
            And T.BatNbr = W.BatNbr
       GROUP BY W.UserAddress, T.Id, T.RefNbr, T.ARLineId
    

 
