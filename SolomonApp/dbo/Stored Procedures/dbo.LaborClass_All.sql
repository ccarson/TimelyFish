 Create Proc LaborClass_All @parm1 varchar ( 10) as
            Select * from LaborClass where LbrClassId like @parm1
                order by LbrCLassId


