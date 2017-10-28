 Create Proc ED850Header_Unposted As select * from ED850Header where UpdateStatus = 'OK' Order By EDIPOID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Header_Unposted] TO [MSDSL]
    AS [dbo];

