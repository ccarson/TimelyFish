 CREATE Procedure IRBucket_CreateForPlan @FromDate smalldatetime, @CpnyID VarChar(10) AS
Set NoCount On
-- Clear any prior buckets
Delete from IRBucket
-- Go through, create an entry for each bucket
Declare @PerLength as smallint			-- Length of a single period
Declare @NextPerStartDate as smalldatetime	-- Date next period will start on
Select @NextPerStartDate = @FromDate
Declare csr_IRPeriodLength Cursor For Select PeriodLength from IRPeriodLength where CpnyId = @CpnyID order by LineNbr
Open csr_IRPeriodLength
Fetch Next from csr_IRPeriodLength Into @PerLength
While (@@Fetch_Status = 0)
Begin
Insert into IRBucket
	Select
			'01/01/1900' 'Crtd_Datetime',
			'IRLLCCA' 'Crtd_Prog',
			'IRLLCCA' 'Crtd_User',
		DateAdd(dd, @PerLength - 1, @NextPerStartDate) 'DateEnd',
		@NextPerStartDate 'DateStart',
		0.0 'DesiredQty',
			'01/01/1900' 'Lupd_Datetime',
			'IRLLCCA' 'Lupd_Prog',
			'IRLLCCA' 'Lupd_User',
		0.0 'QtyIn',
		0.0 'QtyInPast',
		0.0 'QtyOut',
		0.0 'QtyOutFcast',
		0.0 'QtyOutFirm',
		0.0 'QtyOutPast',
		0.0 'QtyEnd',
		0.0 'QtyStart',
			' ' 'S4Future01',
			' ' 'S4Future02',
			0.0 'S4Future03',
			0.0 'S4Future04',
			0.0 'S4Future05',
			0.0 'S4Future06',
			'01/01/1900' 'S4Future07',
			'01/01/1900' 'S4Future08',
			0 'S4Future09',
			0 'S4Future10',
			' ' 'S4Future11',
			' ' 'S4Future12',
			' ' 'User1',
			'01/01/1900' 'User10',
			' ' 'User2',
			' ' 'User3',
			' ' 'User4',
			0.0 'User5',
			0.0 'User6',
			' ' 'User7',
			' ' 'User8',
			'01/01/1900' 'User9',
			Null 'tstamp'

	-- Set next start date
	Select @NextPerStartDate = DateAdd(dd, @PerLength, @NextPerStartDate)
	Fetch Next from csr_IRPeriodLength Into @PerLength
End
DeAllocate csr_IRPeriodLength
Set NoCount Off



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRBucket_CreateForPlan] TO [MSDSL]
    AS [dbo];

