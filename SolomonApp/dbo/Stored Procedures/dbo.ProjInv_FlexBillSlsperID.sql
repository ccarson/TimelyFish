 create procedure ProjInv_FlexBillSlsperID @SlsPerID varchar (10)  as

  SELECT SlsperId,CmmnPct
    FROM Salesperson WITH(NOLOCK)
   WHERE SlsperId = @SlsPerID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_FlexBillSlsperID] TO [MSDSL]
    AS [dbo];

