CREATE PROCEDURE WS_PJTranWk_DELETE
    @batch_id char(10), @detail_num int, @fiscalno char(6), 
    @project char(16), @system_cd char(2), @alloc_batch char(10),
    @tstamp timestamp
AS
    BEGIN
     DELETE FROM [PJTranWk]
      WHERE [batch_id] = @batch_id AND 
            [detail_num] = @detail_num AND 
            [fiscalno] = @fiscalno AND 
            [project] = @project AND 
            [system_cd] = @system_cd AND 
            [alloc_batch] = @alloc_batch AND 
            [tstamp] = @tstamp;
    END
