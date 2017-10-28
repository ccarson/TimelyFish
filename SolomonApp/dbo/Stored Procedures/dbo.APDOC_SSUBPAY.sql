 create procedure APDOC_SSUBPAY @parm1 varchar (16)   as
select   APDOC.*,
PJPAYHDR.*,
PJSUBCON.project,
PJSUBCON.status_sub,
PJSUBCON.status_pay,
PJSUBCON.subcontract,
PJSUBCON.termsid,
PJSUBVEN.carrier1,
PJSUBVEN.carrier2,
PJSUBVEN.carrier3,
PJSUBVEN.carrier4,
PJSUBVEN.carrier5,
PJSUBVEN.date_ins_eff1,
PJSUBVEN.date_ins_eff2,
PJSUBVEN.date_ins_eff3,
PJSUBVEN.date_ins_eff4,
PJSUBVEN.date_ins_eff5,
PJSUBVEN.date_ins_exp1,
PJSUBVEN.date_ins_exp2,
PJSUBVEN.date_ins_exp3,
PJSUBVEN.date_ins_exp4,
PJSUBVEN.date_ins_exp5,
PJSUBVEN.pay_control,
PJSUBVEN.policy_amt1,
PJSUBVEN.policy_amt2,
PJSUBVEN.policy_amt3,
PJSUBVEN.policy_amt4,
PJSUBVEN.policy_amt5,
PJSUBVEN.policy_nbr1,
PJSUBVEN.policy_nbr2,
PJSUBVEN.policy_nbr3,
PJSUBVEN.policy_nbr4,
PJSUBVEN.policy_nbr5,
PJSUBVEN.policy_type_cd1,
PJSUBVEN.policy_type_cd2,
PJSUBVEN.policy_type_cd3,
PJSUBVEN.policy_type_cd4,
PJSUBVEN.policy_type_cd5,
PJSUBVEN.vend_name,
PJSUBVEN.vendid
from     APDOC, PJPAYHDR
			left outer join PJSUBVEN
				on PJPAYHDR.vendid = PJSUBVEN.vendid
			, PJSUBCON
where
APDOC.batnbr              =    PJPAYHDR.batnbr        and
APDOC.refnbr              =    PJPAYHDR.refnbr        and
PJPAYHDR.project          =    PJSUBCON.project       and
PJPAYHDR.subcontract      =    PJSUBCON.subcontract   and
APDOC.Status              IN   ('A','H')              and
APDOC.DirectDeposit       <>   'R'                    and
APDOC.DocBal              >    0                      and
PJPAYHDR.project          LIKE @parm1
order by PJPAYHDR.project,
PJPAYHDR.subcontract



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDOC_SSUBPAY] TO [MSDSL]
    AS [dbo];

