 CREATE PROCEDURE EDContainer_UCC128 @UCC128 varchar(20) AS
select * from edcontainer
where UCC128 = @UCC128



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_UCC128] TO [MSDSL]
    AS [dbo];

