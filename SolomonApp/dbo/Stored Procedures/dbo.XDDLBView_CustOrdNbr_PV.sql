
create proc XDDLBView_CustOrdNbr_PV
	@CustOrdNbr		varchar(25)
AS
	SELECT * FROM ARDoc
	WHERE CustOrdNbr <> ''
 	and DocType IN ('IN', 'DM') 
 	and CustOrdNbr LIKE @CustOrdNbr
	ORDER BY CustOrdNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDLBView_CustOrdNbr_PV] TO [MSDSL]
    AS [dbo];

