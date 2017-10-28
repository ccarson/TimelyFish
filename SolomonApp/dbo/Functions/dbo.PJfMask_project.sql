
CREATE FUNCTION PJfMask_project (@maskString VARCHAR(16), @sValue VARCHAR(16))
RETURNS VARCHAR(16)
AS
BEGIN
    -- This function is dependent on the PJfMask_s() function and was written to facilitate inline application of the project wildcard masks
    -- in the project allocation method steps.
    return (convert(varchar(16), dbo.PJfMask_s(@maskString, @sValue)))
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJfMask_project] TO [MSDSL]
    AS [dbo];

