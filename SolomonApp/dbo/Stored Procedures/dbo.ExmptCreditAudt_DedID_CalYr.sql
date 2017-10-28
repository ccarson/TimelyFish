 Create Proc  ExmptCreditAudt_DedID_CalYr @parm1 varchar ( 10), @parm2 varchar( 4), @parm3 varchar(25) as
       Select * from ExmptCreditAudt
           where Dedid       =  @parm1
             and CalYr = @parm2 and AudtDateSort = @parm3 
	     
           order by Dedid , CalYr, audtdatesort, ExmptCrid


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ExmptCreditAudt_DedID_CalYr] TO [MSDSL]
    AS [dbo];

