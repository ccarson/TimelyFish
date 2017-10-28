 CREATE PROCEDURE EDDataElement_ElementDesc @Code varchar(5) AS
Select Code, Description From EDDataElement Where ((Segment = 'ITA' And Position = '02') Or (Segment = 'SAC' And Position = '04')) And Code Like @Code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_ElementDesc] TO [MSDSL]
    AS [dbo];

