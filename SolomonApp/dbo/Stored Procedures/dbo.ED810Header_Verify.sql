 CREATE Proc ED810Header_Verify @ISANbr int, @STNbr int, @GSRcvId varchar(15), @GSSenderId varchar(15) As
Select Count(*) From ED810Header Where ISANbr = @ISANbr And STNbr = @STNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810Header_Verify] TO [MSDSL]
    AS [dbo];

