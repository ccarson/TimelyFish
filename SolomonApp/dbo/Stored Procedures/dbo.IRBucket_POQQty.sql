 Create Procedure IRBucket_POQQty @DatesGreaterThan smalldatetime, @DatesLessThan SmallDateTime, @PlannedOrdQty float As
-- Notes:  @RunningQOH should be < 0
--      :  @RunningQOH should be reduced by the Safety Stock Qty
Set NoCount On
Declare @NetQtyThisBucket Float
Declare @RunningQOH Float
if @PlannedOrdQty > 0.0
	Set @PlannedOrdQty = @PlannedOrdQty * -1
Set @RunningQOH = 0.0
Declare csr_ForBucket Insensitive Cursor For
	Select (QtyIn + QtyInPast - QtyOut - QtyOutPast) from IRBucket where DateStart > @DatesGreaterThan and DateStart < @DatesLessThan
Open csr_ForBucket
Fetch Next from csr_ForBucket into @NetQtyThisBucket
While (@@Fetch_Status = 0)
Begin
	If (@RunningQOH + @NetQtyThisBucket) < 0
	Begin
		Select @PlannedOrdQty = (Select @PlannedOrdQty + @NetQtyThisBucket + @RunningQOH)
		Set @RunningQOH = 0.0
	End Else
		Select @RunningQOH = (Select @RunningQOH + @NetQtyThisBucket)
	Fetch Next from csr_ForBucket into @NetQtyThisBucket
End
Deallocate csr_ForBucket
Set NoCount Off
Select (@PlannedOrdQty * (-1)) as POQtyToOrder



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRBucket_POQQty] TO [MSDSL]
    AS [dbo];

