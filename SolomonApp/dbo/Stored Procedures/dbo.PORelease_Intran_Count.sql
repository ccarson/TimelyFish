 Create Proc PORelease_Intran_Count
    @Batnbr Varchar(10)
as

Select Count(*)
    From Intran i
    Where i.BatNbr = @BatNbr
      And i.rlsed = 0
      And i.JrnlType = 'PO'


