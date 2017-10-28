 Create Procedure WOPJDOCNUM_TRAN
AS
   SELECT      LastUsed_Tran
   FROM        PJdocnum
   WHERE       id = '16'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJDOCNUM_TRAN] TO [MSDSL]
    AS [dbo];

