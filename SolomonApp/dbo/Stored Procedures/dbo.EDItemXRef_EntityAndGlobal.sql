 CREATE Proc EDItemXRef_EntityAndGlobal @InvtId varchar(30), @EntityId varchar(15) As
Select AltIdType, AlternateId From ItemXRef Where InvtId = @InvtId And EntityId = @EntityId
Union
Select AltIdType, AlternateId From ItemXRef Where InvtId = @InvtId And EntityId = '*' And
AltIdType Not In (Select AltIdType From ItemXRef Where InvtId = @InvtId And EntityId = @EntityId)


