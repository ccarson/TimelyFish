 CREATE PROCEDURE CashFlow_CaseNbr
                 @parm1 varchar ( 2)
AS
SELECT *

FROM Cashflow

WHERE CaseNbr LIKE @parm1

ORDER BY Casenbr, Rcptdisbdate, Descr, CpnyID, Bankacct, Banksub


