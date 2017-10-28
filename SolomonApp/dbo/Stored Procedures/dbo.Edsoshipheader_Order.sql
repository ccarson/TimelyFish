 CREATE PROCEDURE Edsoshipheader_Order @FromDate smalldatetime, @ToDate smalldatetime AS
select soshipheader.ordnbr, soshipheader.cpnyid, soshipheader.invcnbr, edsoshipheader.lastedidate, soshipheader.custid,
 soshipheader.custordnbr, soshipheader.orddate,edsoshipheader.shipperid
from soshipheader, edsoshipheader
where soshipheader.shipperid = edsoshipheader.shipperid and soshipheader.cpnyid = edsoshipheader.cpnyid
and edsoshipheader.lastedidate >= @FromDate and edsoshipheader.lastedidate <= @ToDate
order by edsoshipheader.lastedidate desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Edsoshipheader_Order] TO [MSDSL]
    AS [dbo];

