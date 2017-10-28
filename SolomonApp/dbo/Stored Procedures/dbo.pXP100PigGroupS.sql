


CREATE     Proc dbo.pXP100PigGroupS
		@parm1 As Varchar(6),
		@parm2 As Varchar(6)
as
select *
	FROM cftPigPreMkt 
	WHERE MktMgrId=@parm1 AND PigGroupId Like @parm2
        Order by PigGroupDesc


