 /****** Object:  Stored Procedure dbo.RlsedAPDoc_All    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure RlsedAPDoc_All As
Select * From APDoc Where
Rlsed = 1 and
VendId <> '' and
(DocType Not In ('VT', 'MC', 'SC', 'ZC') and DocType Not Like 'B%')
and DocClass <> 'R'
Order By VendId, PerPost



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RlsedAPDoc_All] TO [MSDSL]
    AS [dbo];

