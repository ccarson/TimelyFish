Create Procedure UGrid2_POTran_PONBR_NOTVOUCHED @CpnyID varchar (10), @CuryID varchar (4), @VendID varchar(15),@PONbr varchar(10) As


Select '0',
		o.PONbr, isnull(d.lineref,' '),
		o.RcptNbr,o.lineref,
		o.TranType, o.RcptDate,
		o.InvtID,o.purchasetype, o.RcptQty,
		o.UnitDescr, o.curyUnitCost,
		o.CuryExtCost, isnull(i.Descr,' '),
		o.VendID, z.potype, o.vouchstage
  From potran o
	join POReceipt p on o.ponbr = p.ponbr
    left join purorddet d on o.ponbr = d.ponbr AND o.polineref = d.lineref
	left join inventory i on o.invtid = i.invtid
	Join Purchord z on o.ponbr = z.ponbr
  Where  
    p.Rlsed = 1 
	And o.CpnyID = @CpnyID
	and o.CuryID = @CuryID
	And o.trantype <> 'X'
    And o.VouchStage <> 'F' 
    And p.PONbr = @PONbr
	And o.VendID = @VendID
    Order By p.PONbr, p.RcptNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[UGrid2_POTran_PONBR_NOTVOUCHED] TO [MSDSL]
    AS [dbo];

