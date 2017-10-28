 /****** Object:  Stored Procedure dbo.PRDoc_Select_ReconDate    Script Date: 4/7/98 12:49:20 PM ******/
create Proc PRDoc_Select_ReconDate @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 smalldatetime, @parm5 smalldatetime, @parm6 smalldatetime, @parm7 varchar(1), @parm8 smallint as
Select * from PRdoc
Where cpnyid = @parm1
and acct = @parm2
and sub = @parm3
AND ((@parm7 = 'O' and (Status = 'O' or ClearDate>@parm6) and ChkDate between (select accepttransdate from casetup) and @parm4)
  OR (@parm7 = 'C' and Status = 'C' and (ClearDate > @parm5 and (ClearDate <= @parm6 or @parm8=1 and ChkDate<=@parm4) and ChkDate >= (select accepttransdate from casetup)))
  OR (@parm7 = 'B' and ((status = 'O' and ChkDate between (select accepttransdate from casetup) and @parm4)
                    or (status = 'C' and (ClearDate > @parm5 and (ClearDate <= @parm6 or ChkDate<=@parm4) and ChkDate >= (select accepttransdate from casetup)))
                       )
     )
    )
and rlsed = 1
Order by acct, sub, chknbr, doctype



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRDoc_Select_ReconDate] TO [MSDSL]
    AS [dbo];

