 CREATE Proc ED810Header_ErrorStatus As
Select * From ED810Header Where UpdateStatus Not In ('IC','IN','OK','LM','H')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810Header_ErrorStatus] TO [MSDSL]
    AS [dbo];

