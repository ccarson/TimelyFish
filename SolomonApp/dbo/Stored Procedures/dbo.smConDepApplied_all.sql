 CREATE PROCEDURE smConDepApplied_all @parm1 varchar(10), @parm2 smallint, @parm3 int, @parm4 int AS
        SELECT *
          FROM smConDepApplied
         WHERE BatNbr      = @parm1
           AND LineNbr     = @parm2
           AND RecordID between @parm3 and @parm4
      ORDER BY BatNbr,
               LineNbr,
               RecordID


