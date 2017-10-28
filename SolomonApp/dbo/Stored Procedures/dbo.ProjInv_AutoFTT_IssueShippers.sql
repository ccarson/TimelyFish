
Create Procedure ProjInv_AutoFTT_IssueShippers 
       @BatNbr VarChar(10), 
       @CpnyID VarChar(10) 

AS

     SELECT DISTINCT SrcNbr = i.RefNbr,SrcType = 'SHP',   --Consume Project Inventory on Shippers
                     i.TRANTYPE, IssueRefNbr = i.ShipperID 

       FROM INTRAN i WITH(NOLOCK)  
      WHERE i.TranType = 'IN' 
        AND i.SrcNbr = ' '
        AND i.ProjectID <> ''  
        AND i.Batnbr = @BatNbr
        AND i.CpnyID = @CpnyID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_AutoFTT_IssueShippers] TO [MSDSL]
    AS [dbo];

