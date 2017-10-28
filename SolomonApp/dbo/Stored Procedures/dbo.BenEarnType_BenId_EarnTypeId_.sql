 Create Proc  BenEarnType_BenId_EarnTypeId_ @parm1 varchar ( 10), @parm2 varchar ( 10) as
       Select *
			from BenEarnType
				left outer join EarnType
					on BenEarnType.EarnTypeId = EarnType.Id
			where BenEarnType.BenId       =     @parm1
				and BenEarnType.EarnTypeId  LIKE  @parm2
			order by BenEarnType.BenId,
                BenEarnType.EarnTypeId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BenEarnType_BenId_EarnTypeId_] TO [MSDSL]
    AS [dbo];

