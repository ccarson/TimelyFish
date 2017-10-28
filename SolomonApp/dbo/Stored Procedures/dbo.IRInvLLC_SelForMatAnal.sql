 CREATE procedure IRInvLLC_SelForMatAnal AS
if not exists (select * from sysobjects where id = object_id(N'[dbo].[IRCEPRestrict]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	Select * from IRInvLLC order by LowLevelCode
Else
	If (select count(*) from IRCepRestrict) > 0
		Select * from IRInvLLC where exists (Select * from IRCepRestrict where IRCepRestrict.InvtId = IRInvLLC.InvtId) order by LowLevelCode
	Else
		Select * from IRInvLLC order by LowLevelCode


