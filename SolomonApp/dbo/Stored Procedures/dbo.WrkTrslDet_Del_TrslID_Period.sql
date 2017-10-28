 /****** Object:  Stored Procedure dbo.WrkTrslDet_Del_TrslID_Period    Script Date: 4/7/98 12:45:04 PM ******/
Create Procedure WrkTrslDet_Del_TrslID_Period @parm1 varchar(10), @parm2 varchar(6) AS
     Delete from WrkTrslDet
     Where TrslId = @parm1
     and   Period = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkTrslDet_Del_TrslID_Period] TO [MSDSL]
    AS [dbo];

