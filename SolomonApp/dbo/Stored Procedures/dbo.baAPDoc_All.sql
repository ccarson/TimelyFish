Create Procedure baAPDoc_All  as 
    Select * from APDoc

GO
GRANT CONTROL
    ON OBJECT::[dbo].[baAPDoc_All] TO [MSDSL]
    AS [dbo];

