 Create Procedure ItemXRef_InvtID_Type_Ent_AltId @Parm1 varchar ( 30), @Parm2 varchar ( 1), @Parm3 varchar ( 15), @Parm4 varchar (30) As
	Select * from ItemXRef
             Where InvtID         = @Parm1
               And AltIDType   Like @Parm2
               And EntityID    Like @Parm3
               And AlternateId Like @Parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemXRef_InvtID_Type_Ent_AltId] TO [MSDSL]
    AS [dbo];

