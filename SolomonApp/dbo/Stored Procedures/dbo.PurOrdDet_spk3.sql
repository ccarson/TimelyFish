 create procedure PurOrdDet_spk3 @parm1 varchar (10) , @parm2 int  as
select PoNbr,LineId, User1, User2, User3, User4 from PURORDDET
where    PURORDDET.PONbr   = @parm1
and    PURORDDET.LineId = @parm2
order by PURORDDET.PONbr,
PURORDDET.LineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_spk3] TO [MSDSL]
    AS [dbo];

