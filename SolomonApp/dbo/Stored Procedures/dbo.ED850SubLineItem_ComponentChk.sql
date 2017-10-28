 CREATE Proc ED850SubLineItem_ComponentChk @KitId varchar(30), @ComponentId varchar(30)
As
	Select A.CmpnentQty, B.StkUnit, B.ClassId
	From Component A Inner Join Inventory B On A.CmpnentId = B.InvtId
	Where A.KitId = @KitId And A.CmpnentId = @ComponentId


