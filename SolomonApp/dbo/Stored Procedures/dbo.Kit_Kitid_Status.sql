 Create Proc Kit_Kitid_Status @parm1 varchar ( 30), @parm2 varchar ( 1) as
            Select * from Kit where KitId = @parm1 and status = @parm2
                order by KitId


