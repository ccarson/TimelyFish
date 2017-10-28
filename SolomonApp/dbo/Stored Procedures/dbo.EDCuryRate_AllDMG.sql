 Create Proc EDCuryRate_AllDMG @TranCuryId varchar(4), @BaseCuryId varchar(4) As
Select * From CuryRate Where (FromCuryId = @TranCuryId And ToCuryId = @BaseCuryId) Or (FromCuryId = @BaseCuryId And ToCuryId = @TranCuryId) Order By EffDate Desc


