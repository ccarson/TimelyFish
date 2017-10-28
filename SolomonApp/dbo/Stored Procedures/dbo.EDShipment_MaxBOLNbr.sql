 Create Procedure EDShipment_MaxBOLNbr
As
Select
	Max(BOLNbr) As 'MaxBOLNbr'
From
	EDShipment


GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipment_MaxBOLNbr] TO [MSDSL]
    AS [dbo];

