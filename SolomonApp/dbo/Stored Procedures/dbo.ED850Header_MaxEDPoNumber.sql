 CREATE PROCEDURE ED850Header_MaxEDPoNumber  AS
 Select max(edipoid) from ed850header



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Header_MaxEDPoNumber] TO [MSDSL]
    AS [dbo];

