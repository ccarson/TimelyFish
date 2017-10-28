
CREATE PROCEDURE WS_PJLABDIS_DELETE
	@dl_id08  SMALLDATETIME, @docnbr   CHAR(10), @hrs_type CHAR(4),@linenbr  SMALLINT,
    @status_2 CHAR(2),       @tstamp   TIMESTAMP
AS
  BEGIN
      DELETE FROM [PJLABDIS]
      WHERE  [dl_id08] = @dl_id08
             AND [docnbr] = @docnbr
             AND [hrs_type] = @hrs_type
             AND [linenbr] = @linenbr
             AND [status_2] = @status_2
             AND [tstamp] = @tstamp;
  END 
  

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJLABDIS_DELETE] TO [MSDSL]
    AS [dbo];

