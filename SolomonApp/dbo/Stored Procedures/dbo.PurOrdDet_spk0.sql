 create procedure PurOrdDet_spk0 @parm1 varchar (10) , @parm2 smallint  as
select * from PURORDDET
where    PURORDDET.PONbr   = @parm1
and    PURORDDET.LineNbr = @parm2
order by PURORDDET.PONbr,
PURORDDET.LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_spk0] TO [MSDSL]
    AS [dbo];

