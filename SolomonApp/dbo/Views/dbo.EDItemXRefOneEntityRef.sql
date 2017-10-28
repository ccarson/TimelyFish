 

CREATE View EDItemXRefOneEntityRef As
Select InvtId, Max(AlternateId) 'AlternateId', AltIdType, EntityId 
From ItemXRef Where EntityId <> '*'
Group By InvtId, EntityId, AltIdType

 
