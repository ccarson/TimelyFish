 Create Proc ED850Header_ResetAllOK As
Update ED850Header Set UpdateStatus = 'OK' Where UpdateStatus = 'IN'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Header_ResetAllOK] TO [MSDSL]
    AS [dbo];

