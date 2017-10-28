 Create Proc pp_10550_Return
            @UserAddress VARCHAR (21) As       -- ComputerName
-- Purge Work Records
    SELECT * FROM IN10550_Return
          WHERE ComputerName = @UserAddress



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_10550_Return] TO [MSDSL]
    AS [dbo];

