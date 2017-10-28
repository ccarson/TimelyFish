 create procedure PJSUBDET_RevSum  @parm1 varchar (16) , @parm2 varchar (16)   as
select  sum(curyrevised_amt), sum(curyprior_req_amt), PJSUBDET.project, PJSUBDET.subcontract
from PJSUBDET
where
PJSUBDET.project       =    @parm1 and
PJSUBDET.subcontract   =    @parm2
group by PJSUBDET.project, PJSUBDET.subcontract



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBDET_RevSum] TO [MSDSL]
    AS [dbo];

