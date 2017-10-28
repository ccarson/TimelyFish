

CREATE Proc [dbo].[VFDMed_All] as
    SELECT IDVFDMed, NameSelect FROM cft_VFDMed




GO
GRANT CONTROL
    ON OBJECT::[dbo].[VFDMed_All] TO [MSDSL]
    AS [dbo];

