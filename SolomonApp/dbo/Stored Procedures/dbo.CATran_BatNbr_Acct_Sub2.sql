 /****** Object:  Stored Procedure dbo.CATran_BatNbr_Acct_Sub2    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CATran_BatNbr_Acct_Sub2 @parm1 varchar ( 10) as
select * from CATran
where batnbr = @parm1
and module = 'CA'
order by cpnyid,
         acct,
         sub,
         ProjectId,
         TaskId,
         EmployeeId,
         Labor_Class_Cd,
         PC_Flag,
         PC_ID,
         PC_Status



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CATran_BatNbr_Acct_Sub2] TO [MSDSL]
    AS [dbo];

