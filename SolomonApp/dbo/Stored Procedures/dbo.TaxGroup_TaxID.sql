 /****** Object:  Stored Procedure dbo.TaxGroup_TaxID    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc TaxGroup_TaxID @parm1 varchar ( 10) AS
        Select * from SlsTaxGrp
            where TaxId = @parm1
            Order by TaxId, GroupId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TaxGroup_TaxID] TO [MSDSL]
    AS [dbo];

