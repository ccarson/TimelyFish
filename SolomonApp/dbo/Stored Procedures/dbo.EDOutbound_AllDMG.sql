 CREATE Proc EDOutbound_AllDMG @Parm1 varchar(15), @Parm2 varchar(3) As
Select * From EDOutbound Where CustId = @Parm1 And Trans Like @Parm2
Order By Custid, Trans


