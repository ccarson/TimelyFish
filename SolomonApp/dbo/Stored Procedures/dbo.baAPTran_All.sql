Create Procedure baAPTran_All  as 
    Select * from APTran

GO
GRANT CONTROL
    ON OBJECT::[dbo].[baAPTran_All] TO [MSDSL]
    AS [dbo];

