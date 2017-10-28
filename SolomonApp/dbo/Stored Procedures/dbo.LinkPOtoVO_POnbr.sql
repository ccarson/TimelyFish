 Create Procedure LinkPOtoVO_POnbr @VendID varchar(15), @PONbr varchar (10),@CuryID varchar (4) As

select      '0',
            PURORDDET.PONbr, PURORDDET.LineRef,
            isnull(potran.rcptnbr, ' '),isnull(potran.lineref,' '),
			isnull(potran.trantype,' '),PURORDDET.ReqdDate,
            PURORDDET.InvtID, PURORDDET.PurchaseType,
			PURORDDET.QtyOrd,PURORDDET.PurchUnit,
			PURORDDET.UnitCost,PURORDDET.CuryExtCost,
            ISNULL(inventory.Descr, ' '),
			PURCHORD.VendID, PURCHORD.POType, PurOrdDet.vouchstage
from purorddet
left join inventory on purorddet.invtid = inventory.invtid
left join potran on purorddet.ponbr = potran.ponbr AND purorddet.lineref = potran.polineref
join purchord on purorddet.PONbr = purchord.PONbr 
	where purordDet.PONbr LIKE @PONbr
		AND purchord.VendId LIKE @VendID
	  AND PurchOrd.POtype IN ('OR', 'DP') 
      AND PurchOrd.Status IN ('M', 'O', 'P')
	  AND purchOrd.VouchStage IN ('N', 'P')
	  AND purorddet.VouchStage IN ('N', 'P')
	  AND not exists(select 'x' from aptran where
		aptran.ponbr = @PONbr and
		APTran.POLineRef = PurOrdDet.LineRef and
		aptran.rlsed = 0)
	Order By purorddet.PONbr, purorddet.LineNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[LinkPOtoVO_POnbr] TO [MSDSL]
    AS [dbo];

