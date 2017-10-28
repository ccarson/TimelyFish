 Create Proc  Deduction_AHJMS_Id @parm1 varchar ( 4), @parm2 varchar ( 4) as
       Select * from Deduction
           where (AllId      LIKE  @parm1
              or HeadId     LIKE  @parm1
              or JointId    LIKE  @parm1
              or MarriedId  LIKE  @parm1
              or SingleId   LIKE  @parm1)
             and CalYr = @parm2
           order by DedId


