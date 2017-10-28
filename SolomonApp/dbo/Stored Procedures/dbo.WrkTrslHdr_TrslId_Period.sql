 /****** Object:  Stored Procedure dbo.WrkTrslHdr_TrslId_Period    Script Date: 4/7/98 12:45:04 PM ******/
Create Procedure WrkTrslHdr_TrslId_Period @parm1 varchar(10), @parm2 varchar(6) AS
     Select * from WrkTrslHdr
     where TrslID like @parm1
     and   Period like @parm2
     Order by TrslId, Period



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkTrslHdr_TrslId_Period] TO [MSDSL]
    AS [dbo];

