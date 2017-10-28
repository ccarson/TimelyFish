 CREATE PROCEDURE CashFlow_CaseNbr_Descr @parm1 varchar ( 2), @parm2 varchar ( 30)
AS
SELECT * FROM Cashflow
WHERE CaseNbr LIKE @parm1 AND Descr LIKE @parm2
ORDER BY Casenbr, Descr, Rcptdisbdate


