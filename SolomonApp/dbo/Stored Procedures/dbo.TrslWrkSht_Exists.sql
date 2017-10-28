 /****** Object:  Stored Procedure dbo.TrslWrkSht_Exists    Script Date: 4/7/98 12:45:04 PM ******/
Create Proc TrslWrkSht_Exists @parm1 varchar ( 10), @parm2 varchar ( 6) AS
     Select * from FSTrslHd
          Where TrslId  = @parm1
          and   PerPost like @parm2
          Order by TrslId DESC, PerPost DESC, RefNbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TrslWrkSht_Exists] TO [MSDSL]
    AS [dbo];

