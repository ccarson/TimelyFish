

Create Proc DMG_SendProjInfoToPurchaseOrder @SendProj	smallint OUTPUT

AS
		
      SELECT @SendProj = SendProjInfotoPO
        FROM SOSetup WITH(NOLOCK)

	if ( @SendProj = 1 ) 
		return 1  -- Success
	Else	
		return 0  -- Failure


GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SendProjInfoToPurchaseOrder] TO [MSDSL]
    AS [dbo];

