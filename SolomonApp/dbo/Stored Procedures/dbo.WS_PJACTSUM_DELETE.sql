CREATE PROCEDURE WS_PJACTSUM_DELETE
    @acct char(16), @fsyear_num char(4), @pjt_entity char(32),
    @project char(16), @tstamp timestamp
AS
    BEGIN
     DELETE FROM [PJACTSUM]
      WHERE [acct] = @acct AND 
            [fsyear_num] = @fsyear_num AND 
            [pjt_entity] = @pjt_entity AND 
            [project] = @project AND 
            [tstamp] = @tstamp;
    END
