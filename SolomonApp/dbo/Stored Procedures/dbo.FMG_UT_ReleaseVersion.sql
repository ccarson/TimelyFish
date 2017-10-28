 CREATE PROCEDURE FMG_UT_ReleaseVersion AS

--
-- Show the version of AR Release by scanning syscomments.
--
SELECT CASE WHEN (CHARINDEX("Step 100", text) > 0) THEN
               SUBSTRING(text, (CHARINDEX("Step 100:", text)), (CHARINDEX("Step 100:", text) + 40))
            ELSE
               ''
            END RevInfo
FROM syscomments
WHERE (id = object_id('pp_08400') AND CHARINDEX("Step 100:", text) > 0)

--
-- Show the version of AP Release by scanning syscomments.
--
SELECT CASE WHEN (CHARINDEX("Step 100", text) > 0) THEN
               SUBSTRING(text, (CHARINDEX("Step 100:", text)), (CHARINDEX("Step 100:", text) + 40))
            ELSE
               ''
            END RevInfo
FROM syscomments
WHERE (id = object_id('pp_03400') AND CHARINDEX("Step 100:", text) > 0)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_UT_ReleaseVersion] TO [MSDSL]
    AS [dbo];

