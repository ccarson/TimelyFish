 CREATE  Procedure IRInvLLC_BuildLLC AS
Set NoCount On
Declare @InvtID VarChar(30)
Declare @LLC smallint
-- Clear table, so know every item will be considered
Delete from IRInvLLC
-- Initial load.  Mark all items as needing review, and do for EVERY item (At this point)
Insert into IRInvLLC
	Select
		GetDate() 'Crtd_Datetime',
		'IRLLCCA' 'Crtd_Prog',
		'IRLLCCA' 'Crtd_User',
		'01/01/1900' 'Lupd_Datetime',
		'IRLLCCA' 'Lupd_Prog',
		'IRLLCCA' 'Lupd_User',
		InvtId 'InvtId',
		0 'LowLevelCode',
		0 'NeedsExplosion',
		1 'NeedsReview',
		' ' 'S4Future01',
		' ' 'S4Future02',
		0.0 'S4Future03',
		0.0 'S4Future04',
		0.0 'S4Future05',
		0.0 'S4Future06',
		'01/01/1900' 'S4Future07',
		'01/01/1900' 'S4Future08',
		0 'S4Future09',
		0 'S4Future10',
		' ' 'S4Future11',
		' ' 'S4Future12',
		' ' 'User1',
		'01/01/1900' 'User10',
		' ' 'User2',
		' ' 'User3',
		' ' 'User4',
		0.0 'User5',
		0.0 'User6',
		' ' 'User7',
		' ' 'User8',
		'01/01/1900' 'User9',
		Null
			from Inventory

-- Now go though and update items that need it
While Exists (Select * from IRInvLLC where NeedsReview = 1)
Begin
	Select Top 1 @InvtId = InvtId, @LLC = LowLevelCode from IRInvLLC where NeedsReview = 1
	If @LLC < 90				-- Short circuit, if get to 90 levels deep, a loop of some type exists
	Begin
		If Exists (Select * from Component where KitId = @InvtId)
		Begin
			-- Mark components as needing to be re-checked
-- CEP-Future - Should check which of the below performs faster, with the limited data I have here, speed appears to be the same
--			Update IRInvLLC Set NeedsReview = 1, LowLevelCode = (@LLC + 1) where LowLevelCode <= (@LLC) and IRInvLLC.InvtId In (Select CmpnentId  from Component where KitId = @InvtId)
			Update IRInvLLC Set NeedsReview = 1, LowLevelCode = (@LLC + 1) where LowLevelCode <= (@LLC) and exists (Select * from Component where KitId = @InvtId and CmpnentId = IRInvLLC.InvtId)
			-- Mark this item as needing explosion, for future calculations
			UPDATE IRInvLLC SET NeedsExplosion = 1 WHERE InvtId = @InvtId
		End

	End
	UPDATE IRInvLLC SET NeedsReview = 0 WHERE InvtId = @InvtId
End
Set NoCount Off


