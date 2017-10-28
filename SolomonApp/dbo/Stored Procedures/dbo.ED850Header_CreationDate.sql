 CREATE PROCEDURE ED850Header_CreationDate @FromDate smallint, @ToDate smallint

AS

Select * from ED850Header A, ED850HeaderExt B
where a.cpnyid = b.cpnyid and a.edipoid = b.edipoid
and b.CreationDate Between @FromDate and @ToDate
and ordnbr > ' '
order by a.EDIPOID


