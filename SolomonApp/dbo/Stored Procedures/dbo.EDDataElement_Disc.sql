 CREATE PROCEDURE EDDataElement_Disc @Code varchar(5) AS
Select * From EDDataElement Where ((Segment = 'ITA' And Position = '02') Or (Segment = 'SAC' And Position = '02')) And Code Like @Code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_Disc] TO [MSDSL]
    AS [dbo];

