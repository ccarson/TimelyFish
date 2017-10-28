
CREATE FUNCTION PJfMask_pjt_entity (@maskString VARCHAR(32), @sValue VARCHAR(32))
RETURNS VARCHAR(32)
AS
BEGIN
    -- This function is dependent on the PJfMask_s() function and was written to facilitate inline application of the project task wildcard masks
    -- in the project allocation method steps.
    return (convert(varchar(32), dbo.PJfMask_s(@maskString, @sValue)))
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJfMask_pjt_entity] TO [MSDSL]
    AS [dbo];

