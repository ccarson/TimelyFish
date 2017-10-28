

Create Proc BRTran_Per_Beg_End_amt @AcctID as varchar(10), @CurrPerNbr as Varchar(6), @BAI2BegDate as smalldatetime, @BAI2EndDate as smalldatetime, @TranAmt as Float
as
SELECT * FROM BRTRAN WHERE AcctID = @AcctID
    AND CurrPerNbr = @CurrPerNbr
    AND TranDate between @BAI2BegDate and @BAI2EndDate
    AND TranAmt = @TranAmt
    AND UserC1 = ''
            
