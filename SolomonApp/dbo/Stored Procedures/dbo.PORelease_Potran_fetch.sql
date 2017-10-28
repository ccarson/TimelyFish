
Create Proc PORelease_Potran_fetch
    @Batnbr Varchar(10)
as

Select *
    From Potran 
    Where BatNbr = @BatNbr
      And TranType = 'X'
      And JrnlType = 'PO'
