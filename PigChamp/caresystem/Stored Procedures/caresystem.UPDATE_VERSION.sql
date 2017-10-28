CREATE PROCEDURE [caresystem].[UPDATE_VERSION]
  @Product varchar(100),
  @NewMajor INT,
  @NewMinor INT,
  @NewRelease INT,
  @NewBuild INT
AS
BEGIN
  SET NOCOUNT ON;
  IF EXISTS (SELECT * FROM [caresystem].[VERSIONS] WHERE product = @Product)
    BEGIN
      UPDATE caresystem.[versions]
         SET major = @NewMajor, minor = @NewMinor, release = @NewRelease, build = @NewBuild, patched = 0
       WHERE product = @Product
    END
  ELSE
    BEGIN
      INSERT INTO caresystem.[versions] (product, major, minor, release, build, patched)
           VALUES (@Product, @NewMajor, @NewMinor, @NewRelease, @NewBuild, 0)
    END;
END
