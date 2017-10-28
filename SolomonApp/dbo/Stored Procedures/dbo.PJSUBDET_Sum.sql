 create procedure PJSUBDET_Sum  @parm1 varchar (16) , @parm2 varchar (16)   as
select 
SUM(curyoriginal_amt),
SUM(curyrevised_amt),
SUM(curyco_pend_amt),
sum(curyvouch_amt),
sum(original_amt),
sum(revised_amt), 
sum(co_pend_amt), 
sum(vouch_amt), 
PJSUBDET.project, 
PJSUBDET.subcontract
from PJSUBDET
where
PJSUBDET.project       =    @parm1 and
PJSUBDET.subcontract   =    @parm2
group by PJSUBDET.project, PJSUBDET.subcontract



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBDET_Sum] TO [MSDSL]
    AS [dbo];

