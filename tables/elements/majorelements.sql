USE [SSL_Repo]
GO

/****** Object:  View [dbo].[Major_And_Trace_Elements_And_Oxides]    Script Date: 10/26/2016 8:19:37 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[Major_And_Trace_Elements_And_Oxides]
AS
SELECT        result_source_key, natural_key, prep_code,
                             (SELECT        TOP (1) ISNULL(dbo.bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            dbo.result INNER JOIN
                                                         dbo.preparation ON dbo.result.prep_key = dbo.preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON dbo.result.procedure_key = dbo.bridge_proced_ss.procedure_key AND 
                                                         dbo.result.source_system_key = dbo.bridge_proced_ss.source_system_key
                               WHERE        (dbo.result.result_type = 'layer analyte') AND (dbo.result.result_value <> '') AND (NOT (dbo.result.result_value IS NULL)) AND 
                                                         (dbo.result.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (dbo.result.result_reliability IS NULL OR
                                                         dbo.result.result_reliability = '0') AND (dbo.result.analyte_key IN (491, 490, 492, 496, 493, 494, 498, 495, 497, 499, 500, 1207))) 
                         AS major_element_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_39.result_value, '8.0') AS decimal(8, 0)) AS Expr1
                               FROM            dbo.result AS result_39 INNER JOIN
                                                         dbo.preparation AS preparation_39 ON result_39.prep_key = preparation_39.prep_key
                               WHERE        (result_39.result_type = 'layer analyte') AND (result_39.result_source_key = q1.result_source_key) AND (preparation_39.prep_code = q1.prep_code) 
                                                         AND (result_39.analyte_key = 491)) AS aluminum_major_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_11.result_value, '8.0') AS decimal(8, 0)) AS Expr1
                               FROM            dbo.result AS result_11 INNER JOIN
                                                         dbo.preparation AS preparation_11 ON result_11.prep_key = preparation_11.prep_key
                               WHERE        (result_11.result_type = 'layer analyte') AND (result_11.result_source_key = q1.result_source_key) AND (preparation_11.prep_code = q1.prep_code) 
                                                         AND (result_11.analyte_key = 490)) AS calcium_major_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_10.result_value, '8.0') AS decimal(8, 0)) AS Expr1
                               FROM            dbo.result AS result_10 INNER JOIN
                                                         dbo.preparation AS preparation_10 ON result_10.prep_key = preparation_10.prep_key
                               WHERE        (result_10.result_type = 'layer analyte') AND (result_10.result_source_key = q1.result_source_key) AND (preparation_10.prep_code = q1.prep_code) 
                                                         AND (result_10.analyte_key = 492)) AS iron_major_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_9.result_value, '8.0') AS decimal(8, 0)) AS Expr1
                               FROM            dbo.result AS result_9 INNER JOIN
                                                         dbo.preparation AS preparation_9 ON result_9.prep_key = preparation_9.prep_key
                               WHERE        (result_9.result_type = 'layer analyte') AND (result_9.result_source_key = q1.result_source_key) AND (preparation_9.prep_code = q1.prep_code) AND 
                                                         (result_9.analyte_key = 496)) AS potassium_major_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_8.result_value, '8.0') AS decimal(8, 0)) AS Expr1
                               FROM            dbo.result AS result_8 INNER JOIN
                                                         dbo.preparation AS preparation_8 ON result_8.prep_key = preparation_8.prep_key
                               WHERE        (result_8.result_type = 'layer analyte') AND (result_8.result_source_key = q1.result_source_key) AND (preparation_8.prep_code = q1.prep_code) AND 
                                                         (result_8.analyte_key = 493)) AS magnesium_major_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_7.result_value, '8.0') AS decimal(8, 0)) AS Expr1
                               FROM            dbo.result AS result_7 INNER JOIN
                                                         dbo.preparation AS preparation_7 ON result_7.prep_key = preparation_7.prep_key
                               WHERE        (result_7.result_type = 'layer analyte') AND (result_7.result_source_key = q1.result_source_key) AND (preparation_7.prep_code = q1.prep_code) AND 
                                                         (result_7.analyte_key = 494)) AS manganese_major_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_6.result_value, '8.0') AS decimal(8, 0)) AS Expr1
                               FROM            dbo.result AS result_6 INNER JOIN
                                                         dbo.preparation AS preparation_6 ON result_6.prep_key = preparation_6.prep_key
                               WHERE        (result_6.result_type = 'layer analyte') AND (result_6.result_source_key = q1.result_source_key) AND (preparation_6.prep_code = q1.prep_code) AND 
                                                         (result_6.analyte_key = 498)) AS sodium_major_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_5.result_value, '8.0') AS decimal(8, 0)) AS Expr1
                               FROM            dbo.result AS result_5 INNER JOIN
                                                         dbo.preparation AS preparation_5 ON result_5.prep_key = preparation_5.prep_key
                               WHERE        (result_5.result_type = 'layer analyte') AND (result_5.result_source_key = q1.result_source_key) AND (preparation_5.prep_code = q1.prep_code) AND 
                                                         (result_5.analyte_key = 495)) AS phosphorus_major_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_4.result_value, '8.0') AS decimal(8, 0)) AS Expr1
                               FROM            dbo.result AS result_4 INNER JOIN
                                                         dbo.preparation AS preparation_4 ON result_4.prep_key = preparation_4.prep_key
                               WHERE        (result_4.result_type = 'layer analyte') AND (result_4.result_source_key = q1.result_source_key) AND (preparation_4.prep_code = q1.prep_code) AND 
                                                         (result_4.analyte_key = 497)) AS silicon_major_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_3.result_value, '8.0') AS decimal(10, 3)) AS Expr1
                               FROM            dbo.result AS result_3 INNER JOIN
                                                         dbo.preparation AS preparation_3 ON result_3.prep_key = preparation_3.prep_key
                               WHERE        (result_3.result_type = 'layer analyte') AND (result_3.result_source_key = q1.result_source_key) AND (preparation_3.prep_code = q1.prep_code) AND 
                                                         (result_3.analyte_key = 1207)) AS strontium_major_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_2.result_value, '8.0') AS decimal(8, 0)) AS Expr1
                               FROM            dbo.result AS result_2 INNER JOIN
                                                         dbo.preparation AS preparation_2 ON result_2.prep_key = preparation_2.prep_key
                               WHERE        (result_2.result_type = 'layer analyte') AND (result_2.result_source_key = q1.result_source_key) AND (preparation_2.prep_code = q1.prep_code) AND 
                                                         (result_2.analyte_key = 499)) AS titanium_major_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_1.result_value, '8.0') AS decimal(8, 0)) AS Expr1
                               FROM            dbo.result AS result_1 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_1.prep_key = preparation_1.prep_key
                               WHERE        (result_1.result_type = 'layer analyte') AND (result_1.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND 
                                                         (result_1.analyte_key = 500)) AS zirconium_major_element,
                             (SELECT        TOP (1) ISNULL(bridge_proced_ss_2.proced_code, '') AS Expr1
                               FROM            dbo.result AS result_38 INNER JOIN
                                                         dbo.preparation AS preparation_38 ON result_38.prep_key = preparation_38.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss AS bridge_proced_ss_2 ON result_38.procedure_key = bridge_proced_ss_2.procedure_key AND 
                                                         result_38.source_system_key = bridge_proced_ss_2.source_system_key
                               WHERE        (result_38.result_type = 'layer analyte') AND (result_38.result_value <> '') AND (NOT (result_38.result_value IS NULL)) AND 
                                                         (result_38.result_source_key = q1.result_source_key) AND (preparation_38.prep_code = q1.prep_code) AND (result_38.result_reliability IS NULL OR
                                                         result_38.result_reliability = '0') AND (result_38.analyte_key IN (1130, 1131, 1132, 1133, 501, 503, 502, 504, 507, 506, 1137, 508, 509, 505, 1134, 
                                                         1135, 1139, 1136, 1151, 1138, 1140, 510))) AS trace_element_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_37.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_37 INNER JOIN
                                                         dbo.preparation AS preparation_37 ON result_37.prep_key = preparation_37.prep_key
                               WHERE        (result_37.result_type = 'layer analyte') AND (result_37.result_source_key = q1.result_source_key) AND (preparation_37.prep_code = q1.prep_code) 
                                                         AND (result_37.analyte_key = 1130)) AS silver_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_36.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_36 INNER JOIN
                                                         dbo.preparation AS preparation_36 ON result_36.prep_key = preparation_36.prep_key
                               WHERE        (result_36.result_type = 'layer analyte') AND (result_36.result_source_key = q1.result_source_key) AND (preparation_36.prep_code = q1.prep_code) 
                                                         AND (result_36.analyte_key = 1131)) AS arsenic_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_35.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_35 INNER JOIN
                                                         dbo.preparation AS preparation_35 ON result_35.prep_key = preparation_35.prep_key
                               WHERE        (result_35.result_type = 'layer analyte') AND (result_35.result_source_key = q1.result_source_key) AND (preparation_35.prep_code = q1.prep_code) 
                                                         AND (result_35.analyte_key = 1132)) AS barium_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_34.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_34 INNER JOIN
                                                         dbo.preparation AS preparation_34 ON result_34.prep_key = preparation_34.prep_key
                               WHERE        (result_34.result_type = 'layer analyte') AND (result_34.result_source_key = q1.result_source_key) AND (preparation_34.prep_code = q1.prep_code) 
                                                         AND (result_34.analyte_key = 1133)) AS beryllium_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_33.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_33 INNER JOIN
                                                         dbo.preparation AS preparation_33 ON result_33.prep_key = preparation_33.prep_key
                               WHERE        (result_33.result_type = 'layer analyte') AND (result_33.result_source_key = q1.result_source_key) AND (preparation_33.prep_code = q1.prep_code) 
                                                         AND (result_33.analyte_key = 501)) AS cadmium_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_32.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_32 INNER JOIN
                                                         dbo.preparation AS preparation_32 ON result_32.prep_key = preparation_32.prep_key
                               WHERE        (result_32.result_type = 'layer analyte') AND (result_32.result_source_key = q1.result_source_key) AND (preparation_32.prep_code = q1.prep_code) 
                                                         AND (result_32.analyte_key = 503)) AS cobalt_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_31.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_31 INNER JOIN
                                                         dbo.preparation AS preparation_31 ON result_31.prep_key = preparation_31.prep_key
                               WHERE        (result_31.result_type = 'layer analyte') AND (result_31.result_source_key = q1.result_source_key) AND (preparation_31.prep_code = q1.prep_code) 
                                                         AND (result_31.analyte_key = 502)) AS chromium_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_30.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_30 INNER JOIN
                                                         dbo.preparation AS preparation_30 ON result_30.prep_key = preparation_30.prep_key
                               WHERE        (result_30.result_type = 'layer analyte') AND (result_30.result_source_key = q1.result_source_key) AND (preparation_30.prep_code = q1.prep_code) 
                                                         AND (result_30.analyte_key = 504)) AS copper_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_29.result_value, '8.0') AS decimal(8, 0)) AS Expr1
                               FROM            dbo.result AS result_29 INNER JOIN
                                                         dbo.preparation AS preparation_29 ON result_29.prep_key = preparation_29.prep_key
                               WHERE        (result_29.result_type = 'layer analyte') AND (result_29.result_source_key = q1.result_source_key) AND (preparation_29.prep_code = q1.prep_code) 
                                                         AND (result_29.analyte_key = 507)) AS mercury_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_28.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_28 INNER JOIN
                                                         dbo.preparation AS preparation_28 ON result_28.prep_key = preparation_28.prep_key
                               WHERE        (result_28.result_type = 'layer analyte') AND (result_28.result_source_key = q1.result_source_key) AND (preparation_28.prep_code = q1.prep_code) 
                                                         AND (result_28.analyte_key = 506)) AS manganese_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_27.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_27 INNER JOIN
                                                         dbo.preparation AS preparation_27 ON result_27.prep_key = preparation_27.prep_key
                               WHERE        (result_27.result_type = 'layer analyte') AND (result_27.result_source_key = q1.result_source_key) AND (preparation_27.prep_code = q1.prep_code) 
                                                         AND (result_27.analyte_key = 1137)) AS molybdenum_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_26.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_26 INNER JOIN
                                                         dbo.preparation AS preparation_26 ON result_26.prep_key = preparation_26.prep_key
                               WHERE        (result_26.result_type = 'layer analyte') AND (result_26.result_source_key = q1.result_source_key) AND (preparation_26.prep_code = q1.prep_code) 
                                                         AND (result_26.analyte_key = 508)) AS nickel_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_25.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_25 INNER JOIN
                                                         dbo.preparation AS preparation_25 ON result_25.prep_key = preparation_25.prep_key
                               WHERE        (result_25.result_type = 'layer analyte') AND (result_25.result_source_key = q1.result_source_key) AND (preparation_25.prep_code = q1.prep_code) 
                                                         AND (result_25.analyte_key = 509)) AS phosphorus_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_24.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_24 INNER JOIN
                                                         dbo.preparation AS preparation_24 ON result_24.prep_key = preparation_24.prep_key
                               WHERE        (result_24.result_type = 'layer analyte') AND (result_24.result_source_key = q1.result_source_key) AND (preparation_24.prep_code = q1.prep_code) 
                                                         AND (result_24.analyte_key = 505)) AS lead_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_23.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_23 INNER JOIN
                                                         dbo.preparation AS preparation_23 ON result_23.prep_key = preparation_23.prep_key
                               WHERE        (result_23.result_type = 'layer analyte') AND (result_23.result_source_key = q1.result_source_key) AND (preparation_23.prep_code = q1.prep_code) 
                                                         AND (result_23.analyte_key = 1134)) AS antimony_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_22.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_22 INNER JOIN
                                                         dbo.preparation AS preparation_22 ON result_22.prep_key = preparation_22.prep_key
                               WHERE        (result_22.result_type = 'layer analyte') AND (result_22.result_source_key = q1.result_source_key) AND (preparation_22.prep_code = q1.prep_code) 
                                                         AND (result_22.analyte_key = 1135)) AS selenium_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_21.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_21 INNER JOIN
                                                         dbo.preparation AS preparation_21 ON result_21.prep_key = preparation_21.prep_key
                               WHERE        (result_21.result_type = 'layer analyte') AND (result_21.result_source_key = q1.result_source_key) AND (preparation_21.prep_code = q1.prep_code) 
                                                         AND (result_21.analyte_key = 1139)) AS tin_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_20.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_20 INNER JOIN
                                                         dbo.preparation AS preparation_20 ON result_20.prep_key = preparation_20.prep_key
                               WHERE        (result_20.result_type = 'layer analyte') AND (result_20.result_source_key = q1.result_source_key) AND (preparation_20.prep_code = q1.prep_code) 
                                                         AND (result_20.analyte_key = 1136)) AS strontium_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_19.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_19 INNER JOIN
                                                         dbo.preparation AS preparation_19 ON result_19.prep_key = preparation_19.prep_key
                               WHERE        (result_19.result_type = 'layer analyte') AND (result_19.result_source_key = q1.result_source_key) AND (preparation_19.prep_code = q1.prep_code) 
                                                         AND (result_19.analyte_key = 1151)) AS thallium_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_18.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_18 INNER JOIN
                                                         dbo.preparation AS preparation_18 ON result_18.prep_key = preparation_18.prep_key
                               WHERE        (result_18.result_type = 'layer analyte') AND (result_18.result_source_key = q1.result_source_key) AND (preparation_18.prep_code = q1.prep_code) 
                                                         AND (result_18.analyte_key = 1138)) AS vanadium_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_17.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_17 INNER JOIN
                                                         dbo.preparation AS preparation_17 ON result_17.prep_key = preparation_17.prep_key
                               WHERE        (result_17.result_type = 'layer analyte') AND (result_17.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                                                         AND (result_17.analyte_key = 1140)) AS tungsten_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_16.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_16 INNER JOIN
                                                         dbo.preparation AS preparation_16 ON result_16.prep_key = preparation_16.prep_key
                               WHERE        (result_16.result_type = 'layer analyte') AND (result_16.result_source_key = q1.result_source_key) AND (preparation_16.prep_code = q1.prep_code) 
                                                         AND (result_16.analyte_key = 510)) AS zinc_trace_element,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_14.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_14 
                               WHERE        (result_14.result_type = 'layer result') AND (result_14.result_source_key = q1.result_source_key) AND ('S' = q1.prep_code) 
                                                         AND (result_14.analyte_key = 818)) AS iron_oxide_total,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_13.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_13 
                               WHERE        (result_13.result_type = 'layer result') AND (result_13.result_source_key = q1.result_source_key) AND ('S' = q1.prep_code) 
                                                         AND (result_13.analyte_key = 819)) AS aluminum_oxide_total,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_12.result_value, '8.2') AS decimal(8, 2)) AS Expr1
                               FROM            dbo.result AS result_12 
                               WHERE        (result_12.result_type = 'layer result') AND (result_12.result_source_key = q1.result_source_key) AND ('S' = q1.prep_code) 
                                                         AND (result_12.analyte_key = 820)) AS potassium_oxide_total
FROM            dbo.Major_And_Trace_Elements_Oxides_List AS q1
GROUP BY result_source_key, natural_key, prep_code


GO

