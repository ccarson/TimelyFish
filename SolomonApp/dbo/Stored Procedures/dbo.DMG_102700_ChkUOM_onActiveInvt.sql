 Create Procedure DMG_102700_ChkUOM_onActiveInvt
	/*Begin Parameters)*/
	@FromUnit varchar(6)
	/*En Parameters*/
as
Select * from Inventory where DfltPOUnit = @FromUnit or
                              DfltSOUnit = @FromUnit or
			      StkUnit = @FromUnit

Order by Invtid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_102700_ChkUOM_onActiveInvt] TO [MSDSL]
    AS [dbo];

