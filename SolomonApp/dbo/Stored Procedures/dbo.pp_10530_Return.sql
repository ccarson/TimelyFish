 Create Proc pp_10530_Return
            @UserAddress VARCHAR (21),	-- ComputerName
	    @CpnyID VARCHAR(10)	As   	-- Company ID
-- Purge Work Records
/*	Since the IN10530_Return table does not have a CpnyID field, we will use
	ErrorInvtID for now.  This field is not populated by any of the 10530 routines
*/
    Select * FROM IN10530_Return
          WHERE ((ComputerName = @UserAddress and ErrorInvtID = @CpnyID)
		 OR (ComputerName = @UserAddress and RTrim(ErrorInvtID) = ''))



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_10530_Return] TO [MSDSL]
    AS [dbo];

