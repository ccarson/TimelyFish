 /****** Object:  Stored Procedure dbo.GLTran_Select_ReconDate    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc GLTran_Select_ReconDate @parm1 varchar ( 10), @parm2 varchar ( 24), @parm3 smalldatetime, @parm4 smalldatetime, @parm5 varchar ( 10), @parm6 smalldatetime, @parm7 varchar (1), @parm8 smallint as
Select * from gltran
Where acct = @parm1
and sub = @parm2
AND  ( (@parm7 = 'C' AND ((S4Future11 = 'C' and S4Future07 > @parm4 and (S4Future07 <= @parm6 or @parm8=1 and TranDate<=@parm3)
      and trandate >= (select accepttransdate from casetup)) or (S4Future11 = '' and TranDate > @parm4 and (TranDate <= @parm6 or @parm8=1 and TranDate<=@parm3))))
      OR (@parm7 = 'O' AND (S4Future11 = 'O' or S4Future11 = 'C' and S4Future07 > @parm6 or
      S4Future11 = '' and TranDate > @parm6) and TranDate between (select accepttransdate from casetup) and @parm3)
      OR (@Parm7 = 'B' AND ((S4Future11 = 'O' and TranDate between (select accepttransdate from casetup) and @parm3)
                        or ((S4Future11 = 'C' and S4Future07 > @parm4 and (S4Future07 <= @parm6 or TranDate<=@parm3) and trandate >= (select accepttransdate from casetup))
      or (S4Future11 = '' and TranDate > @parm4 and (TranDate <= @parm6 or TranDate<=@parm3)))
                            )
          )
      )
And rlsed = 1
and CpnyID = @parm5
and Module = 'GL'
and TranType <> 'ZZ'
Order by batnbr, refnbr, trandate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTran_Select_ReconDate] TO [MSDSL]
    AS [dbo];

