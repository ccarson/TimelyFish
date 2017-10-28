 Create proc ARCust_Balance_Sec @parm1 varchar(15), @parm2 varchar(47), @parm3 varchar(7), @parm4 varchar(1)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

select currbal, futurebal, totprepay, agebal00, agebal01, agebal02, agebal03, agebal04
from AR_Balances where custid = @parm1 and cpnyid in

(select Cpnyid
  from vs_share_usercpny
 where userid = @parm2
   and scrn = @parm3
   and seclevel >= @parm4 )


