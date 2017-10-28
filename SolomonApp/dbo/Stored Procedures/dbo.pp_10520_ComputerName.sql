 Create Proc pp_10520_ComputerName
            @Parm1 VARCHAR (21) As       -- ComputerName
-- Purge Work Records
    SELECT * FROM IN10520_Wrk
          WHERE ComputerName = @Parm1


