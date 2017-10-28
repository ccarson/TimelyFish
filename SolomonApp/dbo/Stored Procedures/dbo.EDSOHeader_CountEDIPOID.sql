 Create Proc EDSOHeader_CountEDIPOID @EDIPOID varchar(10) As
Select Count(*) From SOHeader Where EDIPOID = @EDIPOID And Cancelled = 0


