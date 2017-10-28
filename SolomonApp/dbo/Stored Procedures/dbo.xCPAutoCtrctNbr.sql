Create Procedure xCPAutoCtrctNbr as 
    Select LastCtrNbr from xCPSetUp  

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xCPAutoCtrctNbr] TO [MSDSL]
    AS [dbo];

