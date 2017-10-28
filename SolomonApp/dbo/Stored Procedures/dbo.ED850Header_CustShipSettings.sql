 CREATE Proc ED850Header_CustShipSettings @CpnyId varchar(10), @EDIPOID varchar(10) As
Select B.MultiDestMeth, B.SepDestOrd From ED850Header A Inner Join CustomerEDI B On A.CustId =
B.CustId Where A.CpnyId = @CpnyId And A.EDIPOID = @EDIPOID


