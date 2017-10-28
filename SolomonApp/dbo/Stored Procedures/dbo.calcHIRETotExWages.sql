
Create Procedure calcHIRETotExWages
	@Employee as char(10),
	@Quarter as char(2),
	@Year as char(4),
	@Cpny as char(10)
as

Declare @ChkNbr as Char(10),
		@EmpId as Char(10),
		@BatNbr as Char(10),
		@selectSum as Float,
		@returnTotal as Float
		
DECLARE csrHirePRDoc CURSOR FOR 
	Select ChkNbr, EmpId, BatNbr
	From PRDoc
	Where EmpId = @Employee
		and CalQtr = @Quarter
		and CalYr = @Year
		and Rlsed = 1
		and CpnyID = @Cpny
		AND hireact = 1

OPEN csrHirePRDoc;

Select @returnTotal = -1;

FETCH NEXT FROM csrHirePRDoc 
INTO @ChkNbr, @EmpId, @BatNbr;

WHILE @@FETCH_STATUS = 0
BEGIN

	Select @selectSum = ISNULL(SUM(CASE Prt.TranType
						WHEN 'VC' THEN (-1 * Prt.RptEarnSubjDed)
						ELSE  Prt.RptEarnSubjDed
						END), 0)
	From PRTran Prt
		Inner Join Deduction Ded
			on Prt.CalYr = Ded.CalYr
			and Prt.EarnDedId = Ded.DedId
	Where Ded.EmpleeDed = '1'
		and Ded.DedType = 'I'
		and Ded.BoxNbr <> '6'
		and Prt.RefNbr = @ChkNbr
		and Prt.EmpId = @EmpId
		and Prt.BatNbr = @BatNbr
		and Prt.Type_ = 'DW'
		and Prt.CpnyID = @Cpny
		
	Select @returnTotal = @returnTotal + @selectSum

	FETCH NEXT FROM csrHirePRDoc
	INTO @ChkNbr, @EmpId, @BatNbr;
END
CLOSE csrHirePRDoc;
DEALLOCATE csrHirePRDoc;

If @returnTotal <> -1
	Select @returnTotal = @returnTotal + 1

Select @returnTotal

