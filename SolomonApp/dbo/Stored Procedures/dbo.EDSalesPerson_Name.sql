 Create Proc EDSalesPerson_Name @SlsPerId varchar(10) As
Select Name From SalesPerson Where SlsPerId = @SlsPerId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSalesPerson_Name] TO [MSDSL]
    AS [dbo];

