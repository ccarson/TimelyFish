
CREATE FUNCTION PJfMask_cpnyid (@maskString VARCHAR(10), @sValue VARCHAR(10), @eValue VARCHAR(10), @pValue VARCHAR(10))
RETURNS VARCHAR(10)
AS
BEGIN
    -- This function is dependent on the PJfMask() function and was written to facilitate inline application of the company id wildcard masks
    -- in the project allocation method steps.
    return (convert(varchar(10), dbo.PJfMask(@maskString, @sValue, @eValue, @pValue, space(0))))
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJfMask_cpnyid] TO [MSDSL]
    AS [dbo];

