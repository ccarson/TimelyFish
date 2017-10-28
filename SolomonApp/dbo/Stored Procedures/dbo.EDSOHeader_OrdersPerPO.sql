 Create Proc EDSOHeader_OrdersPerPO @EDIPOID varchar(10) As
Select Count(*) From SOHeader Where EDIPOID = @EDIPOID And Cancelled = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOHeader_OrdersPerPO] TO [MSDSL]
    AS [dbo];

