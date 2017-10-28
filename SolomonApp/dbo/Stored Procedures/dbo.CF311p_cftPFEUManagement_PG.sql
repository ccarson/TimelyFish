
CREATE  Procedure CF311p_cftPFEUManagement_PG @parm1 varchar (10) as 
    Select * from cftPFEUManagement Where PigGroupId = @parm1

