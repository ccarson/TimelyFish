 Create Procedure  pjchargh_sstat @parm1 varchar (10)  as
select * from pjchargh
	       where    batch_id LIKE @parm1
	          and     pjchargh.batch_status =  'B'
order by batch_id



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjchargh_sstat] TO [MSDSL]
    AS [dbo];

