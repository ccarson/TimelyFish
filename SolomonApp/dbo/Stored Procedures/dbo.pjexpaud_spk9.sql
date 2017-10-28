 Create Procedure pjexpaud_spk9  as
select * from
pjexpaud
Where zAUDIT_SEQ = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjexpaud_spk9] TO [MSDSL]
    AS [dbo];

