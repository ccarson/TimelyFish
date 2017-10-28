 /****** Object:  Stored Procedure dbo.WrkCADetail_RI_ID    Script Date: 4/7/98 12:49:20 PM ******/
create Proc WrkCADetail_RI_ID @parm1 smallint as
Select *  from WrkCADetail where RI_ID = @parm1
Order by RI_ID, CpnyID, BankAcct, Banksub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkCADetail_RI_ID] TO [MSDSL]
    AS [dbo];

