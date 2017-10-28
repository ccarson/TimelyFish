 CREATE Proc EDCarrier_Descr @CarrierId varchar(10) As
Select CarrierId, Descr From Carrier Where CarrierId = @CarrierId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDCarrier_Descr] TO [MSDSL]
    AS [dbo];

