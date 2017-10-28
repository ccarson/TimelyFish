 Create Proc AssyDoc_BatNbr @parm1 varchar ( 10) as
    Select *
		from AssyDoc
			left outer join Inventory
				on AssyDoc.KitId = Inventory.InvtId
        where BatNbr = @parm1
        and AssyDoc.Rlsed = 0
        order by BatNbr, KitId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AssyDoc_BatNbr] TO [MSDSL]
    AS [dbo];

