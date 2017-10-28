 Create Proc RegularPO_Cpnyid_VendID_PONbr
    @CpnyID varchar ( 10),
    @VendID varchar ( 15),
    @PONbr varchar(10)
as

Select * from PurchOrd
   Where CpnyID = @CpnyID
     and VendID = @VendID
     and PONbr LIKE @PONbr
     and POType = 'OR'
     and Status IN ('P','O')
   Order by PONbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RegularPO_Cpnyid_VendID_PONbr] TO [MSDSL]
    AS [dbo];

