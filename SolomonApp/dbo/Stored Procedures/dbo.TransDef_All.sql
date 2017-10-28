 /****** Object:  Stored Procedure dbo.TransDef_All    Script Date: 4/7/98 12:45:04 PM ******/
Create Proc TransDef_All @parm1 varchar ( 10) AS
     Select * from FSDefHdr
          Where TrslId like @parm1
          Order by TrslId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TransDef_All] TO [MSDSL]
    AS [dbo];

