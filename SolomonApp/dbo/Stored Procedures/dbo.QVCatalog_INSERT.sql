
CREATE PROCEDURE QVCatalog_INSERT
@SQLView char(50),
@BaseQueryView char(50),
@QueryViewName char(50),
@Module char(2),
@Number char(7),
@ViewDescription char(60),
@ViewFilter varchar(4000),
@ViewSort varchar(255),
@ColumnsRemovedMoved varchar(8000),
@DrillPrograms varchar(1024),
@VisibilityType smallint,
@Visibility char(47),
@SystemDatabase smallint,
@CompanyColumn char(60),
@CompanyParms smallint,
@NoteColumns varchar(255),
@CreatedBy char(47)
AS
BEGIN

INSERT INTO [vs_qvcatalog]
([SQLView],
[BaseQueryView],
[QueryViewName],
[Module],
[Number],
[ViewDescription],
[ViewFilter],
[ViewSort],
[ColumnsRemovedMoved],
[DrillPrograms],
[VisibilityType],
[Visibility],
[SystemDatabase],
[CompanyColumn],
[CompanyParms],
[NoteColumns],
[CreatedBy])
VALUES
(@SQLView,
@BaseQueryView,
@QueryViewName,
@Module,
@Number,
@ViewDescription,
@ViewFilter,
@ViewSort,
@ColumnsRemovedMoved,
@DrillPrograms,
@VisibilityType,
@Visibility,
@SystemDatabase,
@CompanyColumn,
@CompanyParms,
@NoteColumns,
@CreatedBy);
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[QVCatalog_INSERT] TO [MSDSL]
    AS [dbo];

