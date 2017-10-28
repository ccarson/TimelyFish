
CREATE FUNCTION PJfMask_gl_subacct (@maskString VARCHAR(24), @sValue VARCHAR(24), @eValue VARCHAR(24), @pValue VARCHAR(24), @tValue VARCHAR(24))
RETURNS VARCHAR(24)
AS
BEGIN
    -- This function is dependent on the PJfMask() function and was written to facilitate inline application of the gl subacount wildcard masks
    -- in the project allocation method steps.
    return (convert(varchar(24), dbo.PJfMask(@maskString, @sValue, @eValue, @pValue, @tValue)))
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJfMask_gl_subacct] TO [MSDSL]
    AS [dbo];

