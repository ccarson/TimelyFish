CREATE PROCEDURE WSPInstance_DELETE
                @SLTypeID smallint,
                @SLTypeDesc char(60),
                @tstamp timestamp
                AS
                BEGIN
                DELETE FROM [WSPInstance]
                WHERE [SLTypeID] = @SLTypeID AND 
                [SLTypeDesc] = @SLTypeDesc AND 
                [tstamp] = @tstamp;
                End

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSPInstance_DELETE] TO [MSDSL]
    AS [dbo];

