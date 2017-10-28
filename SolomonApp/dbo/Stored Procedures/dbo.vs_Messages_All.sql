
Create Procedure vs_Messages_All @parm1 integer  as
Select Msg1_Id, msgtext=convert(varchar(500),(convert(varbinary(500),substring(ZMsg_Text,3,500)))) from vs_Messages where Msg1_ID = @parm1 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[vs_Messages_All] TO [MSDSL]
    AS [dbo];

