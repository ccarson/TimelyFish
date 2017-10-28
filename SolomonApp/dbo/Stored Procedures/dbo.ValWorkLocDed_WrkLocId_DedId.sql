 Create Proc  ValWorkLocDed_WrkLocId_DedId @parm1 varchar ( 6), @parm2 varchar ( 10) as
       Select * from ValWorkLocDed
           where WrkLocId  LIKE  @parm1
             and DedId     LIKE  @parm2
           order by WrkLocId,
                    DedId


