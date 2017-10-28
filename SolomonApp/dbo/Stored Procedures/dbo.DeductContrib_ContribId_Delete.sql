 Create Proc  DeductContrib_ContribId_Delete @parm1 varchar (10), @parm2 varchar (4) as
       if NOT exists (select DedId from Deduction where DedId = @parm1 and CalYr <> @parm2 and EmpleeDed = 0 and DedType in ('C','F','I','R','S','T','V'))
           Delete DeductContrib Where ContribId = @parm1


