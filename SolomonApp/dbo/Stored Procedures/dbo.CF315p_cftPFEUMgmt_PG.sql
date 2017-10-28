Create Procedure CF315p_cftPFEUMgmt_PG @parm1 varchar (10) as 
    Select * from cftPFEUMgmt Where PigGroupId = @parm1
