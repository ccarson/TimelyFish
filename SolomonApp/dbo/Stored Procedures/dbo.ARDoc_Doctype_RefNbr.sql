 /****** Object:  Stored Procedure dbo.ARDoc_Doctype_RefNbr    Script Date: 4/7/98 12:30:33 PM ******/
CREATE PROC ARDoc_Doctype_RefNbr @parm1 varchar ( 10), @parm2 varchar ( 10) as
    SELECT *
      FROM ardoc
     WHERE CpnyId = @parm1 AND
           doctype IN ('FI', 'IN', 'DM', 'NC') AND
           Rlsed = 1 AND
           refnbr LIKE @parm2
     ORDER BY CpnyId, Doctype, Refnbr


