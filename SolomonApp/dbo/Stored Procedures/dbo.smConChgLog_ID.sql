 CREATE PROCEDURE smConChgLog_ID @parm1 varchar(10), @parm2beg int, @parm2end int AS
        SELECT *
          FROM smConChgLog
         WHERE ContractID  LIKE @parm1
           AND RecordID between @parm2beg and @parm2end
      ORDER BY ContractID,
               ChangedDate DESC,
               ChangedTime DESC,
               RecordID    DESC


