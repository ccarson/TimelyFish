
Create Proc BRTRAN_Acct_Per_RefNbr_Amt @AcctID as VarChar(10), @CurrPerNbr as Varchar(6), @BankRefNbr as VarChar(10), @TranAmt as Float
as        
        SELECT * FROM BRTRAN WHERE AcctID = @AcctID
        AND CurrPerNbr =  @CurrPerNbr
        AND dbo.SuperTrim(OrigRefNbr) =  dbo.SuperTrim(@BankRefNbr)
        AND TranAmt = @TranAmt
        AND UserC1 = ''
