 Create Proc EDOutbound_GetInvoiceTrans @CustId varchar(15) As
Select Trans From EDOutbound Where CustId = @CustId And Trans In ('810','880')


