 Create Proc EDItemXRef_GetUPC @InvtId varchar(30) As
Select AlternateId From ItemXRef Where InvtId = @InvtId And AltIdType = 'U'


