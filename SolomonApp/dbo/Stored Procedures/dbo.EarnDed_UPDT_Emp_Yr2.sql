 Create Proc  EarnDed_UPDT_Emp_Yr2 @parm1 varchar (30), @parm2 varchar (30),
                                  @parm3 float,        @parm4 float,
                                  @parm5 varchar (10), @parm6 varchar (10),
                                  @parm7 smalldatetime,@parm8 smalldatetime,
                                  @parm10 varchar(10), @parm11 varchar(4),
                                  @parm12 varchar(10) as
       Update Earnded set User1 = @parm1,
                          User2 = @parm2,
                          User3 = @parm3,
                          User4 = @parm4,
                          User5 = @parm5,
                          User6 = @parm6,
                          User7 = @parm7,
                          User8 = @parm8
           where EmpId      =     @parm10
             and CalYr      =     @parm11
             and EDType     =     'D'
             and EarnDedId  =     @parm12



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EarnDed_UPDT_Emp_Yr2] TO [MSDSL]
    AS [dbo];

