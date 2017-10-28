Create Procedure xCPSetUp_All as 
    Select * from xCPSetUp

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xCPSetUp_All] TO [MSDSL]
    AS [dbo];

