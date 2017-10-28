
CREATE Procedure pXFWEMFile
AS

select '""' + RTrim(fo.OrdNbr) + '"",', '""' + RTrim(fo.InvtIdOrd) + '"",',
'""' + LTrim(Str(fo.QtyOrd)) + '"",', '""' + CONVERT(CHAR(10),fo.DateReq,101) + '"",',
'""' + RTrim(st.SiteID) + '"",', '""' + RTrim(fo.Comment) + '"",',
'""' + '' + '"",','""' + '' + '"",',
'""' + RTrim(fo.BinNbr) + '""'
from cftFeedOrder fo
JOIN cftSite st on fo.ContactID=st.ContactID
Where Status<>'C' AND Status <> 'X'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXFWEMFile] TO [MSDSL]
    AS [dbo];

