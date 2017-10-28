 Create Proc Inventory_DependencyCount
       @Parm1 Varchar(30)

as

Declare @Dependency_Count int		--- Total No. of Dependent Records

Select @Dependency_Count = Count(*)
   from SoLine l Join SoHeader h on
        l.OrdNbr = h.OrdNbr
   Where l.Invtid = @Parm1
     and h.Status = 'O'

If @Dependency_Count > 0 Goto Return_Count

Select @Dependency_Count = Count(*)
   from PurOrdDet d Join Purchord h on
        d.PoNbr = h.PoNbr
   Where d.InvtId = @parm1
     And h.Status in ('O','P','Q')

If @Dependency_Count > 0 Goto Return_Count

Select @Dependency_Count = Count(*)
   from Kit
   where KitId = @parm1

If @Dependency_Count > 0 Goto Return_Count

Select @Dependency_Count = Count(*)
   from Component
   where CmpnentId = @parm1

Return_Count:
Select @Dependency_Count



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Inventory_DependencyCount] TO [MSDSL]
    AS [dbo];

