
Create Proc SendProjInfoToPurchaseOrder AS
      SELECT SendProjInfotoPO
        FROM SOSetup WITH(NOLOCK)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[SendProjInfoToPurchaseOrder] TO [MSDSL]
    AS [dbo];

