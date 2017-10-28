 CREATE Procedure IRInquiry_CreateForPlan @ComputerName VarChar(21), @CpnyID VarChar(10), @FromDate smalldatetime AS
Set NoCount On
-- Clear any prior buckets
Delete from IRInquiry
-- Go through, create an entry for each bucket
Declare @PerLength as smallint			-- Length of a single period
Declare @NextPerStartDate as smalldatetime	-- Date next period will start on
Select @NextPerStartDate = @FromDate
-- Add record for Past due
Insert into IRInquiry
	Select
		0.0 As 'BalBegin',
		0.0 As 'BalEnd',
			@ComputerName As 'ComputerName',
			@CpnyID As 'CpnyID',
			'01/01/1900' 'Crtd_Datetime',
			'IRLLCCA' 'Crtd_Prog',
			'IRLLCCA' 'Crtd_User',
		DateAdd(dd, -1, @NextPerStartDate) 'DateEnd',
		'01/01/1900' 'DateStart',
		0.0 'DesiredQty',
			' ' As 'InvtID',
			'01/01/1900' 'Lupd_Datetime',
			'IRLLCCA' 'Lupd_Prog',
			'IRLLCCA' 'Lupd_User',
		0.0 As 'QtyBalToFcast',
		0.0 As 'QtyDesireIn',
		0.0 As 'QtyEnd',
		0.0 As 'QtyIn',
		0.0 As 'QtyOutFcast',
		0.0 As 'QtyRequired',
		0.0 As 'QtyStart',
		0 As 'Revised',
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
			0.0 As 'SafetyStock',
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

Declare csr_IRPeriodLength Cursor For Select PeriodLength from IRPeriodLength where CpnyId = @CpnyID order by LineNbr
Open csr_IRPeriodLength
Fetch Next from csr_IRPeriodLength Into @PerLength
While (@@Fetch_Status = 0)
Begin
Insert into IRInquiry
	Select
		0.0 As 'BalBegin',
		0.0 As 'BalEnd',
			@ComputerName As 'ComputerName',
			@CpnyID As 'CpnyID',
			'01/01/1900' 'Crtd_Datetime',
			'IRLLCCA' 'Crtd_Prog',
			'IRLLCCA' 'Crtd_User',
		DateAdd(dd, @PerLength - 1, @NextPerStartDate) 'DateEnd',
		@NextPerStartDate 'DateStart',
		0.0 'DesiredQty',
			' ' As 'InvtID',
			'01/01/1900' 'Lupd_Datetime',
			'IRLLCCA' 'Lupd_Prog',
			'IRLLCCA' 'Lupd_User',
		0.0 As 'QtyBalToFcast',
		0.0 As 'QtyDesireIn',
		0.0 As 'QtyEnd',
		0.0 As 'QtyIn',
		0.0 As 'QtyOutFcast',
		0.0 As 'QtyRequired',
		0.0 As 'QtyStart',
		0 As 'Revised',
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
			0.0 As 'SafetyStock',
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
-- Now fill in all revised amounts
Insert into IRInquiry
	Select
		BalBegin,
		BalEnd,
			ComputerName,
			CpnyID,
			Crtd_Datetime,
			Crtd_Prog,
			Crtd_User,
		DateEnd,
		DateStart,
		DesiredQty,
			InvtID,
			Lupd_Datetime,
			Lupd_Prog,
			Lupd_User,
		QtyBalToFcast,
		QtyDesireIn,
		QtyEnd,
		QtyIn,
		QtyOutFcast,
		QtyRequired,
		QtyStart,
		1 As 'Revised',
			S4Future01,
			S4Future02,
			S4Future03,
			S4Future04,
			S4Future05,
			S4Future06,
			S4Future07,
			S4Future08,
			S4Future09,
			S4Future10,
			S4Future11,
			S4Future12,
			SafetyStock,
			User1,
			User10,
			User2,
			User3,
			User4,
			User5,
			User6,
			User7,
			User8,
			User9,
			Null 'tstamp'
		From IRInquiry B where B.ComputerName = ComputerName
Set NoCount Off



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRInquiry_CreateForPlan] TO [MSDSL]
    AS [dbo];

