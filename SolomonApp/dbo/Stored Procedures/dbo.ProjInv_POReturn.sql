
Create Procedure ProjInv_POReturn 
       @RcptNbr VarChar(15), 
       @LineRef VarChar(5)
AS   
 SELECT p.RcptNbr, p.LineRef, p.RcptNbrOrig, p.RcptLineRefOrig, p.PONbr, p.PurchaseType, p.POLineRef, p.InvtID, i.SrcNbr, i.SrcLineRef, i.SrcType, i.QtyRemainToIssue, p.ProjectID, p.TaskID
   FROM POTran p JOIN InvProjAlloc i
                   ON p.RcptNbrOrig = i.SrcNbr 
                  AND p.RcptLineRefOrig = i.SrcLineRef
                 AND i.SrcType = CASE WHEN p.PurchaseType = 'PS' THEN 'GSO'
                                      ELSE 'POR'
                                 END
  WHERE p.RcptNbr = @RcptNbr
    AND p.LineRef = @LineRef
    AND p.TranType = 'X' -- Return
    AND p.PurchaseType IN ('PI','PS')
    

GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_POReturn] TO [MSDSL]
    AS [dbo];

