 CREATE Procedure IRRequire_QtyByDay @InvtId VarChar(30), @SiteID VarChar(10) AS
-- Use AOU As Out, need to sort before EXT
  Select DueDatePlan,((-1) * Sum(QtyNeeded)) As 'QtyThisDay', (Case When DocumentType = 'EXT' Then DocumentType Else 'AOU' End) 'TranType' from IRRequirement where InvtId = @InvtId and SiteId Like @SiteID and DocumentType in ('SO','PLR','PLF','SH','FC','EXT')   group by DueDatePlan, (Case When DocumentType = 'EXT' Then DocumentType Else 'AOU' End) order by DueDatePlan, (Case When DocumentType = 'EXT' Then DocumentType Else 'AOU' End)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRRequire_QtyByDay] TO [MSDSL]
    AS [dbo];

