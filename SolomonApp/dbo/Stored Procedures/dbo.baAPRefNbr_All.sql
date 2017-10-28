Create Procedure baAPRefNbr_All  as 
    Select * from APRefNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[baAPRefNbr_All] TO [MSDSL]
    AS [dbo];

