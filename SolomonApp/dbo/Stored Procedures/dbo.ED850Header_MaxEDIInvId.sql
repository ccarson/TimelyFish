 Create Proc ED850Header_MaxEDIInvId As
Select Max(EDIInvId) From ED810Header



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Header_MaxEDIInvId] TO [MSDSL]
    AS [dbo];

