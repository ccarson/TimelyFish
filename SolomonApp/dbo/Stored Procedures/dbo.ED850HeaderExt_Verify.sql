 Create Proc ED850HeaderExt_Verify @ISANbr int, @STNbr int As
Select Count(*) From ED850HeaderExt Where ISANbr = @ISANbr And STNbr = @STNbr


