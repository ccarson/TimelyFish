 create procedure pp_20202GetNSFDocs
@CpnyID char(10),
@acct char(10),
@sub char(24),
@trandate smalldatetime,
@pernbr char(6)

as
  select * from ardoc d
   where  d.cpnyid = @cpnyid and
          d.doctype = 'NS' and
          d.rlsed = 1 and
          d.PerEnt = @pernbr and
          d.docdate = @trandate and
          d.refnbr in (
             select distinct refnbr  from artran t
             where t.acct = @acct and
                   t.sub = @sub and
                   t.cpnyid = @cpnyid and
                   t.custid = d.custid and
                   t.PerEnt = @pernbr and
                   t.trantype = 'NS' and
                   t.trandate = @trandate)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_20202GetNSFDocs] TO [MSDSL]
    AS [dbo];

