 Create Procedure pjcoproj_sOpen @PARM1 varchar (16) as
select * from pjcoproj
Where
project = @PARM1 and
status1 <> 'A' and status1 <> 'C'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjcoproj_sOpen] TO [MSDSL]
    AS [dbo];

