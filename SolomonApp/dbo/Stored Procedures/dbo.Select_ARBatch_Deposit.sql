 create proc Select_ARBatch_Deposit  @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24), @parm4 smalldatetime, @parm5 smalldatetime as
Select * from batch where
cpnyid = @parm1
and bankacct = @parm2
and banksub = @parm3
and (dateent >= @parm4 and dateent <= @parm5)
and rlsed = 1
and module = 'AR'
and battype <> 'C'
order by batnbr, dateent



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Select_ARBatch_Deposit] TO [MSDSL]
    AS [dbo];

