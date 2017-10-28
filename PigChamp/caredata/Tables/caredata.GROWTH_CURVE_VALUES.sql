CREATE TABLE [caredata].[GROWTH_CURVE_VALUES] (
    [growth_curve_id] INT        NOT NULL,
    [age]             INT        NOT NULL,
    [weight]          FLOAT (53) NOT NULL,
    CONSTRAINT [PK_GROWTH_CURVE_VALUES] PRIMARY KEY CLUSTERED ([growth_curve_id] ASC, [age] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_GROWTH_CURVE_VALUES_GROWTH_CURVES_0] FOREIGN KEY ([growth_curve_id]) REFERENCES [caredata].[GROWTH_CURVES] ([growth_curve_id]) ON DELETE CASCADE
);

