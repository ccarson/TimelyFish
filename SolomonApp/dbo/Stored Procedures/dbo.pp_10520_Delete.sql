 Create Proc pp_10520_Delete
            @Parm1 VARCHAR (21) As       -- ComputerName
-- Purge Work Records
    DELETE FROM IN10520_Wrk
          WHERE ComputerName = @Parm1


