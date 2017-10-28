 CREATE Proc EDCustomer_Status @CustId varchar(15) As
Select Status From Customer Where CustId = @CustId


