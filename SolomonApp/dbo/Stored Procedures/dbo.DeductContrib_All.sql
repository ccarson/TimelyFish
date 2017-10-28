 Create Proc  DeductContrib_All @parm1 varchar (10), @parm2 varchar ( 4), @parm3 varchar (10) as
       Select DeductContrib.*, Deduction.Descr
			from DeductContrib
				left outer join Deduction
					on DeductContrib.ContribId = Deduction.DedId
            where DeductContrib.DedId     like @parm1
                 and DeductContrib.ContribId like @parm3
                 and Deduction.CalYr            = @parm2
            Order by DeductContrib.DedId, DeductContrib.ContribId


