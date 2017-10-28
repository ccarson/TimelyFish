 Create Proc FMG_CM_CurrencyValidate  @CurrencyId varchar (4)As
IF
    (Select Count(*) FROM GLSetup WHERE BaseCuryID = @CurrencyId) > 0 or
    (Select Count(*) FROM Batch   WHERE BaseCuryID = @CurrencyId Or CuryId = @CurrencyId) > 0
   SELECT 9
ELSE
     SELECT 0


