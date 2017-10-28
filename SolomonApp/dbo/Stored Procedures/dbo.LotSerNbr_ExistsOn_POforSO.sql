 create proc LotSerNbr_ExistsOn_POforSO
	@PONbr     varchar(10),
	@LotSerNbr varchar(25),
	@OrdNbr    varchar(15),
	@CpnyID    varchar(10)
as

    SELECT v.PurchaseType
      FROM VP_PurchOrd_TiedTo_SalesOrd v 
     WHERE v.PONbr = @PONbr
       AND v.LotSerNbr = @LotSerNbr
       AND v.SOOrdNbr = @OrdNbr
       AND v.CpnyID = @CpnyID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LotSerNbr_ExistsOn_POforSO] TO [MSDSL]
    AS [dbo];

