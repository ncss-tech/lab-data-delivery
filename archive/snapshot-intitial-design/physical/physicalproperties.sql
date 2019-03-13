USE [SSL_Repo]
GO

/****** Object:  View [dbo].[Physical_Properties]    Script Date: 10/26/2016 8:22:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[Physical_Properties]
AS
SELECT        result_source_key, prep_code,
                             (SELECT        TOP (1) result_value
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (1566, 1547, 
                                                                                   1536, 569))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result AS result_60
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 674)
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result AS result_59
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 1068)
                                                         UNION
                                                         SELECT        result_value, 'S_SK' AS prep_code
                                                         FROM            dbo.result AS result_58
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (1069, 643))) 
                                                         AS result_1_9
                               WHERE        (prep_code = q1.prep_code)) AS texture_lab,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (282, 286, 287, 288, 289, 290, 291, 313, 317, 318, 319, 320, 321, 322, 565, 566, 567, 640, 
                                                         641, 642, 671, 672, 673, 685, 686, 687, 1053, 1054, 1055, 1056, 1057, 1058, 1526, 1527, 1528, 1529, 1530, 1531, 1532, 1533, 1534, 1535, 1537, 1538, 
                                                         1539, 1540, 1541, 1542, 1544, 1546, 1567, 1568, 1569, 1570, 1571, 1572, 1573, 1574, 1575, 1576))) AS particle_size_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_57.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_57 INNER JOIN
                                                         dbo.preparation ON result_57.prep_key = dbo.preparation.prep_key
                               WHERE        (result_57.result_type = 'layer analyte') AND (result_57.result_value <> '') AND (result_57.result_source_key = q1.result_source_key) AND 
                                                         (dbo.preparation.prep_code = q1.prep_code) AND (result_57.result_reliability IS NULL OR
                                                         result_57.result_reliability = '0') AND (result_57.analyte_key IN (282, 313, 1576, 1537, 1526))) AS clay_total,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(15, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result AS result_56
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (1567, 1546, 
                                                                                   1535, 567))
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result AS result_55
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 687)
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result AS result_54
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 673)
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result AS result_53
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 1056)
                                                         UNION
                                                         SELECT        result_value, 'S_SK' AS prep_code
                                                         FROM            dbo.result AS result_52
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (1053, 642))) 
                                                         AS result_1_8
                               WHERE        (prep_code = q1.prep_code)) AS silt_total,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(15, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result AS result_51
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (1569, 1544, 
                                                                                   1533, 565))
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result AS result_50
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 685)
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result AS result_49
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 671)
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result AS result_47
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 1057)
                                                         UNION
                                                         SELECT        result_value, 'S_SK' AS prep_code
                                                         FROM            dbo.result AS result_46
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (1054, 640))) 
                                                         AS result_1_7
                               WHERE        (prep_code = q1.prep_code)) AS sand_total,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_14.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_14 INNER JOIN
                                                         dbo.preparation AS preparation_8 ON result_14.prep_key = preparation_8.prep_key
                               WHERE        (result_14.result_type = 'layer analyte') AND (result_14.result_value <> '') AND (result_14.result_source_key = q1.result_source_key) AND 
                                                         (preparation_8.prep_code = q1.prep_code) AND (result_14.result_reliability IS NULL OR
                                                         result_14.result_reliability = '0') AND (result_14.analyte_key IN (284, 315))) AS clay_fine,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_13.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_13 INNER JOIN
                                                         dbo.preparation AS preparation_7 ON result_13.prep_key = preparation_7.prep_key
                               WHERE        (result_13.result_type = 'layer analyte') AND (result_13.result_value <> '') AND (result_13.result_source_key = q1.result_source_key) AND 
                                                         (preparation_7.prep_code = q1.prep_code) AND (result_13.result_reliability IS NULL OR
                                                         result_13.result_reliability = '0') AND (result_13.analyte_key IN (283, 314))) AS clay_caco3,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_12.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_12 INNER JOIN
                                                         dbo.preparation AS preparation_6 ON result_12.prep_key = preparation_6.prep_key
                               WHERE        (result_12.result_type = 'layer analyte') AND (result_12.result_value <> '') AND (result_12.result_source_key = q1.result_source_key) AND 
                                                         (preparation_6.prep_code = q1.prep_code) AND (result_12.result_reliability IS NULL OR
                                                         result_12.result_reliability = '0') AND (result_12.analyte_key IN (291, 322, 1532, 1570))) AS silt_fine,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(15, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result AS result_45
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (1568, 1534, 
                                                                                   566))
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result AS result_44
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 686)
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result AS result_43
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 672)
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result AS result_42
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 1058)
                                                         UNION
                                                         SELECT        result_value, 'S_SK' AS prep_code
                                                         FROM            dbo.result AS result_41
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (1055, 641))) 
                                                         AS result_1_6
                               WHERE        (prep_code = q1.prep_code)) AS silt_coarse,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_10.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_10 INNER JOIN
                                                         dbo.preparation AS preparation_5 ON result_10.prep_key = preparation_5.prep_key
                               WHERE        (result_10.result_type = 'layer analyte') AND (result_10.result_value <> '') AND (result_10.result_source_key = q1.result_source_key) AND 
                                                         (preparation_5.prep_code = q1.prep_code) AND (result_10.result_reliability IS NULL OR
                                                         result_10.result_reliability = '0') AND (result_10.analyte_key IN (290, 321, 1531, 1542, 1571))) AS sand_very_fine,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_9.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_9 INNER JOIN
                                                         dbo.preparation AS preparation_4 ON result_9.prep_key = preparation_4.prep_key
                               WHERE        (result_9.result_type = 'layer analyte') AND (result_9.result_value <> '') AND (result_9.result_source_key = q1.result_source_key) AND 
                                                         (preparation_4.prep_code = q1.prep_code) AND (result_9.result_reliability IS NULL OR
                                                         result_9.result_reliability = '0') AND (result_9.analyte_key IN (287, 318, 1528, 1539, 1574))) AS sand_fine,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_8.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_8 INNER JOIN
                                                         dbo.preparation AS preparation_3 ON result_8.prep_key = preparation_3.prep_key
                               WHERE        (result_8.result_type = 'layer analyte') AND (result_8.result_value <> '') AND (result_8.result_source_key = q1.result_source_key) AND 
                                                         (preparation_3.prep_code = q1.prep_code) AND (result_8.result_reliability IS NULL OR
                                                         result_8.result_reliability = '0') AND (result_8.analyte_key IN (288, 319, 1529, 1540, 1573))) AS sand_medium,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_7.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_7 INNER JOIN
                                                         dbo.preparation AS preparation_2 ON result_7.prep_key = preparation_2.prep_key
                               WHERE        (result_7.result_type = 'layer analyte') AND (result_7.result_value <> '') AND (result_7.result_source_key = q1.result_source_key) AND 
                                                         (preparation_2.prep_code = q1.prep_code) AND (result_7.result_reliability IS NULL OR
                                                         result_7.result_reliability = '0') AND (result_7.analyte_key IN (286, 317, 1527, 1538, 1575))) AS sand_coarse,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_6.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_6 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_6.prep_key = preparation_1.prep_key
                               WHERE        (result_6.result_type = 'layer analyte') AND (result_6.result_value <> '') AND (result_6.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_6.result_reliability IS NULL OR
                                                         result_6.result_reliability = '0') AND (result_6.analyte_key IN (289, 320, 1530, 1541, 1572))) AS sand_very_coarse,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_5
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (isnumeric(result_value) = 1) AND (result_source_key = q1.result_source_key) AND 
                                                         (analyte_key IN (628))) AS frag_2_5_mm_wt_pct_lt_75,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_4
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (isnumeric(result_value) = 1) AND (result_source_key = q1.result_source_key) AND 
                                                         (analyte_key IN (1039))) AS frat__2_20_mm_wt_pct_lt_75,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_4
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (isnumeric(result_value) = 1) AND (result_source_key = q1.result_source_key) AND 
                                                         (analyte_key IN (631))) AS frag_5_20_mm_wt_pct_lt_75,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_3
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (isnumeric(result_value) = 1) AND (result_source_key = q1.result_source_key) AND 
                                                         (analyte_key IN (630))) AS frag_20_75_mm_wt_pct_lt_75,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_1
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (isnumeric(result_value) = 1) AND (result_source_key = q1.result_source_key) AND 
                                                         (analyte_key IN (600))) AS total_frag_wt_pct_gt_2_mm_ws,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (600))) AS total_frag_vol_gt_2_mm_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_2
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (isnumeric(result_value) = 1) AND (result_source_key = q1.result_source_key) AND 
                                                         (analyte_key IN (606))) AS wt_pct_1_tenth_to_75_mm,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_12.result_value, '4.2') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_12 INNER JOIN
                                                         dbo.preparation AS preparation_8 ON result_12.prep_key = preparation_8.prep_key
                               WHERE        (result_12.result_type = 'layer analyte') AND (result_12.result_source_key = q1.result_source_key) AND ('S' = q1.prep_code) AND 
                                                         (result_12.result_reliability IS NULL OR
                                                         result_12.result_reliability = '0') AND (result_12.analyte_key = 10)) AS bulk_density_tenth_bar,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (10))) AS bulk_density_tenth_bar_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_12.result_value, '4.2') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_12 INNER JOIN
                                                         dbo.preparation AS preparation_8 ON result_12.prep_key = preparation_8.prep_key
                               WHERE        (result_12.result_type = 'layer analyte') AND (result_12.result_source_key = q1.result_source_key) AND ('S' = q1.prep_code) AND 
                                                         (result_12.result_reliability IS NULL OR
                                                         result_12.result_reliability = '0') AND (result_12.analyte_key = 4)) AS bulk_density_third_bar,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (4))) AS bulk_density_third_bar_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_12.result_value, '4.2') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_12 INNER JOIN
                                                         dbo.preparation AS preparation_8 ON result_12.prep_key = preparation_8.prep_key
                               WHERE        (result_12.result_type = 'layer analyte') AND (result_12.result_source_key = q1.result_source_key) AND ('S' = q1.prep_code) AND 
                                                         (result_12.result_reliability IS NULL OR
                                                         result_12.result_reliability = '0') AND (result_12.analyte_key = 5)) AS bulk_density_oven_dry,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (5))) AS bulk_density_oven_dry_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_12.result_value, '4.2') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_12 INNER JOIN
                                                         dbo.preparation AS preparation_8 ON result_12.prep_key = preparation_8.prep_key
                               WHERE        (result_12.result_type = 'layer analyte') AND (result_12.result_source_key = q1.result_source_key) AND ('S' = q1.prep_code) AND 
                                                         (result_12.result_reliability IS NULL OR
                                                         result_12.result_reliability = '0') AND (result_12.analyte_key = 786)) AS bulk_density_lt_2_mm_air_dry,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (786))) AS bulk_density_air_dry_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_12.result_value, '4.2') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_12 INNER JOIN
                                                         dbo.preparation AS preparation_8 ON result_12.prep_key = preparation_8.prep_key
                               WHERE        (result_12.result_type = 'layer analyte') AND (result_12.result_source_key = q1.result_source_key) AND ('S' = q1.prep_code) AND 
                                                         (result_12.result_reliability IS NULL OR
                                                         result_12.result_reliability = '0') AND (result_12.analyte_key = 16)) AS bd_third_bar_lt2_reconstituted,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (16))) AS bd_thirdbar_reconstituted_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_12.result_value, '4.2') AS decimal(10, 2)) AS Expr1
                               FROM            dbo.result AS result_12 INNER JOIN
                                                         dbo.preparation AS preparation_8 ON result_12.prep_key = preparation_8.prep_key
                               WHERE        (result_12.result_type = 'layer analyte') AND (result_12.result_source_key = q1.result_source_key) AND ('S' = q1.prep_code) AND 
                                                         (result_12.result_reliability IS NULL OR
                                                         result_12.result_reliability = '0') AND (result_12.analyte_key = 17)) AS bulk_den_ovendry_reconstituted,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (17))) AS bulk_de_odreconstituted_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.3') AS decimal(11, 3)) AS Expr1
                               FROM            dbo.result AS result_11
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (19, 21, 22, 1772))) 
                         AS bulk_density_field_moist,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (19, 21, 22, 1772))) AS bulk_density_field_moist_metho,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.3') AS decimal(11, 3)) AS Expr1
                               FROM            dbo.result AS result_11
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 242)) 
                         AS particle_density_less_than_2mm,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (242))) AS particle_density_lt_2mm_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.3') AS decimal(11, 3)) AS Expr1
                               FROM            dbo.result AS result_11
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 243)) 
                         AS particle_density_gt_2_mm,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (243))) AS particle_density_gt_2mm_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.3') AS decimal(11, 3)) AS Expr1
                               FROM            dbo.result AS result_11
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 625)) AS cole_whole_soil,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (625))) AS cole_whole_soil_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_40 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                               WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                                                         AND (result_40.analyte_key IN (540))) AS le_third_fifteen_lt2_mm,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (540))) AS le_third_fifteen_lt2_metho,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_40 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                               WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                                                         AND (result_40.analyte_key IN (536))) AS le_third_ovendry_lt_2_mm,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (536))) AS le_third_ovendry_lt_2_mm_metho,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_40 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                               WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                                                         AND (result_40.analyte_key IN (541))) AS le_field_moist_to_oben_dry,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (541))) AS le_fm_to_od_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_40 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                               WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                                                         AND (result_40.analyte_key IN (1924))) AS water_retention_0_bar_sieve,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (1924))) AS water_retention_0_bar_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_40 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                               WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                                                         AND (result_40.analyte_key IN (6, 11))) AS water_retention_6_hundredths,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_40 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                               WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                                                         AND (result_40.analyte_key IN (1924))) AS water_retention_6_hundr_sieve,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (6, 11, 390))) AS water_retention_6_hund_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_40 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                               WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                                                         AND (result_40.analyte_key IN (8, 13))) AS water_retention_10th_bar,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_40 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                               WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                                                         AND (result_40.analyte_key IN (391))) AS water_retention_10th_bar_sieve,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (8, 391, 13))) AS water_retention_10th_bar_meth,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_40 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                               WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                                                         AND (result_40.analyte_key IN (9, 14))) AS water_retention_third_bar,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_40 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                               WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                                                         AND (result_40.analyte_key IN (392, 18))) AS water_retention_thirdbar_sieve,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (9, 392, 14, 18))) AS water_retention_thirdbar_metho,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_40 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                               WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                                                         AND (result_40.analyte_key IN (7))) AS water_retention_1_bar,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_40 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                               WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                                                         AND (result_40.analyte_key IN (393, 1040))) AS water_retention_1_bar_sieve,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (7, 393, 1040))) AS water_retention_1_bar_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_40 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                               WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                                                         AND (result_40.analyte_key IN (15))) AS water_retention_2_bar,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_40 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                               WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                                                         AND (result_40.analyte_key IN (1041, 395))) AS water_retention_2_bar_sieve,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (15, 1041, 395))) AS water_retention_2_bar_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_40 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                               WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                                                         AND (result_40.analyte_key = 2173)) AS water_retention_3_bar_sieve,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (2173))) AS water_retention_3_bar_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_40 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                               WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                                                         AND (result_40.analyte_key = 1241)) AS water_retention_5_bar_sieve,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (1241))) AS water_retention_5_bar_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_40 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                               WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                                                         AND (result_40.analyte_key IN (394, 785))) AS water_retention_15_bar,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (394, 785))) AS water_retention_15_bar_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_48.result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_48 INNER JOIN
                                                         dbo.preparation AS preparation_25 ON result_48.prep_key = preparation_25.prep_key
                               WHERE        (result_48.result_type = 'layer analyte') AND (result_48.result_source_key = q1.result_source_key) AND (preparation_25.prep_code = q1.prep_code) 
                                                         AND (result_48.analyte_key IN (458, 459, 20, 30))) AS water_retention_field_state,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (458, 459, 20, 30))) AS water_retention_field_state_me,
                             (SELECT        TOP (1) result_39.result_value
                               FROM            dbo.result AS result_39 INNER JOIN
                                                         dbo.preparation AS preparation_16 ON result_39.prep_key = preparation_16.prep_key
                               WHERE        (result_39.result_type = 'layer analyte') AND (result_39.result_value <> '') AND (result_39.result_source_key = q1.result_source_key) AND 
                                                         (result_39.analyte_key = 396)) AS airdry_ovendry_ratio,
                             (SELECT        TOP (1) result_38.result_value
                               FROM            dbo.result AS result_38 INNER JOIN
                                                         dbo.preparation AS preparation_15 ON result_38.prep_key = preparation_15.prep_key
                               WHERE        (result_38.result_type = 'layer analyte') AND (result_38.result_value <> '') AND (result_38.result_source_key = q1.result_source_key) AND 
                                                         (result_38.analyte_key = 2)) AS atterberg_liquid_limit,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (2))) AS atterberg_liquid_limit_method,
                             (SELECT        TOP (1) result_37.result_value
                               FROM            dbo.result AS result_37 INNER JOIN
                                                         dbo.preparation AS preparation_14 ON result_37.prep_key = preparation_14.prep_key
                               WHERE        (result_37.result_type = 'layer analyte') AND (result_37.result_value <> '') AND (result_37.result_source_key = q1.result_source_key) AND 
                                                         (result_37.analyte_key = 557)) AS atterberg_plasticity_index,
                             (SELECT        TOP (1) result_37.result_value
                               FROM            dbo.result AS result_37 INNER JOIN
                                                         dbo.preparation AS preparation_14 ON result_37.prep_key = preparation_14.prep_key
                               WHERE        (result_37.result_type = 'layer analyte') AND (result_37.result_value <> '') AND (result_37.result_source_key = q1.result_source_key) AND 
                                                         (result_37.analyte_key = 3)) AS plastic_limit,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (3))) AS plastic_limit_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '5.3') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_36
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (1))) 
                         AS aggregate_stability_05_2_mm,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (1))) AS aggregate_stability_05_2_metho,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '5.3') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_35
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (562))) 
                         AS le_to_clay_third_bar_to_ovendr,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result AS result_34
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (558))
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result AS result_32
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (1049))) 
                                                         AS result_1_5
                               WHERE        (prep_code = q1.prep_code)) AS water_15_bar_to_clay_ratio,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '5.2') AS decimal(15, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result AS result_31
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (797, 743, 741, 
                                                                                   739, 649, 622, 560))
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result AS result_30
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (1047))) 
                                                         AS result_1_4
                               WHERE        (prep_code = q1.prep_code)) AS cec7_clay_ratio,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_33
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (564, 656, 657, 745, 746, 
                                                         747))) AS effective_cec_to_clay_ratio,
                             (SELECT        TOP (1) ISNULL(dbo.bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result_1.procedure_key = dbo.bridge_proced_ss.procedure_key AND 
                                                         result_1.source_system_key = dbo.bridge_proced_ss.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (1763, 1764, 1765, 1766, 1767, 1768, 1769, 1770))) AS psda_ethanol_dispersion_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(15, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result AS result_27
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 1769)) 
                                                         AS result_1_3
                               WHERE        (prep_code = q1.prep_code)) AS sand_total_ethanol_dispersible,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(15, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result AS result_27
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 1770)) 
                                                         AS result_1_3_2
                               WHERE        (prep_code = q1.prep_code)) AS silt_total_ethanol_dispersible,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_10.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_10 INNER JOIN
                                                         dbo.preparation AS preparation_5 ON result_10.prep_key = preparation_5.prep_key
                               WHERE        (result_10.result_type = 'layer analyte') AND (result_10.result_value <> '') AND (result_10.result_source_key = q1.result_source_key) AND 
                                                         (preparation_5.prep_code = q1.prep_code) AND (result_10.result_reliability IS NULL OR
                                                         result_10.result_reliability = '0') AND (result_10.analyte_key = 1763)) AS clay_total_ethanol_dispersible,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_10.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_10 INNER JOIN
                                                         dbo.preparation AS preparation_5 ON result_10.prep_key = preparation_5.prep_key
                               WHERE        (result_10.result_type = 'layer analyte') AND (result_10.result_value <> '') AND (result_10.result_source_key = q1.result_source_key) AND 
                                                         (preparation_5.prep_code = q1.prep_code) AND (result_10.result_reliability IS NULL OR
                                                         result_10.result_reliability = '0') AND (result_10.analyte_key = 1764)) AS sand_very_fine_ethanol_dispers,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_9.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_9 INNER JOIN
                                                         dbo.preparation AS preparation_4 ON result_9.prep_key = preparation_4.prep_key
                               WHERE        (result_9.result_type = 'layer analyte') AND (result_9.result_value <> '') AND (result_9.result_source_key = q1.result_source_key) AND 
                                                         (preparation_4.prep_code = q1.prep_code) AND (result_9.result_reliability IS NULL OR
                                                         result_9.result_reliability = '0') AND (result_9.analyte_key = 1765)) AS sand_fine_ethanol_dispersible,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_8.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_8 INNER JOIN
                                                         dbo.preparation AS preparation_3 ON result_8.prep_key = preparation_3.prep_key
                               WHERE        (result_8.result_type = 'layer analyte') AND (result_8.result_value <> '') AND (result_8.result_source_key = q1.result_source_key) AND 
                                                         (preparation_3.prep_code = q1.prep_code) AND (result_8.result_reliability IS NULL OR
                                                         result_8.result_reliability = '0') AND (result_8.analyte_key = 1766)) AS sand_medium_ethanol_dispersibl,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_7.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_7 INNER JOIN
                                                         dbo.preparation AS preparation_2 ON result_7.prep_key = preparation_2.prep_key
                               WHERE        (result_7.result_type = 'layer analyte') AND (result_7.result_value <> '') AND (result_7.result_source_key = q1.result_source_key) AND 
                                                         (preparation_2.prep_code = q1.prep_code) AND (result_7.result_reliability IS NULL OR
                                                         result_7.result_reliability = '0') AND (result_7.analyte_key = 1767)) AS sand_coarse_ethanol_dispersibl,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_6.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_6 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_6.prep_key = preparation_1.prep_key
                               WHERE        (result_6.result_type = 'layer analyte') AND (result_6.result_value <> '') AND (result_6.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_6.result_reliability IS NULL OR
                                                         result_6.result_reliability = '0') AND (result_6.analyte_key = 1768)) AS sand_very_coarse_ethanol_disp,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (1018, 1197, 1067, 1062, 337, 1026, 1194, 334, 1023, 1191, 335, 1024, 1192, 333, 1022, 
                                                         1190, 336, 1025, 1193, 1065, 1059, 1904, 1028, 1198, 637, 1064, 1061, 1906, 1029, 1196, 639, 1063, 1066, 1060, 1905, 338, 1027, 1195, 341, 638, 
                                                         330, 1188, 331, 1189, 332, 339, 342))) AS water_dispersible_fraction_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_29.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_29 INNER JOIN
                                                         dbo.preparation AS preparation_13 ON result_29.prep_key = preparation_13.prep_key
                               WHERE        (result_29.result_type = 'layer analyte') AND (result_29.result_value <> '') AND (result_29.result_source_key = q1.result_source_key) AND 
                                                         (preparation_13.prep_code = q1.prep_code) AND (result_29.result_reliability IS NULL OR
                                                         result_29.result_reliability = '0') AND (result_29.analyte_key IN (332, 339, 342))) AS clay_tot_h2o_dispersible,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_28.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_28 INNER JOIN
                                                         dbo.preparation AS preparation_12 ON result_28.prep_key = preparation_12.prep_key
                               WHERE        (result_28.result_type = 'layer analyte') AND (result_28.result_value <> '') AND (result_28.result_source_key = q1.result_source_key) AND 
                                                         (preparation_12.prep_code = q1.prep_code) AND (result_28.result_reliability IS NULL OR
                                                         result_28.result_reliability = '0') AND (result_28.analyte_key IN (331, 1189))) AS clay_fine_h2o_dispersible,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_14.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_14 INNER JOIN
                                                         dbo.preparation AS preparation_8 ON result_14.prep_key = preparation_8.prep_key
                               WHERE        (result_14.result_type = 'layer analyte') AND (result_14.result_value <> '') AND (result_14.result_source_key = q1.result_source_key) AND 
                                                         (preparation_8.prep_code = q1.prep_code) AND (result_14.result_reliability IS NULL OR
                                                         result_14.result_reliability = '0') AND (result_14.analyte_key IN (330, 1188))) AS clay_co3_h2o_dispersible,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(15, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result AS result_27
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 638)
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result AS result_26
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (1018, 1197))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result AS result_25
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (1060, 1905))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result AS result_24
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 1066)
                                                         UNION
                                                         SELECT        result_value, 'HM' AS prep_code
                                                         FROM            dbo.result AS result_23
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 1063)) 
                                                         AS result_1_3_1
                               WHERE        (prep_code = q1.prep_code)) AS silt_total_h2o_dispersible,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_12.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_12 INNER JOIN
                                                         dbo.preparation AS preparation_6 ON result_12.prep_key = preparation_6.prep_key
                               WHERE        (result_12.result_type = 'layer analyte') AND (result_12.result_value <> '') AND (result_12.result_source_key = q1.result_source_key) AND 
                                                         (preparation_6.prep_code = q1.prep_code) AND (result_12.result_reliability IS NULL OR
                                                         result_12.result_reliability = '0') AND (result_12.analyte_key IN (338, 1027, 1195, 341))) AS silt_fine_h2o_dispersible,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(15, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result AS result_22
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 639)
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result AS result_21
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (1029, 1196))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result AS result_20
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (1061, 1906))
                                                         UNION
                                                         SELECT        result_value, 'HM' AS prep_code
                                                         FROM            dbo.result AS result_19
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 1064)
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result AS result_18
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 1067)) 
                                                         AS result_1_2
                               WHERE        (prep_code = q1.prep_code)) AS silt_coarse_h2o_dispersible,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(15, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result AS result_17
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 637)
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result AS result_14
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (1028, 1198))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result AS result_13
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (1059, 1904))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result AS result_12
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 1065)
                                                         UNION
                                                         SELECT        result_value, 'HM' AS prep_code
                                                         FROM            dbo.result AS result_5
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 1062)) 
                                                         AS result_1_1
                               WHERE        (prep_code = q1.prep_code)) AS sand_total_h2o_dispersible,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_10.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_10 INNER JOIN
                                                         dbo.preparation AS preparation_5 ON result_10.prep_key = preparation_5.prep_key
                               WHERE        (result_10.result_type = 'layer analyte') AND (result_10.result_value <> '') AND (result_10.result_source_key = q1.result_source_key) AND 
                                                         (preparation_5.prep_code = q1.prep_code) AND (result_10.result_reliability IS NULL OR
                                                         result_10.result_reliability = '0') AND (result_10.analyte_key IN (337, 1026, 1194))) AS sand_vf_h2o_dispersible,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_9.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_9 INNER JOIN
                                                         dbo.preparation AS preparation_4 ON result_9.prep_key = preparation_4.prep_key
                               WHERE        (result_9.result_type = 'layer analyte') AND (result_9.result_value <> '') AND (result_9.result_source_key = q1.result_source_key) AND 
                                                         (preparation_4.prep_code = q1.prep_code) AND (result_9.result_reliability IS NULL OR
                                                         result_9.result_reliability = '0') AND (result_9.analyte_key IN (334, 1023, 1191))) AS sand_fine_h2o_dispersible,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_8.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_8 INNER JOIN
                                                         dbo.preparation AS preparation_3 ON result_8.prep_key = preparation_3.prep_key
                               WHERE        (result_8.result_type = 'layer analyte') AND (result_8.result_value <> '') AND (result_8.result_source_key = q1.result_source_key) AND 
                                                         (preparation_3.prep_code = q1.prep_code) AND (result_8.result_reliability IS NULL OR
                                                         result_8.result_reliability = '0') AND (result_8.analyte_key IN (335, 1024, 1192))) AS sand_medium_h2o_dispersible,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_7.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_7 INNER JOIN
                                                         dbo.preparation AS preparation_2 ON result_7.prep_key = preparation_2.prep_key
                               WHERE        (result_7.result_type = 'layer analyte') AND (result_7.result_value <> '') AND (result_7.result_source_key = q1.result_source_key) AND 
                                                         (preparation_2.prep_code = q1.prep_code) AND (result_7.result_reliability IS NULL OR
                                                         result_7.result_reliability = '0') AND (result_7.analyte_key IN (333, 1022, 1190))) AS sand_coarse_h2o_dispersible,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_6.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_6 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_6.prep_key = preparation_1.prep_key
                               WHERE        (result_6.result_type = 'layer analyte') AND (result_6.result_value <> '') AND (result_6.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_6.result_reliability IS NULL OR
                                                         result_6.result_reliability = '0') AND (result_6.analyte_key IN (336, 1025, 1193))) AS sand_vc_h2o_dispersible,
                             (SELECT        TOP (1) result_9.result_value
                               FROM            dbo.result AS result_9 INNER JOIN
                                                         dbo.preparation AS preparation_8 ON result_9.prep_key = preparation_8.prep_key
                               WHERE        (result_9.result_type = 'layer analyte') AND (result_9.result_source_key = q1.result_source_key) AND (preparation_8.prep_code = q1.prep_code) AND 
                                                         (result_9.analyte_key = 239)) AS color_pyrophosphate_extract,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_5.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_5 ON result_1.procedure_key = bridge_proced_ss_5.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_5.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (239))) AS color_pyrophosphate_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_4.result_value, '4.2') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_4 INNER JOIN
                                                         dbo.preparation AS preparation_4 ON result_4.prep_key = preparation_4.prep_key
                               WHERE        (result_4.result_type = 'layer analyte') AND (result_4.result_source_key = q1.result_source_key) AND ('MW' = q1.prep_code) AND 
                                                         (result_4.analyte_key = 24)) AS bd_thirdbar_before_rewet_organ,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_4.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_4 ON result_1.procedure_key = bridge_proced_ss_4.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_4.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (24))) AS bd_before_rewet_organic_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_3.result_value, '4.2') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_3 INNER JOIN
                                                         dbo.preparation AS preparation_3 ON result_3.prep_key = preparation_3.prep_key
                               WHERE        (result_3.result_type = 'layer analyte') AND (result_3.result_source_key = q1.result_source_key) AND ('MW' = q1.prep_code) AND 
                                                         (result_3.analyte_key = 25)) AS bd_thirdbar_rewet_organic_soil,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_3.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_3 ON result_1.procedure_key = bridge_proced_ss_3.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_3.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (25))) AS bd_third_rewet_organic_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.3') AS decimal(11, 3)) AS Expr1
                               FROM            dbo.result AS result_11
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key = 23)) AS Expr1,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_6 ON result_1.procedure_key = bridge_proced_ss_6.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_6.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (23))) AS bulk_den_rewet_oven_dry_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_2.result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_2 INNER JOIN
                                                         dbo.preparation AS preparation_11 ON result_2.prep_key = preparation_11.prep_key
                               WHERE        (result_2.result_type = 'layer analyte') AND (result_2.result_source_key = q1.result_source_key) AND (preparation_11.prep_code = q1.prep_code) AND 
                                                         (result_2.analyte_key = 76)) AS mineral_content_loss_on_igniti,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_2.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_2 ON result_1.procedure_key = bridge_proced_ss_2.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_2.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (76))) AS mineral_content_loi_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_16
                               WHERE        (result_type = 'layer result') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (775))) AS estimated_organic_matter,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_15
                               WHERE        (result_type = 'layer result') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (776))) AS estimated_om_plus_mineral,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_1.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_1 ON result_1.procedure_key = bridge_proced_ss_1.procedure_key AND 
                                                         result_1.source_system_key = bridge_proced_ss_1.source_system_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT (result_1.result_value IS NULL)) AND 
                                                         (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key IN (240, 241, 777, 778))) AS fiber_analysis_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_11.result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_11 INNER JOIN
                                                         dbo.preparation AS preparation_10 ON result_11.prep_key = preparation_10.prep_key
                               WHERE        (result_11.result_type = 'layer analyte') AND (result_11.result_source_key = q1.result_source_key) AND (preparation_10.prep_code = q1.prep_code) 
                                                         AND (result_11.analyte_key = 241)) AS fiber_unrubbed,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_10.result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_10 INNER JOIN
                                                         dbo.preparation AS preparation_9 ON result_10.prep_key = preparation_9.prep_key
                               WHERE        (result_10.result_type = 'layer analyte') AND (result_10.result_source_key = q1.result_source_key) AND (preparation_9.prep_code = q1.prep_code) 
                                                         AND (result_10.analyte_key = 240)) AS fiber_rubbed,
                             (SELECT        TOP (1) result_value
                               FROM            dbo.result AS result_8
                               WHERE        (result_type = 'layer result') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (777))) AS decomposition_state,
                             (SELECT        TOP (1) result_7.result_value
                               FROM            dbo.result AS result_7 INNER JOIN
                                                         dbo.preparation AS preparation_7 ON result_7.prep_key = preparation_7.prep_key
                               WHERE        (result_7.result_type = 'layer analyte') AND (result_7.result_source_key = q1.result_source_key) AND (preparation_7.prep_code = q1.prep_code) AND 
                                                         (result_7.analyte_key = 778)) AS limnic_material_type
FROM            dbo.Physical_Properties_List AS q1
GROUP BY result_source_key, prep_code, natural_key

GO

