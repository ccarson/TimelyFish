
Create Function GetCalendarEndDateOfGLPeriod (@period char(6))
Returns smalldatetime
As
Begin
  Declare @periodList table (period smallint, md char(4), y char(4))
  Declare @i smallint, @nbrPer smallint, @begFiscalYr smallint, @year smallint, @febPeriod smallint
  Declare @leapYear bit

  -- Create record for each possible period in a memory table
  Select @i = 1, @nbrper = nbrper, @begFiscalYr = BegFiscalYr
    From GLSetup
  While @i <= @nbrPer
  Begin
    Insert Into @periodList
      Select @i period,
             Case @i When  1 Then FiscalPerEnd00  When  2 Then FiscalPerEnd01  When  3 Then FiscalPerEnd02
                     When  4 Then FiscalPerEnd03  When  5 Then FiscalPerEnd04  When  6 Then FiscalPerEnd05
                     When  7 Then FiscalPerEnd06  When  8 Then FiscalPerEnd07  When  9 Then FiscalPerEnd08
                     When 10 Then FiscalPerEnd09  When 11 Then FiscalPerEnd10  When 12 Then FiscalPerEnd11
                     Else FiscalPerEnd12 End md,
             SPACE(0) y
        From GLSetup
    Select @i = @i + 1
  End

  -- Set the calendar year (y) that belongs to the month/day (md)
  -- using the fiscal period with month/day (md) that is the latest month in the calendar year
  Set @year = CONVERT(smallint, LEFT(@period, 4))
  Update @periodList Set y = CASE WHEN period <= (Select period From @periodList Where md = (Select MAX(md) From @periodList))
                                    THEN CONVERT(char(4), CASE WHEN @begFiscalYr = 1 THEN @year ELSE @year - 1 END)
                                  ELSE CONVERT(char(4), CASE WHEN @begFiscalYr = 1 THEN @year + 1 ELSE @year END) END

  -- Deal with the potential leap year days
  -- If month/day (md) is 0228 and it's leap year, add a day
  Set @febPeriod = NULL
  Select @febPeriod = period
    From @periodList
    Where md = '0228' AND CASE WHEN y % 4 = 0 AND (y % 100 <> 0 OR y % 400 = 0) THEN 'True' ELSE 'False' END = 'True'
  If NOT @febPeriod IS NULL
    Update @periodList Set md = '0229' Where period = @febPeriod

  -- If month/day (md) is 0229 and it's NOT a leap year, subtract a day
  Set @febPeriod = NULL
  Select @febPeriod = period
    From @periodList
    Where md = '0229' AND  CASE WHEN y % 4 = 0 AND (y % 100 <> 0 OR y % 400 = 0) THEN 'True' ELSE 'False' END = 'False'
  If NOT @febPeriod IS NULL
    Update @periodList Set md = '0228' Where period = @febPeriod

  Return (Select CONVERT(smalldatetime, CAST(y As char(4)) + md) periodEndDate
            From @periodList
            Where period = CAST(RIGHT(@period, 2) As smallint))
End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetCalendarEndDateOfGLPeriod] TO [MSDSL]
    AS [dbo];

