Create Procedure ItemXRef_Invt_Type_Entity @parm1 varchar ( 30), @parm2 varchar ( 01), @parm3 varchar ( 15) As
        Select * from ItemXRef where
                InvtID Like @parm1 And
                ((AltIDType Like @parm2 And EntityID Like @parm3)
		 		or AltIDType Not In ('C', 'V'))
        Order By InvtID, Case When AltIDType In ('C','V') Then 0 Else 1 End, AltIDType, AlternateID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemXRef_Invt_Type_Entity] TO [MSDSL]
    AS [dbo];

