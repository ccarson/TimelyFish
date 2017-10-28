 Create Procedure LinkVOtoReceipt_RcptNbr @CpnyID varchar (10), @CuryID varchar (4), @VendID varchar(15),@RcptNbr varchar(10) As


Select '0',
		o.PONbr, isnull(d.lineref,' '),
		o.RcptNbr,o.lineref,
		o.TranType, o.RcptDate,
		o.InvtID, o.purchasetype, o.RcptQty,
		o.UnitDescr, o.curyUnitCost,
		o.CuryExtCost, isnull(i.Descr, ' '),
		o.VendID,z.potype, o.vouchstage
  From potran o
	join POReceipt p on o.ponbr = p.ponbr and o.rcptnbr = p.rcptnbr
	join Purchord z on o.ponbr = z.ponbr
    left join purorddet d on o.ponbr = d.ponbr AND o.polineref = d.lineref
	left join inventory i on o.invtid = i.invtid
  Where  
    p.Rlsed = 1 
	And o.CpnyID = @CpnyID
	and o.CuryID = @CuryID
	And o.trantype <> 'X'
    And o.VouchStage <> 'F' 
	AND o.PurchaseType in ('GI','GP','GS','GN','PS','PI','MI','FR')
	And p.VendID LIKE @VendID
    And p.RcptNbr LIKE @RcptNbr
	AND not exists(select 'x' from aptran where
		rcptnbr = @RcptNbr and
		(ponbr = p.PONbr or p.ponbr='%') and
		APTran.RcptLineRef = o.LineRef and
		aptran.rlsed = 0) 
    Order By p.VendID, p.RcptNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LinkVOtoReceipt_RcptNbr] TO [MSDSL]
    AS [dbo];

