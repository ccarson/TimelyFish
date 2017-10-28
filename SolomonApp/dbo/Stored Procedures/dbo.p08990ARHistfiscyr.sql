 Create proc p08990ARHistfiscyr As

SELECT min(fiscyr) FROM ARHIST



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990ARHistfiscyr] TO [MSDSL]
    AS [dbo];

