 Create Procedure pjlabdis_delete @parm1 varchar (06) as
delete from pjlabdis
where pjlabdis.fiscalno <= @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjlabdis_delete] TO [MSDSL]
    AS [dbo];

