 Create Proc Delete_Itemsite
    @parm1 varchar ( 30)
as
Delete from ItemSite
    where InvtId = @parm1
      And QtyOnHand = 0
      And TotCost = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_Itemsite] TO [MSDSL]
    AS [dbo];

