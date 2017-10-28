 CREATE PROC p08990_ARBalUpd AS

DECLARE @Period VarChar(6), @PerToSub INT, @OutPerNbr VarChar(6)

-- Get Cutoff Date for Avg Day to Pay Calculation
SELECT @Period = CurrPerNbr, @PerToSub = RetAvgDay FROM ARSetup

EXEC pp_PeriodMinusPerNbr @Period,  @PerToSub , @OutPerNbr Output

UPDATE b
   SET AvgDayToPay  = ISNULL(sumbal.AvgDayToPay,0),
       NbrInvcPaid  = ISNULL(SumBal.NbrInvcPaid,0),
       PaidInvcDays = ISNULL(SumBal.PaidInvcDays,0)
  FROM AR_Balances b LEFT JOIN (SELECT Custid, Cpnyid,
                                  AvgDayToPay = ROUND(Convert(float, SUM(PaidInvcDays)) / Convert(float, SUM(v.NbrInvcPaid)), 2),
                                  NbrInvcPaid = SUM(v.NbrInvcPaid),
                                  PaidInvcDays = SUM(v.PaidInvcDays)
                             FROM vi_08990UpdArBal v
                            WHERE (v.Perpost >= @OutPerNBr OR v.AdjgPerPost >= @OutPerNBr)
                            GROUP BY CpnyID,CustID ) sumbal

                       ON  b.custid = sumbal.custid AND
                           b.cpnyid = sumbal.cpnyid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990_ARBalUpd] TO [MSDSL]
    AS [dbo];

