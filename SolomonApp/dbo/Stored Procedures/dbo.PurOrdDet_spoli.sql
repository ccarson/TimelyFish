 create procedure PurOrdDet_spoli @parm1 varchar (10) , @parm2 int  as
select * from PURORDDET
where    PURORDDET.PONbr  = @parm1
and    PURORDDET.LineId = @parm2
order by PURORDDET.PONbr,
PURORDDET.LineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_spoli] TO [MSDSL]
    AS [dbo];

