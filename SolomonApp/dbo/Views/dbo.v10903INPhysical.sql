Create VIEW v10903INPhysical
as
select *,

totadj = (select Count(*) from pidetail where piid = h.piid and bookqty <> physqty and status = 'E')

from piheader h

