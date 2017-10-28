 Create Proc RegPORet_CpnyID_VendID_PONbr
    @CpnyID varchar ( 10),
    @VendID varchar ( 15),
    @PONbr varchar(10)
as

Select * from PurchOrd
   Where CpnyID = @CpnyID
     and VendID = @VendID
     and PONbr LIKE @PONbr
     and POType = 'OR'
     and RcptStage IN ('F','P')
   Order by PONbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RegPORet_CpnyID_VendID_PONbr] TO [MSDSL]
    AS [dbo];

