 CREATE Proc EDShipper_Invoice @InvcNbr varchar(15) As
Select * From SOShipHeader Where InvcNbr Like @InvcNbr And LTrim(RTrim(InvcNbr)) <> '' Order By InvcNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipper_Invoice] TO [MSDSL]
    AS [dbo];

