 CREATE PROCEDURE EDShipment_allDMG @BOLNbr varchar(20) As
Select * From EDShipment Where BOLNbr Like @BOLNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipment_allDMG] TO [MSDSL]
    AS [dbo];

