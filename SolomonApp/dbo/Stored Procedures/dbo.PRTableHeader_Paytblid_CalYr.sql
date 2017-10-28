 Create Proc  PRTableHeader_Paytblid_CalYr @parm1 varchar ( 4), @parm2 varchar( 4) as
       Select * from PRTableHeader
           where PayTblId       like  @parm1
             and CalYr like @parm2
           order by PayTblId, CalYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTableHeader_Paytblid_CalYr] TO [MSDSL]
    AS [dbo];

