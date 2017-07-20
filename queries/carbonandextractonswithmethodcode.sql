USE [SSL_Repo]
GO

/****** Object:  View [dbo].[Carbon_and_Extractions_with_Method_Code]    Script Date: 10/26/2016 8:17:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





ALTER VIEW [dbo].[Carbon_and_Extractions_with_Method_Code]
AS
SELECT        TOP (100) PERCENT natural_key, result_source_key, prep_code,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(dbo.result.result_value, '4.2') AS decimal(10, 3)) Expr1
                               FROM            dbo.result INNER JOIN dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key IN (45, 460))) AS c_tot,
                             (SELECT        TOP (1) ISNULL(dbo.result.method_code, '') AS Expr1 
                               FROM            dbo.result INNER JOIN dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key IN (45, 460))) AS c_tot_code,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_17.result_value, '5.3') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_17 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_17.prep_key = preparation_17.prep_key
                               WHERE        (result_17.result_type = 'layer analyte') AND (result_17.result_value <> '') AND (NOT result_17.result_value IS NULL) AND 
                                                         (result_17.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) AND (result_17.result_reliability IS NULL OR
                                                         result_17.result_reliability = '0') AND (result_17.analyte_key IN (79, 461))) AS n_tot,
                             (SELECT        TOP (1) ISNULL(dbo.result.method_code, '') AS Expr1 
                               FROM            dbo.result INNER JOIN dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key IN (79, 461))) AS n_tot_code,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_16.result_value, '4.2') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_16 INNER JOIN
                                                         dbo.preparation AS preparation_16 ON result_16.prep_key = preparation_16.prep_key
                               WHERE        (result_16.result_type = 'layer analyte') AND (result_16.result_value <> '') AND (NOT result_16.result_value IS NULL) AND 
                                                         (result_16.result_source_key = q1.result_source_key) AND (preparation_16.prep_code = q1.prep_code) AND (result_16.result_reliability IS NULL OR
                                                         result_16.result_reliability = '0') AND (result_16.analyte_key IN (362, 462))) AS s_tot,
                             (SELECT        TOP (1) ISNULL(dbo.result.method_code, '') AS Expr1 
                               FROM            dbo.result INNER JOIN dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key IN (362, 462))) AS s_tot_code,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_15.result_value, '4.2') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_15 INNER JOIN
                                                         dbo.preparation AS preparation_15 ON result_15.prep_key = preparation_15.prep_key
                               WHERE        (result_15.result_type = 'layer analyte') AND (result_15.result_value <> '') AND (NOT result_15.result_value IS NULL) AND 
                                                         (result_15.result_source_key = q1.result_source_key) AND (preparation_15.prep_code = q1.prep_code) AND (result_15.result_reliability IS NULL OR
                                                         result_15.result_reliability = '0') AND (result_15.analyte_key = 780)) AS oc,
                             (SELECT        TOP (1) ISNULL(dbo.result.method_code, '') AS Expr1 
                               FROM            dbo.result INNER JOIN dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 780)) AS oc_code,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key IN (559, 647))
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key = 1078)
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key = 1076)
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key = 1077)
                                                         UNION
                                                         SELECT        result_value, 'HM' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key = 1079)) 
                                                         AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS c_n_ra,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_13.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_13 INNER JOIN
                                                         dbo.preparation AS preparation_13 ON result_13.prep_key = preparation_13.prep_key
                               WHERE        (result_13.result_type = 'layer analyte') AND (result_13.result_value <> '') AND (NOT result_13.result_value IS NULL) AND (result_13.result_source_key = q1.result_source_key) AND 
                                                         (preparation_13.prep_code = q1.prep_code) AND (result_13.result_reliability IS NULL OR
                                                         result_13.result_reliability = '0') AND (result_13.analyte_key = 52)) AS fe_dith,
                             (SELECT        TOP (1) ISNULL(dbo.result.method_code, '') AS Expr1 
                               FROM            dbo.result INNER JOIN dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 52)) AS fe_dith_code,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_12.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_12 INNER JOIN
                                                         dbo.preparation AS preparation_12 ON result_12.prep_key = preparation_12.prep_key
                               WHERE        (result_12.result_type = 'layer analyte') AND (result_12.result_value <> '') AND (NOT result_12.result_value IS NULL) AND (result_12.result_source_key = q1.result_source_key) AND 
                                                         (preparation_12.prep_code = q1.prep_code) AND (result_12.result_reliability IS NULL OR
                                                         result_12.result_reliability = '0') AND (result_12.analyte_key = 51)) AS al_dith,
                             (SELECT        TOP (1) ISNULL(dbo.result.method_code, '') AS Expr1 
                               FROM            dbo.result INNER JOIN dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 51)) AS al_dith_code,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_11.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_11 INNER JOIN
                                                         dbo.preparation AS preparation_11 ON result_11.prep_key = preparation_11.prep_key
                               WHERE        (result_11.result_type = 'layer analyte') AND (result_11.result_value <> '') AND (NOT result_11.result_value IS NULL) AND (result_11.result_source_key = q1.result_source_key) AND 
                                                         (preparation_11.prep_code = q1.prep_code) AND (result_11.result_reliability IS NULL OR
                                                         result_11.result_reliability = '0') AND (result_11.analyte_key = 53)) AS mn_dith,
                             (SELECT        TOP (1) ISNULL(dbo.result.method_code, '') AS Expr1 
                               FROM            dbo.result INNER JOIN dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 53)) AS mn_dith_code,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key IN (690, 691, 
                                                                                   1071, 1090, 1851))
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key IN (692, 693, 
                                                                                  1072, 1091, 1848))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key IN (696, 697, 
                                                                                  1074, 1093, 1850))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key IN (698, 699, 
                                                                                  1075, 1094, 1846))
                                                         UNION
                                                         SELECT        result_value, 'HM' AS prep_code
                                                         FROM            dbo.result
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND (result_source_key = q1.result_source_key) AND (analyte_key IN (694, 695, 
                                                                                  1073, 1092, 1847))) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS al_fe_ox,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_9.result_value, '4.2') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_9 INNER JOIN
                                                         dbo.preparation AS preparation_9 ON result_9.prep_key = preparation_9.prep_key
                               WHERE        (result_9.result_type = 'layer analyte') AND (result_9.result_value <> '') AND (NOT result_9.result_value IS NULL) AND (result_9.result_source_key = q1.result_source_key) AND 
                                                         (preparation_9.prep_code = q1.prep_code) AND (result_9.result_reliability IS NULL OR
                                                         result_9.result_reliability = '0') AND (result_9.analyte_key = 452)) AS optd_ox,
                             (SELECT        TOP (1) ISNULL(dbo.result.method_code, '') AS Expr1 
                               FROM            dbo.result INNER JOIN dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 452)) AS optd_ox_code,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_8.result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_8 INNER JOIN
                                                         dbo.preparation AS preparation_8 ON result_8.prep_key = preparation_8.prep_key
                               WHERE        (result_8.result_type = 'layer analyte') AND (result_8.result_value <> '') AND (NOT result_8.result_value IS NULL) AND (result_8.result_source_key = q1.result_source_key) AND 
                                                         (preparation_8.prep_code = q1.prep_code) AND (result_8.result_reliability IS NULL OR
                                                         result_8.result_reliability = '0') AND (result_8.analyte_key = 47)) AS fe_ox,
                             (SELECT        TOP (1) ISNULL(dbo.result.method_code, '') AS Expr1 
                               FROM            dbo.result INNER JOIN dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 47)) AS fe_ox_code,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_7.result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_7 INNER JOIN
                                                         dbo.preparation AS preparation_7 ON result_7.prep_key = preparation_7.prep_key
                               WHERE        (result_7.result_type = 'layer analyte') AND (result_7.result_value <> '') AND (NOT result_7.result_value IS NULL) AND (result_7.result_source_key = q1.result_source_key) AND 
                                                         (preparation_7.prep_code = q1.prep_code) AND (result_7.result_reliability IS NULL OR
                                                         result_7.result_reliability = '0') AND (result_7.analyte_key = 46)) AS al_ox,
                             (SELECT        TOP (1) ISNULL(dbo.result.method_code, '') AS Expr1 
                               FROM            dbo.result INNER JOIN dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 46)) AS al_ox_code,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_6.result_value, '7.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_6 INNER JOIN
                                                         dbo.preparation AS preparation_6 ON result_6.prep_key = preparation_6.prep_key
                               WHERE        (result_6.result_type = 'layer analyte') AND (result_6.result_value <> '') AND (NOT result_6.result_value IS NULL) AND (result_6.result_source_key = q1.result_source_key) AND 
                                                         (preparation_6.prep_code = q1.prep_code) AND (result_6.result_reliability IS NULL OR
                                                         result_6.result_reliability = '0') AND (result_6.analyte_key = 48)) AS mn_ox,
                             (SELECT        TOP (1) ISNULL(dbo.result.method_code, '') AS Expr1 
                               FROM            dbo.result INNER JOIN dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 48)) AS mn_ox_code,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_5.result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_5 INNER JOIN
                                                         dbo.preparation AS preparation_5 ON result_5.prep_key = preparation_5.prep_key
                               WHERE        (result_5.result_type = 'layer analyte') AND (result_5.result_value <> '') AND (NOT result_5.result_value IS NULL) AND (result_5.result_source_key = q1.result_source_key) AND 
                                                         (preparation_5.prep_code = q1.prep_code) AND (result_5.result_reliability IS NULL OR
                                                         result_5.result_reliability = '0') AND (result_5.analyte_key = 50)) AS si_ox,
                             (SELECT        TOP (1) ISNULL(dbo.result.method_code, '') AS Expr1 
                               FROM            dbo.result INNER JOIN dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 50)) AS si_ox_code,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_4.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_4 INNER JOIN
                                                         dbo.preparation AS preparation_4 ON result_4.prep_key = preparation_4.prep_key
                               WHERE        (result_4.result_type = 'layer analyte') AND (result_4.result_value <> '') AND (NOT result_4.result_value IS NULL) AND (result_4.result_source_key = q1.result_source_key) AND 
                                                         (preparation_4.prep_code = q1.prep_code) AND (result_4.result_reliability IS NULL OR
                                                         result_4.result_reliability = '0') AND (result_4.analyte_key = 58)) AS c_pyp,
                             (SELECT        TOP (1) ISNULL(dbo.result.method_code, '') AS Expr1 
                               FROM            dbo.result INNER JOIN dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 58)) AS c_pyp_code,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_3.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_3 INNER JOIN
                                                         dbo.preparation AS preparation_3 ON result_3.prep_key = preparation_3.prep_key
                               WHERE        (result_3.result_type = 'layer analyte') AND (result_3.result_value <> '') AND (NOT result_3.result_value IS NULL) AND (result_3.result_source_key = q1.result_source_key) AND 
                                                         (preparation_3.prep_code = q1.prep_code) AND (result_3.result_reliability IS NULL OR
                                                         result_3.result_reliability = '0') AND (result_3.analyte_key = 59)) AS fe_pyp,
                             (SELECT        TOP (1) ISNULL(dbo.result.method_code, '') AS Expr1 
                               FROM            dbo.result INNER JOIN dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 59)) AS fe_pyp_code,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_2.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_2 INNER JOIN
                                                         dbo.preparation AS preparation_2 ON result_2.prep_key = preparation_2.prep_key
                               WHERE        (result_2.result_type = 'layer analyte') AND (result_2.result_value <> '') AND (NOT result_2.result_value IS NULL) AND (result_2.result_source_key = q1.result_source_key) AND 
                                                         (preparation_2.prep_code = q1.prep_code) AND (result_2.result_reliability IS NULL OR
                                                         result_2.result_reliability = '0') AND (result_2.analyte_key = 57)) AS al_pyp,
                             (SELECT        TOP (1) ISNULL(dbo.result.method_code, '') AS Expr1 
                               FROM            dbo.result INNER JOIN dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 57)) AS al_pyp_code,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_value <> '') AND (NOT result_1.result_value IS NULL) AND (result_1.result_source_key = q1.result_source_key) AND 
                                                         (preparation_1.prep_code = q1.prep_code) AND (result_1.result_reliability IS NULL OR
                                                         result_1.result_reliability = '0') AND (result_1.analyte_key = 60)) AS mn_pyp,
                             (SELECT        TOP (1) ISNULL(dbo.result.method_code, '') AS Expr1 
                               FROM            dbo.result INNER JOIN dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT dbo.result.result_value IS NULL) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key = 60)) AS mn_pyp_code

FROM            dbo.octier10list AS q1
GROUP BY result_source_key, prep_code, natural_key
HAVING        (NOT (prep_code IS NULL))





GO

