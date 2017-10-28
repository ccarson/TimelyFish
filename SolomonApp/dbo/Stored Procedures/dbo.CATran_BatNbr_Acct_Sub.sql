 /****** Object:  Stored Procedure dbo.CATran_BatNbr_Acct_Sub    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CATran_BatNbr_Acct_Sub @parm1 varchar ( 10) as
select * from CATran
where batnbr = @parm1
and module = 'CA'
order by acct, sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CATran_BatNbr_Acct_Sub] TO [MSDSL]
    AS [dbo];

