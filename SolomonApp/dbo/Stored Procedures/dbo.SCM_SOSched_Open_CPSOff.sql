 create proc SCM_SOSched_Open_CPSOff
as
	select		l.InvtID,
			s.SiteID

	from		SOSched s

	  		join	SOLine l
			on	s.CpnyID = l.CpnyID
	  		and	s.OrdNbr = l.OrdNbr
	  		and	s.LineRef = l.LineRef
	  		and 	l.Status = 'O'

	where		s.Status = 'O'

	group by	l.InvtID,
			s.SiteID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_SOSched_Open_CPSOff] TO [MSDSL]
    AS [dbo];

