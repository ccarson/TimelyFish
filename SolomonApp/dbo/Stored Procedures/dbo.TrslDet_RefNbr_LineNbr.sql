 /****** Object:  Stored Procedure dbo.TrslDet_RefNbr_LineNbr    Script Date: 4/7/98 12:45:04 PM ******/
Create Proc TrslDet_RefNbr_LineNbr @parm1 varchar ( 10), @parm2beg smallint, @parm2end smallint AS
     Select * from FSTrslDet
          Where RefNbr = @parm1
          and   LineNbr between @parm2beg and @parm2end
          Order by RefNbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TrslDet_RefNbr_LineNbr] TO [MSDSL]
    AS [dbo];

