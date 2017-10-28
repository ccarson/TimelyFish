
CREATE VIEW [dbo].[vEssbaseFiscalPeriodRollup]
AS
SELECT     FarmID, FiscalYear, FiscalPeriod, Account, Genetics, Parity, SUM(Qty) AS Qty
FROM         dbo.EssbaseUploadTemp
GROUP BY FarmID, FiscalYear, FiscalPeriod, Account, Genetics, Parity

