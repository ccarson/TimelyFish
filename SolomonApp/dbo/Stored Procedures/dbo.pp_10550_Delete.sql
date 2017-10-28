 Create Proc pp_10550_Delete
            @UserAddress VARCHAR (21) As       -- ComputerName
-- Purge Work Records
    DELETE FROM IN10550_Wrk
          WHERE ComputerName = @UserAddress



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_10550_Delete] TO [MSDSL]
    AS [dbo];

