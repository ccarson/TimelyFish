Create Procedure CF303p_cftPGStatus_Status @parm1 varchar (2) as 
    Select * from cftPGStatus Where PGStatusId = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF303p_cftPGStatus_Status] TO [MSDSL]
    AS [dbo];

