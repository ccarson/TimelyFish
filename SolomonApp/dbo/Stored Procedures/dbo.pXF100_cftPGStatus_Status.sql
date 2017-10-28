Create Procedure pXF100_cftPGStatus_Status @parm1 varchar (2) as 
    Select * from cftPGStatus Where PGStatusId = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF100_cftPGStatus_Status] TO [MSDSL]
    AS [dbo];

