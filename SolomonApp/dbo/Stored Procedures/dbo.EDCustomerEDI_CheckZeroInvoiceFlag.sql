 Create Proc EDCustomerEDI_CheckZeroInvoiceFlag @CustId varchar(15) As
Select S4Future10 From CustomerEDI Where CustId = @CustId


