 CREATE Proc EDItemXRef_LookUpEntity @Parm1 varchar(1), @Parm2 varchar(30), @Parm3 varchar(15) As
Select A.InvtId From ItemXRef A, Inventory B Where A.AltIdType = @Parm1 And A.AlternateId = @Parm2
And A.EntityId = @Parm3 And A.InvtId = B.InvtId And B.TranStatusCode IN ('AC','NP','OH')


