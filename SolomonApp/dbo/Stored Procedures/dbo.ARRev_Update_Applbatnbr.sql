 /****** Object:  Stored Procedure dbo.ARRev_Update_Applbatnbr    Script Date: 11/12/00 12:30:32 PM ******/
CREATE PROC ARRev_Update_Applbatnbr @parm1 varchar (10), @parm2 varchar ( 15),
            @parm3 varchar ( 2), @parm4 varchar ( 10), @parm5 varchar (10) AS
UPDATE ARDOC
   SET applbatnbr = @parm1
 WHERE applbatnbr = "" AND
       Custid = @parm2 AND
       Doctype = @parm3 AND
       Refnbr = @parm4 AND
       Batnbr = @parm5



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARRev_Update_Applbatnbr] TO [MSDSL]
    AS [dbo];

