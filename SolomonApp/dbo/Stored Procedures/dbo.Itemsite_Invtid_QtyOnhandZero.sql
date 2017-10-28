 Create Proc Itemsite_Invtid_QtyOnhandZero
    @Parm1 VarChar(30)
as
Select Count(*)
   from Itemsite
   Where QtyOnHand <> 0
     And Invtid = @Parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Itemsite_Invtid_QtyOnhandZero] TO [MSDSL]
    AS [dbo];

