CREATE PROCEDURE WS_PJACTROL_DELETE
    @acct char(16), @fsyear_num char(4), @project char(16), @tstamp timestamp
AS
    BEGIN
     DELETE FROM [PJACTROL]
      WHERE [acct] = @acct AND 
            [fsyear_num] = @fsyear_num AND 
            [project] = @project AND 
            [tstamp] = @tstamp;
    END
