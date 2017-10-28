create procedure ADG_InvtProjAllocLotHist
 @CpnyID varchar(10),
 @SrcType varchar(3),  
 @SrcNbr varchar(15),  
 @LineRef varchar(5)
AS  

SELECT h.*, CASE WHEN v.QtyRemainToIssue is null Then 0 Else v.QtyRemainToIssue End As QtyRemainToIssue
  FROM INPrjAllocLotHist h WITH (NOLOCK) LEFT OUTER JOIN InvProjAllocLot v WITH (NOLOCK)  
                                                 ON v.srclineref = h.srclineref
                                                AND v.srcnbr = h.srcnbr
                                                AND v.srctype = h.srctype
                                                AND v.LotSerNbr = h.LotSerNbr
                                                AND v.LotSerRef = h.LotSerRef
WHERE h.CpnyID = @CpnyID And h.SrcType = @SrcType And h.SrcNbr = @SrcNbr And h.SrcLineRef = @LineRef AND h.TranSrcType = 'INT'
ORDER BY h.RecordID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_InvtProjAllocLotHist] TO [MSDSL]
    AS [dbo];

