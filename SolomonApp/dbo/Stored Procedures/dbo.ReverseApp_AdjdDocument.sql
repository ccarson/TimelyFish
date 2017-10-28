 /****** Object:  Stored Procedure dbo.ReverseApp_AdjdDocument    Script Date: 4/7/98 12:30:32 PM ******/
Create Procedure ReverseApp_AdjdDocument @parm1 varchar ( 15),
                                         @parm2 varchar ( 10),
                                         @parm3 varchar (2) AS
  SELECT *
    FROM ARDoc
   WHERE Custid = @parm1 AND
         Refnbr = @parm2 AND
         Doctype = @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ReverseApp_AdjdDocument] TO [MSDSL]
    AS [dbo];

