 Create Proc  UnionDeduct_DedId_Update @parm1 varchar (10), @parm2 varchar (1), @parm3 varchar (2), @parm4 float,
                                      @parm5 float, @parm6 float, @parm7 float, @parm8 float as
           Update UnionDeduct set basetype        = @parm2,
                                  calcmthd        = @parm3,
                                  fxdpctrate      = @parm4,
                                  wklyminamtperpd = @parm5,
                                  bwkminamtperpd  = @parm6,
                                  smonminamtperpd = @parm7,
                                  monminamtperpd  = @parm8
           Where DedId = @parm1 and Override = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[UnionDeduct_DedId_Update] TO [MSDSL]
    AS [dbo];

