Create Procedure CF520p_PJDocNum_ChargH as 
    Select * from PJDocNum Where Id = 14

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF520p_PJDocNum_ChargH] TO [MSDSL]
    AS [dbo];

