 Create Proc RegPO_Cpnyid_PONbr_CuryID
    @CpnyID varchar ( 10),
    @CuryID varchar (4),
    @PONbr varchar(10)
as

Select * from PurchOrd
   Where CpnyID = @CpnyID
     and CuryID = @CuryID
     and PONbr LIKE @PONbr
     and POType = 'OR'
     and Status IN ('P','O')
   Order by PONbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RegPO_Cpnyid_PONbr_CuryID] TO [MSDSL]
    AS [dbo];

