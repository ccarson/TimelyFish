

CREATE Procedure [dbo].[CF041p_APDoc_PO] 
@VendID varchar (15), 
@PONbr varchar(10)
as 
Select distinct ap.* 
from APDoc ap (nolock)	-- added nolock hint 201303 sripley
left join APTRAN tr (nolock)on ap.[RefNbr] = tr.[RefNbr]	-- added nolock hint 201303 sripley
Where ap.VendID = @VendID
AND tr.PONbr = @PONbr
Order by ap.VendID, InvcNbr 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF041p_APDoc_PO] TO [MSDSL]
    AS [dbo];

