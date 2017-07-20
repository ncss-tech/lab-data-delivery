USE [SSL_Repo]
GO

/****** Object:  View [dbo].[NCSS_Data_Dictionary_Data_Tier]    Script Date: 10/26/2016 8:20:39 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[NCSS_Data_Dictionary_Data_Tier]
AS
SELECT     TOP (100) PERCENT dbo.data_tier.data_tier_desc, dbo.data_tier_column.column_index, dbo.data_tier_column.column_name, 
                      dbo.analyte.analyte_name, dbo.analyte.analyte_abbrev, dbo.analyte.analyte_code, dbo.analyte.analyte_type, dbo.analyte.analyte_data_type, 
                      dbo.analyte.analyte_format, dbo.analyte.uom_abbrev, dbo.analyte.analyte_desc, dbo.dt_mcode.calc_size_frac
FROM         dbo.analyte INNER JOIN
                      dbo.dt_mcode ON dbo.analyte.analyte_key = dbo.dt_mcode.analyte_key INNER JOIN
                      dbo.data_tier INNER JOIN
                      dbo.data_tier_column ON dbo.data_tier.data_tier_key = dbo.data_tier_column.data_tier_key ON 
                      dbo.dt_mcode.data_tier_key = dbo.data_tier_column.data_tier_key AND dbo.dt_mcode.column_index = dbo.data_tier_column.column_index
ORDER BY dbo.dt_mcode.data_tier_key, dbo.dt_mcode.column_index, dbo.analyte.analyte_key


GO

