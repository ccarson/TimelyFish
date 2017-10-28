 

--APPTABLE
--USETHISSYNTAX

/****** Last Modified by MDP on 12/7/98 Added Inital Creation ******/

CREATE VIEW vp_03400_PPV_Batch_Needed AS

    Select UserAddress=W.UserAddress,
           BatNbr=T.BatNbr,
           JrnlType=T.JrnlType, 
           PPVCount=Count(*) 
           From APTran T Join APTranDt D
                           On T.RefNbr = D.RefNbr
                           And T.LineRef = D.APLineRef
                         Join WrkRelease_PO W
                           On T.BatNbr = W.BatNbr
                           And T.JrnlType = W.Module
           Where d.CuryExtCostVar <> 0
           Group By W.UserAddress, T.BatNbr, T.JrnlType
           

 
