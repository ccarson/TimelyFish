Create Procedure pXF100_cftFOSetup_All as 
    Select * from cftFOSetUp

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF100_cftFOSetup_All] TO [MSDSL]
    AS [dbo];

