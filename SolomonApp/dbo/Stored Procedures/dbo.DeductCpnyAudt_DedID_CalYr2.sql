 Create Proc  DeductCpnyAudt_DedID_CalYr2 @parm1 varchar ( 10), @parm2 varchar( 4), @parm3 varchar(25), @parm4 varchar(10) as
       Select * from DeductCpnyAudt
           where Dedid       =  @parm1
             and CalYr = @parm2 and AudtDateSort = @parm3 and cpnyid = @parm4
	     
           order by Dedid , CalYr, audtdatesort, cpnyid


GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeductCpnyAudt_DedID_CalYr2] TO [MSDSL]
    AS [dbo];

