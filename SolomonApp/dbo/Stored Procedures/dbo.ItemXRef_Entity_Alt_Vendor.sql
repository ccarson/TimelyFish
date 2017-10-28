 /****** Object:  Stored Procedure dbo.ItemXRef_Entity_Alt_Vendor    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.ItemXRef_Entity_Alt_Vendor    Script Date: 4/16/98 7:41:52 PM ******/
Create Procedure ItemXRef_Entity_Alt_Vendor @parm1 varchar ( 15), @parm2 varchar ( 01), @parm3 varchar ( 30) As
        Select * from ItemXRef where
                ((EntityID = @parm1 And AltIDType = @parm2)
                or AltIDType In ('G','O','M')) And
                AlternateID Like @parm3
        Order By AltIDType Desc,EntityID, AlternateID


