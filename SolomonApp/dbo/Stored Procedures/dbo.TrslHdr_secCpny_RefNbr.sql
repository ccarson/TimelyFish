
Create Proc TrslHdr_secCpny_RefNbr @parm1 varchar (47), @parm2 varchar (10)
 WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
 AS
Select distinct FSTrslHd.* from FSTrslHd 
	join vs_share_secCpny v on FSTrslHd.CpnyID = v.cpnyid
	where v.scrn = '25630'
	and v.userid = @parm1
	and RefNbr like @parm2
	Order by RefNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[TrslHdr_secCpny_RefNbr] TO [MSDSL]
    AS [dbo];

