
create procedure Benefit_Init_w @parm1 varchar (10), @parm2 varchar (10) as
select Benefit.BenId, Benefit.AccrLiab, Benefit.LiabAcct, Benefit.LiabSub,
BYBegBal, BYTDAvail, BYTDUsed
from Benefit, BenEmp
where  EmpID = @parm1 AND ClassID = @parm2 AND BenEmp.BenId = Benefit.BenID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Benefit_Init_w] TO [MSDSL]
    AS [dbo];

