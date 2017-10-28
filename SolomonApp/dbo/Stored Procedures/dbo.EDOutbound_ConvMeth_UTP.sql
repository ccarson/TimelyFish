 CREATE PROC EDOutbound_ConvMeth_UTP
	@CustId varchar(15),
	@Trans varchar(3)
As
	SELECT ConvMeth, S4Future09
	FROM EDOutbound
	WHERE CustId = @CustId And Trans = @Trans


