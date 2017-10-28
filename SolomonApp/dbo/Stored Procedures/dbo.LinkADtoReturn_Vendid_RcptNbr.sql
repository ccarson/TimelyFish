 Create Procedure LinkADtoReturn_Vendid_RcptNbr @CpnyID varchar (10), @CuryID varchar (4), @VendID varchar(15),@RcptNbr varchar(10) As


Select '0',
		o.PONbr, convert(char(5), ''),
		o.RcptNbr,o.lineref,
		o.TranType, o.RcptDate,
		o.InvtID, o.purchasetype, o.RcptQty,
		o.UnitDescr, o.curyUnitCost,
		o.CuryExtCost, isnull(i.Descr, ' '),
		o.VendID, convert(char(2), ''),o.vouchstage
  From potran o
	join POReceipt p on o.RcptNbr = p.RcptNbr
	left join inventory i on o.invtid = i.invtid
  Where  
    p.Rlsed = 1 
	And o.CpnyID = @CpnyID
	and o.CuryID = @CuryID
	And o.trantype = 'X'
    And o.VouchStage <> 'F' 
	And p.VendID LIKE @VendID
    And p.RcptNbr LIKE @RcptNbr 
    Order By p.VendID, p.RcptNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LinkADtoReturn_Vendid_RcptNbr] TO [MSDSL]
    AS [dbo];

