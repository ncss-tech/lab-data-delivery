USE [SSL_Repo]
GO

/****** Object:  View [dbo].[Physical_Properties_List]    Script Date: 10/26/2016 8:22:25 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[Physical_Properties_List]
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
WHERE        (dbo.result.analyte_key IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 30, 76, 239, 240, 240, 241, 241, 242, 243, 282, 282, 283, 
                         284, 286, 286, 287, 287, 288, 288, 289, 289, 290, 290, 291, 291, 313, 313, 314, 315, 317, 317, 318, 318, 319, 319, 320, 320, 321, 321, 322, 322, 330, 331, 332, 333, 
                         333, 334, 334, 335, 335, 336, 336, 337, 337, 338, 339, 339, 341, 341, 342, 390, 391, 392, 393, 394, 395, 396, 458, 459, 540, 541, 546, 557, 558, 560, 562, 564, 565, 
                         565, 566, 566, 567, 569, 600, 606, 622, 625, 628, 630, 631, 637, 637, 638, 639, 639, 640, 640, 641, 641, 642, 643, 649, 656, 657, 671, 672, 672, 673, 674, 685, 686, 
                         686, 687, 739, 741, 743, 745, 746, 747, 775, 776, 777, 777, 778, 778, 785, 786, 797, 1018, 1022, 1022, 1023, 1023, 1024, 1024, 1025, 1025, 1026, 1026, 1027, 1027, 
                         1028, 1028, 1029, 1029, 1039, 1040, 1041, 1047, 1049, 1053, 1054, 1054, 1055, 1055, 1056, 1057, 1058, 1058, 1059, 1059, 1060, 1060, 1061, 1061, 1062, 1062, 
                         1063, 1063, 1064, 1064, 1065, 1065, 1066, 1066, 1067, 1067, 1068, 1069, 1188, 1189, 1190, 1190, 1191, 1191, 1192, 1192, 1193, 1193, 1194, 1194, 1195, 1195, 
                         1196, 1196, 1197, 1198, 1198, 1526, 1526, 1527, 1527, 1528, 1528, 1529, 1529, 1530, 1530, 1531, 1531, 1532, 1532, 1533, 1533, 1534, 1534, 1535, 1536, 1537, 
                         1537, 1538, 1538, 1539, 1539, 1540, 1540, 1541, 1541, 1542, 1542, 1544, 1544, 1546, 1547, 1566, 1567, 1568, 1568, 1569, 1569, 1570, 1570, 1571, 1571, 1572, 
                         1572, 1573, 1573, 1574, 1574, 1575, 1575, 1576, 1576, 1763, 1764, 1765, 1766, 1767, 1768, 1769, 1770, 1772, 1904, 1904, 1905, 1905, 1906, 1906, 1924, 2141, 
                         2173)) AND (dbo.result.result_reliability IS NULL OR
                         dbo.result.result_reliability = '0')

GO

