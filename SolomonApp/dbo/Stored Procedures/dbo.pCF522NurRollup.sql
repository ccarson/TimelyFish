-------------------------------------------------
-- 	Get the account totals for Nursery transfer
--	pCF522NurRollup
--	Created:    4/24/2006
--	Create by:  Sue Matter
-------------------------------------------------
CREATE PROCEDURE pCF522NurRollup
	@parm1 varchar(10)
AS
Select Sum(act_amount), Sum(act_Units) 
from PJPTDSUM 
Where acct<>'PIG BASE DOLLARS' AND acct<>'PIG GRADE PREM' 
AND acct<>'PIG MKT TRUCKING' AND acct<>'PIG SALE' AND acct<>'PIG SORT LOSS'
AND pjt_entity=@parm1

