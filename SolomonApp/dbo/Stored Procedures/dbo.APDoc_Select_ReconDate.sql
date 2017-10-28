 /****** Object:  Stored Procedure dbo.APDoc_Select_ReconDate    Script Date: 4/7/98 12:49:19 PM ******/
create Proc APDoc_Select_ReconDate @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 smalldatetime, @parm5 smalldatetime, @parm6 smalldatetime, @parm7 varchar (1), @parm8 smallint as
Select * from apdoc
Where cpnyid = @parm1
and acct = @parm2
and sub = @parm3
AND ((@parm7 = 'O' and DocDate between (select accepttransdate from casetup) and @parm4 and (status = 'O' or ClearDate > @parm6) )
  OR (@parm7 = 'C' and status = 'C' and (ClearDate > @parm5 and (ClearDate <= @parm6 or @parm8=1 and DocDate<=@parm4) and DocDate >= (select accepttransdate from casetup)))
  OR (@parm7 = 'B' and ((status = 'O' and DocDate between (select accepttransdate from casetup) and @parm4)
                   or (status = 'C' and (ClearDate > @parm5 and (ClearDate <= @parm6 or DocDate<=@parm4) and DocDate >= (select accepttransdate from casetup)))
                       )
      )
     )
and DocType NOT IN('SC','MC')
and rlsed = 1
Order by refnbr, Docdate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_Select_ReconDate] TO [MSDSL]
    AS [dbo];

