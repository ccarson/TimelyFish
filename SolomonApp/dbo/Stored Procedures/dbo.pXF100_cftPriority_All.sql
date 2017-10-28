Create Procedure pXF100_cftPriority_All as 
    Select * from cftPriority Order by Priority

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF100_cftPriority_All] TO [MSDSL]
    AS [dbo];

