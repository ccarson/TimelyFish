 

CREATE View EDItemXRef_MaxGlobal As
Select InvtId, Max(AlternateId) 'AlternateId', AltIdType From ItemXRef Where EntityId = '*' Group By InvtId, AltIdType

 
