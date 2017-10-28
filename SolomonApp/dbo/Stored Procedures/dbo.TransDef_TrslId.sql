 /****** Object:  Stored Procedure dbo.TransDef_TrslId    Script Date: 4/7/98 12:45:04 PM ******/
Create Proc TransDef_TrslId @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 varchar ( 10), @parm5 varchar ( 24) AS
     Select * From FSDefDet
          Where TrslId = @parm1
          and   BegAcctRange like @parm2
          and   BegSubRange  like @parm3
          and   EndAcctRange like @parm4
          and   EndSubRange  like @parm5
          Order by TrslId, BegAcctRange, BegSubRange, EndAcctRange, EndSubRange



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TransDef_TrslId] TO [MSDSL]
    AS [dbo];

