 Create Proc pp_10530_ComputerName
            @UserAddress VARCHAR (21) As       -- ComputerName
-- Purge Work Records
    Select * FROM IN10530_Wrk
          WHERE ComputerName = @UserAddress


