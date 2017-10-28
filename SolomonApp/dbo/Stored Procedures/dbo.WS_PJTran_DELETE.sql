CREATE PROCEDURE WS_PJTran_DELETE
    @batch_id char(10), @detail_num int, @fiscalno char(6), 
    @system_cd char(2), @tstamp timestamp
AS
    BEGIN
     DELETE FROM [PJTran]
      WHERE [batch_id] = @batch_id AND 
            [detail_num] = @detail_num AND 
            [fiscalno] = @fiscalno AND 
            [system_cd] = @system_cd AND 
            [tstamp] = @tstamp;
    END
