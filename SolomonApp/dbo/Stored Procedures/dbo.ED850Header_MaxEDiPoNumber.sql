 CREATE PROCEDURE ED850Header_MaxEDiPoNumber  AS
 Select max(edipoid) from ed850header



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Header_MaxEDiPoNumber] TO [MSDSL]
    AS [dbo];

