 
CREATE VIEW CashAcctSub_Active
AS
SELECT c.* FROM CashAcct c INNER JOIN vs_AcctSub v ON v.Acct = c.BankAcct AND
                                                    v.Sub = c.BankSub AND
                                                    v.CpnyID = c.CpnyID AND
                                                    v.Active = 1


 
