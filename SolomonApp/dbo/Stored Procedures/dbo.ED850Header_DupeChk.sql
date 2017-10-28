 CREATE Proc ED850Header_DupeChk @CustId varchar(15), @PONbr varchar(30), @GSNbr int, @STNbr int, @IsaNbr int As
Select A.EDIPOID From ED850Header A Inner Join ED850HeaderExt B On A.CpnyId = B.CpnyId And
A.EDIPOID = B.EDIPOID Where A.CustId = @CustId And A.PONbr = @PONbr And B.GSNbr = @GSNbr And
B.STNbr = @STNbr And B.ISANbr = @ISANbr


