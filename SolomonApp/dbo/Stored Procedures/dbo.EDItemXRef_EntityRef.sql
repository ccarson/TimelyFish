 Create Proc EDItemXRef_EntityRef @InvtId varchar(30), @AltIdType varchar(1), @EntityId varchar(15) As
Select AlternateId From ItemXRef Where InvtId = @InvtId And AltIdType = @AltIdType And EntityId = @EntityId


