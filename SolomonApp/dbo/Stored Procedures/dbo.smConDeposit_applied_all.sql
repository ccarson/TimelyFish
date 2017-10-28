 CREATE PROCEDURE smConDeposit_applied_all @parm1 varchar(10) AS
          SELECT *
            FROM smConDeposit d
      INNER JOIN smConDepApplied da
              ON d.BatNbr      =    da.BatNbr
             AND d.LineNbr     =    da.LineNbr
           WHERE d.ContractID  like @parm1
             AND da.AmtApplied <>   0
        ORDER BY da.BatNbr,
                 da.LineNbr,
                 da.RecordID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConDeposit_applied_all] TO [MSDSL]
    AS [dbo];

