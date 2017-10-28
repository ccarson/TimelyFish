 /****** Object:  Stored Procedure dbo.WrkCAForecast_RI_ID    Script Date: 4/7/98 12:49:20 PM ******/
create Proc WrkCAForecast_RI_ID @parm1 smallint as
Select *  from WrkCAForecast where RI_ID = @parm1
Order by RI_ID, CpnyID, BankAcct, Banksub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkCAForecast_RI_ID] TO [MSDSL]
    AS [dbo];

