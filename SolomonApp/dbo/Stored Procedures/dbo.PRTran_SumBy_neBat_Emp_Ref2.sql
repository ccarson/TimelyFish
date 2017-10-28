 CREATE PROC PRTran_SumBy_neBat_Emp_Ref2 @BatNbr varchar(10), @EmpID varchar(10), @ProjectId varchar(16), @RefNbr varchar(10) AS
    select TotID, Coalesce(Sum(Qty),0)
      from PRTran
     inner JOIN TSTotal ON PRTran.EarnDedID = TSTotal.ETid
     where BatNbr     =    @BatNbr
       and ProjectId  <>   @ProjectId
       and EmpID      LIKE @EmpID
       and TimeShtFlg <>   0
       and Paid       =    0
       and TimeShtNbr LIKE @RefNbr
  group by TotID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_SumBy_neBat_Emp_Ref2] TO [MSDSL]
    AS [dbo];

