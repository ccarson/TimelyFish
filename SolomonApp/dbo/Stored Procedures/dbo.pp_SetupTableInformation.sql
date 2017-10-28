 CREATE PROCEDURE pp_SetupTableInformation
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

SET NOCOUNT ON

-- ***********************************************************
-- Show the current date and time for when the script is being ran.
SELECT GETDATE() AsOf

-- ***********************************************************
-- GET SQL Server Information
PRINT 'SQL Server Information:'
SELECT 'MS SQL Server version:', @@VERSION
PRINT 'sp_configure Information:'
EXEC sp_configure
EXEC sp_dboption

-- ***********************************************************
-- GET Multi-Company Setup Option:
PRINT ''
PRINT ''
PRINT 'Multi-Company Setup Information (MCSetup):'
SELECT 'MC Installed:', COUNT(*) FROM vs_MCSetup (NOLOCK)
SELECT 'MC Activated:', MCActivated FROM vs_MCSetup (NOLOCK)

-- ***********************************************************
-- GET Company and Database Combinations:
SELECT 'MC Company and Database Combinations:',
       Active,
       BaseCuryId,
       DatabaseName,
       CpnyId
  FROM vs_Company
  ORDER BY DatabaseName, CpnyId

-- ***********************************************************
-- GET General Ledger Setup Option:
PRINT ''
PRINT ''
PRINT 'General Ledger Setup Information (GLSetup):'
SELECT 'GL Database Version:', S4Future01 FROM GLSetup (NOLOCK)
SELECT 'GL Auto Post Option:', AutoPost FROM GLSetup (NOLOCK)
SELECT 'GL Base Currency ID:', BaseCuryId FROM GLSetup (NOLOCK)
SELECT 'GL Multi-Company Active Flag Option:', MCActive FROM GLSetup (NOLOCK)
SELECT 'GL Multi-Company, Multi-Database Flag Option:', Mult_Cpny_DB FROM GLSetup (NOLOCK)
SELECT 'GL Centralized Cash Control Option:', Central_Cash_Cntl FROM GLSetup (NOLOCK)
SELECT 'GL Master Company ID:', CpnyID FROM GLSetup (NOLOCK)
SELECT 'GL Account SubAccount Validation Flag:', ValidateAcctSub FROM GLSetup (NOLOCK)
SELECT 'GL Current Period:', PerNbr FROM GLSetup (NOLOCK)

-- ***********************************************************
-- GET Accounts Payable options:
PRINT ''
PRINT ''
PRINT 'Accounts Payable Setup Information (APSetup):'
SELECT 'AP Installed:', COUNT(*) FROM APSetup (NOLOCK)
SELECT 'AP Auto Batch Number Flag:', AutoBatRpt FROM APSetup (NOLOCK)
SELECT 'AP Auto Reference Numbering Flag:', AutoRef FROM APSetup (NOLOCK)
SELECT 'AP Current Period Number:', CurrPerNbr FROM APSetup (NOLOCK)
SELECT 'AP General Ledger Post Option:', GLPostOpt FROM APSetup (NOLOCK)

-- ***********************************************************
-- GET Accounts Receivable options:
PRINT ''
PRINT ''
PRINT 'Accounts Receivable Setup Information (ARSetup):'
SELECT 'AR Installed:', COUNT(*) FROM ARSetup (NOLOCK)
SELECT 'AR Auto Batch Number Flag:', AutoBatRpt FROM ARSetup (NOLOCK)
SELECT 'AR AR Auto Reference Numbering Flag:', AutoRef FROM ARSetup (NOLOCK)
SELECT 'AR Current Period Number:', CurrPerNbr FROM ARSetup (NOLOCK)
SELECT 'AR General Ledger Post Option:', GLPostOpt FROM ARSetup (NOLOCK)

-- ***********************************************************
-- GET Cash Manager options:
PRINT ''
PRINT ''
PRINT 'Cash Manager Setup Information (CASetup):'
SELECT 'CA Installed:', COUNT(*) FROM CASetup (NOLOCK)
SELECT 'CA Started Accepting Transactions Date:', AcceptTransDate FROM CASetup (NOLOCK)
SELECT 'GLSetup Flag to Update CA (0=No/-1=Yes):', UpdateCA FROM GLSetup (NOLOCK)
SELECT 'CashAcct Accept GL Updates Flag (0=No/-1=Yes):', AcceptGLUpdates, CpnyId, BankAcct, BankSub
FROM CashAcct (NOLock)
ORDER BY CpnyId, BankAcct, BankSub

-- ***********************************************************
-- GET Currency Information:
PRINT ''
PRINT ''
PRINT 'Currency Manager Setup Information (CMSetup):'
SELECT 'CM Installed:', COUNT(*) FROM CMSetup (NOLOCK)
SELECT 'CM Enabled:', MCActivated FROM CMSetup (NOLOCK)

-- ***********************************************************
-- GET Currency Information:
PRINT ''
PRINT ''
PRINT 'Currency Information:'
SELECT CuryId,
       CuryCapt,
       DecPl
  FROM Currncy (NOLOCK)
  ORDER BY CuryID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_SetupTableInformation] TO [MSDSL]
    AS [dbo];

