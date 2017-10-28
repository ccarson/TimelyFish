 Create Procedure PORcpt_On_VOtran2 @parm1  varchar(10), @parm2 varchar(5), @parm3 float, @parm4 float As
select batnbr, rcptnbr from POtran
where
RcptNbr = @parm1 and
LineRef = @parm2 and
(convert(dec(28,3),@parm3) <> convert(dec(28,3),POTran.CuryExtCost) - convert(dec(28,3),POTran.CuryCostVouched)
OR
convert(dec(25,9),@parm4) <> convert(dec(25,9),POTran.RcptQty) - convert(dec(25,9),POTran.QtyVouched))



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PORcpt_On_VOtran2] TO [MSDSL]
    AS [dbo];

