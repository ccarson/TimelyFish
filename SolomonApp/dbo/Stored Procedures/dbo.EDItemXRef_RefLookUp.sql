 Create Proc EDItemXRef_RefLookUp @AlternateId varchar(30), @EntityId varchar(15), @AltIdType varchar(1) As
Select InvtId From ItemXRef Where AlternateId = @AlternateId And EntityId In ('*',@EntityId) And AltIdType = AltIdType
Order By EntityId Desc


