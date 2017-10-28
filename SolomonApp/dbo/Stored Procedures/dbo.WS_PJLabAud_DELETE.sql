
    CREATE PROCEDURE WS_PJLabAud_DELETE @docnbr char(10), @linenbr smallint, @zaudit_seq int, @tstamp timestamp
    AS
      BEGIN
          DELETE FROM [pjlabaud]
           WHERE [docnbr] = @docnbr AND 
                 [linenbr] = @linenbr AND 
                 [zaudit_seq] = @zaudit_seq AND 
                 [tstamp] = @tstamp;
       END
            
