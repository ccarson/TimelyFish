 Create Procedure pjinvdet_spk9  as
select * from
pjinvdet
Where SOURCE_TRX_ID = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvdet_spk9] TO [MSDSL]
    AS [dbo];

