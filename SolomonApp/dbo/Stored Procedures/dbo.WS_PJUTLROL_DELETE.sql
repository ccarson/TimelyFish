CREATE PROCEDURE WS_PJUTLROL_DELETE
    @employee char(10), @fiscalno char(6),
    @utilization_type char(4), @tstamp timestamp
AS
    BEGIN
     DELETE FROM [PJUTLROL]
           WHERE [employee] = @employee AND 
                 [fiscalno] = @fiscalno AND 
                 [utilization_type] = @utilization_type AND 
                 [tstamp] = @tstamp;
    END
