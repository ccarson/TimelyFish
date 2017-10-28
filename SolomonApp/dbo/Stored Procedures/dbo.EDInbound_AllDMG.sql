 /****** Object:  Stored Procedure dbo.EDInbound_All    Script Date: 5/28/99 1:17:42 PM ******/
CREATE Proc EDInbound_AllDMG @Parm1 varchar(15), @Parm2 varchar(3) As Select * From EDInbound
Where Custid = @Parm1 And Trans Like @Parm2 Order By Custid, Trans


