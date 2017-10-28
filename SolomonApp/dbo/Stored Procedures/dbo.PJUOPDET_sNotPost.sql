 create procedure PJUOPDET_sNotPost  @parm1 varchar (16)   as
select PJUOPDET.* from PJUOPDET, PJTIMHDR
where
PJTIMHDR.docnbr = PJUOPDET.docnbr and
PJTIMHDR.th_status <> 'P' and
PJUOPDET.project     =  @parm1


