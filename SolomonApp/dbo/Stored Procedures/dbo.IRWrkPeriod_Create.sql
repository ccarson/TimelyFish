 CREATE Procedure IRWrkPeriod_Create
	@CurrentPeriod VarChar(6)
As
-- NOTE!!!  Assume there is at least one entry in IRItemUsage For EVERY Period that we will work with, skipping a period will mis-align the numbers that are generated!!!
Declare @i SmallInt
If Exists	(
			Select
				*
			From
				IRWrkPeriod
			Where
				CurrentPeriod = @CurrentPeriod
		)
Begin
	-- Bail out now, don't need to build for this period
	Return
End
Set NoCount On
	Insert Into IRWrkPeriod (Crtd_Datetime, Crtd_Prog, Crtd_User, CurrentPeriod, Lupd_Datetime,
							Lupd_Prog, Lupd_User, Number, Period, S4Future01, S4Future02,
							S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
							S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
							User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)
		Select
			Distinct
			Convert(SmallDateTime,Convert(VarChar(12),GetDate())) As 'Crtd_Datetime',
			'IRWrkPe' As 'Crtd_Prog',
			'IRWrkPe' As 'Crtd_User',
			@CurrentPeriod As 'CurrentPeriod',
			Convert(SmallDateTime,Convert(VarChar(12),GetDate())) As 'Lupd_Datetime',
			'IRWrkPe' As 'Lupd_Prog',
			'IRWrkPe' As 'Lupd_User',
			-1 As 'Number',
			Period As 'Period',
			' ' As 'S4Future01',
			' ' As 'S4Future02',
			0.0 As 'S4Future03',
			0.0 As 'S4Future04',
			0.0 As 'S4Future05',
			0.0 As 'S4Future06',
			'01/01/1900' As 'S4Future07',
			'01/01/1900' As 'S4Future08',
			0 As 'S4Future09',
			0 As 'S4Future10',
			' ' As 'S4Future11',
			' ' As 'S4Future12',
			' ' As 'User1',
			'01/01/1900' As 'User10',
			' ' As 'User2',
			' ' As 'User3',
			' ' As 'User4',
			0.0 As 'User5',
			0.0 As 'User6',
			' ' As 'User7',
			' ' As 'User8',
			'01/01/1900' As 'User9'
		From
			IRItemUsage
		Where
			Period < @CurrentPeriod
	-- go though and number the periods, so they will relate correctly to the periods in the IRDemDetail
	-- Assumption:  There is at least one GL Transaction per accounting period
	Set @i = 1		-- counter will update
	While Exists (Select * From IRWrkPeriod Where CurrentPeriod = @CurrentPeriod And Number = -1)
	Begin
		-- Update the next one
		Update
			IRWrkPeriod
		Set
			Number = @i
		Where
			CurrentPeriod = @CurrentPeriod
			And Period in	(
						Select
							Max(Period)
						From
							IRWrkPeriod
						Where
							CurrentPeriod = @CurrentPeriod
							And Number = -1
					)
		-- Increment counter
		Set @i = @i + 1
	End

Set NoCount Off


