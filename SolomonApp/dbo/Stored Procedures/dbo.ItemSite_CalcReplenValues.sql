
CREATE PROC ItemSite_CalcReplenValues AS

SELECT i.*,y.InvtID, y.LastCost
  FROM ItemSite i JOIN Inventory y
                    ON i.Invtid = y.InvtID
 WHERE y.StkItem = 1 AND y.transtatuscode NOT IN ('IN','NP')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemSite_CalcReplenValues] TO [MSDSL]
    AS [dbo];

