 CREATE PROCEDURE EDDataElement_CAD01 @parm1 varchar(15) AS
SELECT *
FROM EDDataElement
WHERE segment = 'CAD' and position = '01' and code like @parm1
ORDER BY segment, position, code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_CAD01] TO [MSDSL]
    AS [dbo];

