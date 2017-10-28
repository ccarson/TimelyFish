 /****** Object:  Stored Procedure dbo.PONbr_On_VOtran    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure PONbr_On_VOtran    @parm1 varchar(10), @parm3 varchar(10) As
select batnbr, refnbr from APtran Where PONbr = @parm1 and RefNBr <> @parm3
and rlsed = 0  and trantype in ('AD', 'VO')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PONbr_On_VOtran] TO [MSDSL]
    AS [dbo];

