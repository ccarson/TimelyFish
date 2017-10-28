 Create Proc  PRTran_UPDTEmpIdTShtRlsedPaid_ @parm1 smallint, @parm2 smallint, @parm3 smallint, @parm4 smallint,
                                            @parm5 varchar ( 2), @parm6 smallint, @parm7 varchar ( 4), @parm8 varchar ( 10),
                                            @parm9 varchar ( 24), @parm10 smallint, @parm11 varchar ( 6), @parm12 varchar ( 10),
                                            @parm13 varchar ( 2) as
       Update PRTran
           set   CalQtr      =  @parm6,
                 CalYr       =  @parm7,
                 ChkAcct     =  @parm8,
                 ChkSub      =  @parm9,
                 Paid        =  @parm10,
                 PerPost     =  @parm11,
                 RefNbr      =  @parm12,
                 TranType    =  @parm13
           where EmpId       =  @parm1
             and TimeShtFlg  =  @parm2
             and Rlsed       =  @parm3
             and Paid        =  @parm4
             and TranType    =  @parm5


