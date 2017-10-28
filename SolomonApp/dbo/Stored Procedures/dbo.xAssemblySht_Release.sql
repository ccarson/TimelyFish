Create Procedure xAssemblySht_Release as 
    Select * from xAssemblySht Where Rlsed = 0 and HoldFlg = 0
	Order by AsyNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xAssemblySht_Release] TO [MSDSL]
    AS [dbo];

