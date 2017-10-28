 /****** Object:  Stored Procedure dbo.TrslHd_Status    Script Date: 4/7/98 12:45:04 PM ******/
Create Proc TrslHd_Status AS
     Select * from FSTrslHd
     Where Status IN ('I', 'S', 'B')
     Order by RefNbr, Status



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TrslHd_Status] TO [MSDSL]
    AS [dbo];

