

CREATE Proc XDD_company_Master_Fed_ID
 	@CpnyID		varchar( 10 ),
 	@FedID  	varchar( 12 ) OUTPUT
	WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'

AS  
	SELECT		@FedID = Master_Fed_ID
 	FROM		vs_company
 	WHERE		CpnyID = @CpnyID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDD_company_Master_Fed_ID] TO [MSDSL]
    AS [dbo];

