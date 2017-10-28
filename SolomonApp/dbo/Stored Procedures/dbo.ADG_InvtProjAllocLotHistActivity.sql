create procedure ADG_InvtProjAllocLotHistActivity
 @CpnyID varchar(10),
 @SrcType varchar(3),  
 @SrcNbr varchar(15),  
 @LineRef varchar(5),
 @TranSrcType VarChar(3),
 @TranSrcLineRef VarChar(5),
 @TranSrcNbr VarChar(15)
AS  

SELECT h.*, CASE WHEN v.QtyRemainToIssue is null Then 0 Else v.QtyRemainToIssue End As QtyRemainToIssue
  FROM INPrjAllocLotHist h WITH (NOLOCK) LEFT OUTER JOIN InvProjAllocLot v WITH (NOLOCK)  
                                                 ON v.srclineref = h.srclineref
                                                AND v.srcnbr = h.srcnbr
                                                AND v.srctype = h.srctype
                                                AND v.LotSerNbr = h.LotSerNbr
                                                AND v.LotSerRef = h.LotSerRef
WHERE h.CpnyID = @CpnyID AND h.SrcType = @SrcType 
  AND h.SrcNbr = @SrcNbr AND h.SrcLineRef = @LineRef
  AND h.TranSrcType = @TranSrcType
  AND h.TranSrcLineRef = @TranSrcLineRef
  AND h.TranSrcNbr = @TranSrcNbr
ORDER BY h.RecordID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_InvtProjAllocLotHistActivity] TO [MSDSL]
    AS [dbo];

