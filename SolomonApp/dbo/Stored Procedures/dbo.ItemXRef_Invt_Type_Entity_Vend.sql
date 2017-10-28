
/****** Object:  Stored Procedure dbo.ItemXRef_Invt_Type_Entity_Vend    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.ItemXRef_Invt_Type_Entity_Vend    Script Date: 4/16/98 7:41:52 PM ******/
Create Procedure ItemXRef_Invt_Type_Entity_Vend @parm1 varchar ( 30), @parm2 varchar ( 01), @parm3 varchar ( 10) As
        Select * from ItemXRef where
                InvtID Like @parm1 And
                ((AltIDType Like @parm2 And EntityID Like @parm3)
		 		or AltIDType In ('G','O','M')) 
        Order By AltIDType Desc,InvtID,EntityID


