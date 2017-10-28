 CREATE PROCEDURE EDShipment_Delete_BOL @BOLNbr varchar(20) AS
Delete From EDShipment
Where BOLNbr = @BOLNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipment_Delete_BOL] TO [MSDSL]
    AS [dbo];

