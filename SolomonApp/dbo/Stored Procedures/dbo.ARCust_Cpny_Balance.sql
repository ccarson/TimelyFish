 /****** Object:  Stored Procedure dbo.ARCust_Cpny_Balance    Script Date: 4/7/98 12:30:32 PM ******/
Create proc ARCust_Cpny_Balance @parm1 varchar(10), @parm2 varchar (15) as

Select currbal, futurebal, totprepay, agebal00, agebal01, agebal02, agebal03, agebal04
from AR_Balances where cpnyid = @parm1
and custid = @parm2


