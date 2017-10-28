 CREATE PROCEDURE ED850Rpt_Extr2 @CpnyID varchar(10), @EDIPOId varchar(10), @InvtID varchar(30) AS
select a.EDIPOID, a.CpnyID, a.OrdNbr, b.invtid, sum(b.QtyOrd) 'QtyOrd', sum(b.CurySlsPrice) 'SlsPrice', a.Cancelled, sum(b.CuryTotOrd) 'TotOrd'
From SoHeader a, SOLine b
where a.cpnyid = @CpnyID and
a.EDIPOId = @EDIPOID and
b.invtid = @InvtID and
a.cpnyid = b.cpnyid and
a.ordnbr = b.ordnbr and
a.cancelled = '0'
group by a.cpnyid, a.edipoid,  b.invtid, a.ordnbr,  a.Cancelled



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Rpt_Extr2] TO [MSDSL]
    AS [dbo];

