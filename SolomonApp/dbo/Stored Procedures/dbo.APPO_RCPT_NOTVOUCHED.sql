Create Procedure APPO_RCPT_NOTVOUCHED @CpnyID varchar (10), @CuryID varchar (4), @VendID varchar(15),@RcptNbr varchar(10),@PONbr varchar(10) As


 Select '0',
		o.PONbr, isnull(d.lineref, ' '),
		o.RcptNbr,o.lineref,
		o.TranType, o.RcptDate,
		o.InvtID,o.purchasetype, o.RcptQty,
		o.UnitDescr, o.curyUnitCost,
		o.CuryExtCost, isnull(i.Descr, ' '),
		o.VendID, z.potype, o.vouchstage
	 from POTran o
	join POReceipt p on o.ponbr = p.ponbr AND o.rcptnbr = p.rcptnbr
    left join purorddet d on o.ponbr = d.ponbr AND o.polineref = d.lineref
	left join inventory i on o.invtid = i.invtid
	Join Purchord z on o.ponbr = z.ponbr
where (o.RcptNbr = @RcptNbr or @RcptNbr = '%')
	And (o.ponbr = @PONbr or @PONbr = '%')
	And o.CpnyID = @CpnyID
	and o.CuryID = @CuryID
	And o.VendID = @VendID
    and o.VouchStage <> 'F'
	and not exists(select 'x' from aptran where
		rcptnbr = @RcptNbr and
		(ponbr = @PONbr or @PONbr='%') and
		APTran.RcptLineRef = o.LineRef)
            Order by o.PONbr,o.Rcptnbr 
