 CREATE Proc EDItemXRef_LookUp @Parm1 varchar(1), @Parm2 varchar(30), @Parm3 varchar(10) As
Select A.InvtId From ItemXRef A, Inventory B Where A.AltIdType = @Parm1 And A.AlternateId = @Parm2
And A.InvtId = B.InvtId And B.TranStatusCode IN ('AC','NP','OH')


