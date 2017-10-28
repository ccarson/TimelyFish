 /****** Object:  Stored Procedure dbo.CashAcct_CuryID    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CashAcct_CuryID as
    select distinct Cashacct.curyid, currncy.descr from CashAcct, Currncy where cashacct.curyid = currncy.curyid
     order by CashAcct.CuryID desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CashAcct_CuryID] TO [MSDSL]
    AS [dbo];

