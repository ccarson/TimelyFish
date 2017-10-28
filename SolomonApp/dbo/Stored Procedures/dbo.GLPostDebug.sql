 CREATE PROCEDURE GLPostDebug @BatNbr CHAR(10), @Module CHAR(2) AS

   DELETE FROM WrkPost WHERE UserAddress = 'GLPostDebug'
   DELETE FROM WrkPostbad WHERE UserAddress = 'GLPostDebug'

   INSERT INTO WrkPost (Batnbr, Module, UserAddress, tstamp)
   VALUES (@Batnbr, @Module, 'GLPostDebug', NULL)

   EXEC pp_01520 'GLPostDebug', 'GLPostDebug'

   SELECT * FROM WrkPost WHERE UserAddress = 'GLPostDebug'
   SELECT * FROM WrkPostbad WHERE UserAddress = 'GLPostDebug'

   DELETE FROM WrkPost WHERE UserAddress = 'GLPostDebug'
   DELETE FROM WrkPostbad WHERE UserAddress = 'GLPostDebug'

   SELECT 'GLPostDebug Post Complete.'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLPostDebug] TO [MSDSL]
    AS [dbo];

