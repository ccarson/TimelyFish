 Create Proc  DeductionAudt_PrevLT @parm1 varchar ( 10), @parm2 varchar( 4), @parm3 varchar(25) as
       Select * from DeductionAudt
           where DedId       =  @parm1
             and CalYr = @parm2 and AudtDateSort < @parm3
             
           order by DedId, CalYr, audtdatesort desc

