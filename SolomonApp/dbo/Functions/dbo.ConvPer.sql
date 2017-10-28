Create Function dbo.ConvPer(@PerNbr as VarChar (6)) Returns VarChar (6) as 
    Begin
	if (@PerNbr > '2100') Return @PerNbr
	Declare @DateStr VarChar (10)
	Declare @CalcPer VarChar (10)
	Select @DateStr = SubString(@PerNbr, 5, 2) + '/01/' + SubString(@PerNbr, 1, 4)
	Select @CalcPer = Case When IsDate (@DateStr) = 1 Then Convert(varchar (10), DateAdd(mm, -6, Convert(smalldatetime, @DateStr)), 101) Else @PerNbr End
	Return SubString(@CalcPer, 7, 4) + SubString(@CalcPer, 1, 2)
    End
