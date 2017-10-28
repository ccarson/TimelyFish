 Create Proc Delete_INTran_Only_BatNbr @parm1 varchar ( 10) as
  -- sg 12/23/00 - for BOM purposes, cannot delete lotsert info as well because it is left in the table during component update,
  -- even without the INTran records.
   -- Exec Delete_LotSerT_BatNbr @Parm1

    Delete INTran from INTran where BatNbr = @parm1 and Rlsed = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_INTran_Only_BatNbr] TO [MSDSL]
    AS [dbo];

