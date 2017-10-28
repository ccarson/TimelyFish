Create Procedure ItemXRef_Entity_Alt @parm1 varchar ( 15), @parm2 varchar ( 01), @parm3 varchar ( 30) As
        Select * from ItemXRef where
                ((EntityID = @parm1 And AltIDType = @parm2)
                or AltIDType Not In ('C', 'V')) And
                AlternateID Like @parm3
        Order By InvtID, Case When AltIDType In ('C','V') Then 0 Else 1 End, AltIDType, AlternateID


