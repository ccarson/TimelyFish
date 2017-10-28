 Create Proc  ValEarnDed_DedId_Delete_Select @parm1 varchar ( 10), @parm2 varchar (4) as
       if NOT exists (select DedId from Deduction where DedId = @parm1 and CalYr <> @parm2)
           Delete valearnded from ValEarnDed Where DedId = @parm1


