 Create Procedure pjlabaud_spk9  as
select * from
pjlabaud
Where zAUDIT_SEQ = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjlabaud_spk9] TO [MSDSL]
    AS [dbo];

