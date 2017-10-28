 Create Proc  DeductCpny_DedId_CalYr_CpnyId @parm1 varchar ( 10), @parm2 varchar ( 4) ,@parm3 varchar (10) as
       Select * from DeductCpny
           where DedId      =     @parm1
             and CalYr      =     @parm2
             and CpnyId    LIKE   @parm3
           order by CpnyId


