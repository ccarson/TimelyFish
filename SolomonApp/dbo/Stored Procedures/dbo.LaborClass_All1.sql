 Create Proc LaborClass_All1 @parm1 varchar ( 10) as
      SELECT *
        FROM LaborClass
       WHERE LbrClassId like @parm1
         AND (PPayRate <> 0 OR PStdRate <> 0)
       ORDER BY LbrCLassId


