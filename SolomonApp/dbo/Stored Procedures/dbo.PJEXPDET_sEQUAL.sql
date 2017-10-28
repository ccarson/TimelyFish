 create procedure PJEXPDET_sEQUAL  @parm1 varchar (10) , @parm2 smallint  as
select * from PJEXPDET
where    pjexpdet.docnbr  =  @parm1
and PJEXPDET.linenbr  =  @parm2
order by pjexpdet.docnbr, pjexpdet.linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEXPDET_sEQUAL] TO [MSDSL]
    AS [dbo];

