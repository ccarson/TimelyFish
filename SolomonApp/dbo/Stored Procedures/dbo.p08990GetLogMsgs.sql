 Create proc p08990GetLogMsgs as

Select * from WrkIChk order by custid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990GetLogMsgs] TO [MSDSL]
    AS [dbo];

