 create procedure PJTIMDET_sNotPost  @parm1 varchar (16)   as
select PJTIMDET.* from PJTIMDET, PJTIMHDR
where
PJTIMHDR.docnbr = PJTIMDET.docnbr and
PJTIMHDR.th_status <> 'P' and
PJTIMDET.project     =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTIMDET_sNotPost] TO [MSDSL]
    AS [dbo];

