 Create Proc RegularPO_Cpnyid_PONbr
    @CpnyID varchar ( 10),
    @PONbr varchar(10)
as

Select * from PurchOrd
   Where CpnyID = @CpnyID
     and PONbr LIKE @PONbr
     and POType = 'OR'
     and Status IN ('P','O')
   Order by PONbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RegularPO_Cpnyid_PONbr] TO [MSDSL]
    AS [dbo];

