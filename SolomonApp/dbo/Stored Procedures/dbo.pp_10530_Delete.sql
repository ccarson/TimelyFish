 Create Proc pp_10530_Delete
            @UserAddress VARCHAR (21) As       -- ComputerName
-- Purge Work Records
    DELETE FROM IN10530_Wrk
          WHERE ComputerName = @UserAddress


