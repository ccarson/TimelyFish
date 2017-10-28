 Create Proc pp_10550_ComputerName
            @UserAddress VARCHAR (21) As       -- ComputerName
-- Purge Work Records
    SELECT * FROM IN10550_Wrk
          WHERE ComputerName = @UserAddress



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_10550_ComputerName] TO [MSDSL]
    AS [dbo];

