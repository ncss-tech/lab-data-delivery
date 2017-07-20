USE [SSL_Repo]
GO

/****** Object:  View [dbo].[XRay_And_Thermal_List]    Script Date: 10/26/2016 8:21:46 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[XRay_And_Thermal_List]
AS
SELECT        dbo.layer.natural_key, dbo.result.result_key, dbo.result.result_type, dbo.result.result_source_key, dbo.result.analyte_key, dbo.result.prep_key, 
                         dbo.result.result_value, dbo.result.procedure_key, dbo.result.analyzed_size_frac, dbo.analyte.analyte_abbrev, dbo.preparation.prep_abbrev, 
                         dbo.preparation.prep_code, dbo.analyte.analyte_format, dbo.layer.site_key, dbo.result.source_system_key, ISNULL(dbo.bridge_proced_ss.proced_code, '') 
                         AS procedure_code
FROM            dbo.layer INNER JOIN
                         dbo.result INNER JOIN
                         dbo.analyte ON dbo.result.analyte_key = dbo.analyte.analyte_key INNER JOIN
                         dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key ON dbo.layer.layer_key = dbo.result.result_source_key LEFT OUTER JOIN
                         dbo.bridge_proced_ss ON dbo.result.procedure_key = dbo.bridge_proced_ss.procedure_key AND 
                         dbo.result.source_system_key = dbo.bridge_proced_ss.source_system_key
WHERE        (dbo.result.analyte_key IN (397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 
                         425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 811, 812, 813, 42, 43, 364, 365, 366, 
                         367, 809, 810, 814, 815, 816, 1122, 1123, 1201, 1205, 1231, 1242, 1751, 1758, 1759, 1760, 1881, 2085, 2157, 2158, 2159, 2160, 2161, 2162, 2163, 2172, 1099, 1433, 
                         1524, 1525, 1883, 1885, 1886, 1884)) AND (dbo.result.result_reliability IS NULL OR
                         dbo.result.result_reliability = '0')

GO

