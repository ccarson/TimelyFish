 CREATE PROCEDURE smConMisc_applied @parm1 varchar(10) AS
          SELECT *
            FROM smConMisc
           WHERE ContractID like @parm1
             AND Status = 'I'
             AND ARBatnbr <> ''
        ORDER BY BatNbr,
                 LineNbr


