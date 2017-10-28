 /****** Object:  Stored Procedure dbo.WrkTrslDet_TrslID_Period_Acct    Script Date: 4/7/98 12:45:04 PM ******/
Create Procedure WrkTrslDet_TrslID_Period_Acct @parm1 varchar(10), @parm2 varchar(6), @parm3 varchar(10) AS
     Select * from WrkTrslDet
     where TrslID like @parm1
     and   Period like @parm2
     and   Acct like @parm3
     Order by TrslId, Period, Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkTrslDet_TrslID_Period_Acct] TO [MSDSL]
    AS [dbo];

