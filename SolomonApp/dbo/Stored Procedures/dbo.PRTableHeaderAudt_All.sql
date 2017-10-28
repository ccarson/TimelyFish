 Create Proc  PRTableHeaderAudt_All @parm1 varchar ( 4), @parm2 varchar ( 4) as
       Select * from PRTableHeaderAudt
           where CalYr like @parm1
             and PayTblId like @parm2
           order by Calyr,  PayTblId, audtdatesort

