
CREATE PROC [dbo].[CA20600_pst] @ri_id	smallint as

Delete wrkcabalances from WrkCABalances where RI_ID = @ri_id

Delete wrkcadetail from WrkCADetail where RI_ID = @ri_id

Delete wrkcaforecast from WrkCAForeCast where RI_ID = @ri_id


GO
GRANT CONTROL
    ON OBJECT::[dbo].[CA20600_pst] TO [MSDSL]
    AS [dbo];

