 Create Proc  DeductContrib_DedId_Delete @parm1 varchar ( 10), @parm2 varchar (4) as
       if NOT exists (select DedId from Deduction where DedId = @parm1 and CalYr <> @parm2 and Dedtype = 'W')
           Delete DeductContrib Where DedId = @parm1


