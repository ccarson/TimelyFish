CREATE PROCEDURE WSPPubDocLib_DELETE
                @DocumentID smallint,
                @SLObjID char(60),
                @SLTypeID smallint,
                @tstamp timestamp
                AS
                BEGIN
                DELETE FROM [WSPPubDocLib]
                WHERE [DocumentID] = @DocumentID AND 
                [SLObjID] = @SLObjID AND 
                [SLTypeID] = @SLTypeID AND 
                [tstamp] = @tstamp;
                End
