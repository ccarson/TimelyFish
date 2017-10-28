 Create Proc EDOutbound_ConvMeth @CustId varchar(15), @Trans varchar(3) As
Select ConvMeth From EDOutbound Where CustId = @CustId And Trans = @Trans


