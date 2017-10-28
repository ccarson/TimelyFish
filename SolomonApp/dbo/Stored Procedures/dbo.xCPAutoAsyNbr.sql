Create Procedure xCPAutoAsyNbr as 
    Select LastAsyNbr from xCPSetUp  

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xCPAutoAsyNbr] TO [MSDSL]
    AS [dbo];

