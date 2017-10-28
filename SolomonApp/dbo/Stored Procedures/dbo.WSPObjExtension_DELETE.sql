CREATE PROCEDURE WSPObjExtension_DELETE
                @SLObjID char(60),
                @SLTypeID smallint,
                @tstamp timestamp
                AS
                BEGIN
                DELETE FROM [WSPObjExtension]
                WHERE [SLObjID] = @SLObjID AND 
                [SLTypeID] = @SLTypeID AND 
                [tstamp] = @tstamp;
                End
