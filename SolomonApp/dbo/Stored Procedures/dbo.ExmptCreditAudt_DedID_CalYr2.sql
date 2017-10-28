 Create Proc  ExmptCreditAudt_DedID_CalYr2 @parm1 varchar ( 10), @parm2 varchar( 4), @parm3 varchar(25), @parm4 varchar(4), @parm5 varchar(1) as
       Select * from ExmptCreditAudt
           where Dedid       =  @parm1
             and CalYr = @parm2 and AudtDateSort = @parm3 and ExmptCrid = @parm4 and marstat = @parm5
	    
             
           order by Dedid , CalYr, audtdatesort, ExmptCrid, marstat

