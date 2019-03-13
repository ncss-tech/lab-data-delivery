USE [SSL_Repo]
GO

/****** Object:  View [dbo].[Mineralogy_Glass_Count_List]    Script Date: 10/26/2016 8:20:18 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER VIEW [dbo].[Mineralogy_Glass_Count_List]
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
WHERE        (dbo.result.analyte_key IN (80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 817, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 
                         112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 
                         145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 
                         178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 
                         211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 463, 464, 465, 466, 467, 
                         468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 808, 1243, 1261, 1259, 1260, 1262, 1771, 644, 645, 646, 1080, 1081, 1082, 1125, 1126, 1127, 1437, 1438, 1439,
						 1148, 1185, 1434, 1149, 1186, 1435, 1150, 1187, 1436, 823)) AND 
                         (dbo.result.result_reliability IS NULL OR
                         dbo.result.result_reliability = '0')





GO

