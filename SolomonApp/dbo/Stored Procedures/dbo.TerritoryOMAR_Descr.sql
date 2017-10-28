 Create Proc TerritoryOMAR_Descr @parm1 varchar (10) as
    Select Descr from Territory where Territory = @parm1 order by Territory



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TerritoryOMAR_Descr] TO [MSDSL]
    AS [dbo];

