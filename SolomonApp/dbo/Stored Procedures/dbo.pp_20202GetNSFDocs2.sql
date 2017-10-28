 CREATE PROCEDURE pp_20202GetNSFDocs2
        @CpnyID char(10),
        @acct char(10),
        @sub char(24),
        @pernbr char(6),
        @begdate smalldatetime,
        @enddate smalldatetime

AS
  SELECT * FROM ARDoc d
   WHERE  d.cpnyid = @cpnyid and
          d.doctype in ('NS','RP') and
          d.rlsed = 1 and
          d.PerEnt = @pernbr and
          d.docdate between @begdate and @enddate and
          d.refnbr in (
             SELECT DISTINCT refnbr  FROM artran t
             WHERE t.acct = @acct and
                   t.sub = @sub and
                   t.cpnyid = @cpnyid and
                   t.PerEnt = @pernbr and
                   t.trantype in ('NS','RP') and
                   t.trandate between @begdate and @enddate)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_20202GetNSFDocs2] TO [MSDSL]
    AS [dbo];

