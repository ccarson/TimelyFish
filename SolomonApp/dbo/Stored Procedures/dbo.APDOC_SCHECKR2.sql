 create procedure APDOC_SCHECKR2 @parm1 varchar (10) , @parm2 varchar (10)   as
select   COUNT(*)
from     apdoc, apadjust, apdoc apdoc2, pjpayhdr, pjsubcon
where
apdoc.batnbr         =  apadjust.adjbatnbr  and
apdoc.refnbr         =  apadjust.adjgrefnbr and
apadjust.vendid      =  apdoc2.vendid       and
apadjust.adjddoctype =  apdoc2.doctype      and
apadjust.adjdrefnbr  =  apdoc2.refnbr       and
APDoc2.BATNBR        =  PJPAYHDR.BATNBR     and
APDoc2.REFNBR        =  PJPAYHDR.REFNBR_RET and
PJPAYHDR.PROJECT     = PJSUBCON.PROJECT     and
PJPAYHDR.SUBCONTRACT = PJSUBCON.SUBCONTRACT and
apdoc.doctype        =  'CK'                and
apdoc.status         <> 'V'                 and
apdoc.refnbr         <> ''                  and
apdoc.refnbr between @parm1 and @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDOC_SCHECKR2] TO [MSDSL]
    AS [dbo];

