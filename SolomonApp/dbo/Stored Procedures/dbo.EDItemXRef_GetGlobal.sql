 CREATE Proc EDItemXRef_GetGlobal @InvtId varchar(30), @AltIdType varchar(1) As
Select AlternateId From ItemXRef Where InvtId = @InvtId And AltIdType = @AltIdType And EntityId = '*'


