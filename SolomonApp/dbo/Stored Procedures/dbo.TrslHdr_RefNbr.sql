 /****** Object:  Stored Procedure dbo.TrslHdr_RefNbr    Script Date: 4/7/98 12:45:04 PM ******/
Create Proc TrslHdr_RefNbr @parm1 varchar ( 10) AS
     Select * from FSTrslHd
          Where RefNbr like @parm1
          Order by RefNbr




GO
GRANT CONTROL
    ON OBJECT::[dbo].[TrslHdr_RefNbr] TO [MSDSL]
    AS [dbo];

