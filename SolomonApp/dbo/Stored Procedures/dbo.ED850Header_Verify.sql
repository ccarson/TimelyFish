 Create Proc ED850Header_Verify @ISANbr int, @STNbr int, @CustId varchar(15) As
Select Count(*) From ED850Header A Inner Join ED850HeaderExt B On A.CpnyId = B.CpnyId And
  A.EDIPOID = B.EDIPOID Where A.CustId = @CustId And B.ISANbr = @ISANbr And
  B.STNBr = @STNbr


