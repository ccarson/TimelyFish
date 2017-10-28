 create procedure DMG_PR_VendID_Valid
	@VendID		varchar(15)
as
		if (
		select	count(*)
		from 	Vendor (NOLOCK)
        	where 	VendID = @VendID
 		) = 0
			--select 0
			return 0	--Failure
		else
			--select 1
			return 1	--Success


