 Create Proc EDShipment_ResetASN @BOLNbr varchar(20) As
Update EDShipment Set SendASN = 1 Where BOLNbr = @BOLNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipment_ResetASN] TO [MSDSL]
    AS [dbo];

