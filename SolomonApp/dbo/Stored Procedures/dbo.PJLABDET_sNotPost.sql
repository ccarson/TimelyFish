 create procedure PJLABDET_sNotPost  @parm1 varchar (16)   as
select PJLABDET.* from PJLABDET, PJLABHDR
where
PJLABDET.project     =  @parm1 and
PJLABHDR.docnbr = PJLABDET.docnbr and
PJLABHDR.le_status <> 'P' and
PJLABHDR.le_status <> 'X'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDET_sNotPost] TO [MSDSL]
    AS [dbo];

