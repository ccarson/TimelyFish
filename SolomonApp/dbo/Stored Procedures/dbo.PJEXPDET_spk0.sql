 create procedure PJEXPDET_spk0  @parm1 varchar (10)   as
select * from PJEXPDET
where    pjexpdet.docnbr     =  @parm1
order by pjexpdet.docnbr, pjexpdet.linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEXPDET_spk0] TO [MSDSL]
    AS [dbo];

