 Create Proc KitsToRollUp as
        Select * from Kit where bomtype = 'Y'
           Order by Kit.LevelNbr Desc, Kit.Descr DESC, Kit.Kitid DESC, Kit.Siteid DESC, Kit.Status DESC


