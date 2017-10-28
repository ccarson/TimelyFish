 Create Proc EDGetNonPostProject As
Select Control_data From PJContrl Where Control_Code= 'NO-POST-PROJECT'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDGetNonPostProject] TO [MSDSL]
    AS [dbo];

