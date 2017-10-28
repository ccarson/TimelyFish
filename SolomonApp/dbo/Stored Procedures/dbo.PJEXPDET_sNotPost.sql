 create procedure PJEXPDET_sNotPost  @parm1 varchar (16)   as
select PJEXPDET.* from PJEXPDET, PJEXPHDR
where
PJEXPHDR.docnbr = PJEXPDET.docnbr and
PJEXPHDR.status_1 <> 'P' and
PJEXPDET.project     =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEXPDET_sNotPost] TO [MSDSL]
    AS [dbo];

