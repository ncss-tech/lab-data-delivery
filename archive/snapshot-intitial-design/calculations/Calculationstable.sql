USE [SSL_Repo]
GO

/****** Object:  View [dbo].[Calculations_Including_Estimates_And_Default_Values]    Script Date: 10/26/2016 8:17:01 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[Calculations_Including_Estimates_And_Default_Values]
AS
SELECT        dbo.layer.natural_key, q1.result_source_key, q1.prep_code,
							ISNULL((SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '4.2') AS decimal(4, 2)))
														FROM          result
														WHERE      result_type = 'layer analyte' AND dbo.result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																					   result.analyte_key = 4),
							ISNULL((SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '4.2') AS decimal(4, 2)))
														FROM          result
														WHERE      result_type = 'layer analyte' AND dbo.result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																			   result.analyte_key = 25),
							ISNULL((SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '4.2') AS decimal(4, 2)))
														FROM          result
														WHERE      result_type = 'layer analyte' AND dbo.result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																			   result.analyte_key = 28),
							1.45))) 
						AS bulk_density_3rd_bar_for_calc,
							CASE WHEN NOT (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '4.2') AS decimal(4, 2)))
														FROM          result
														WHERE      result_type = 'layer analyte' AND dbo.result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																			   result.analyte_key = 4) IS NULL THEN 'db_13b'
								 WHEN NOT (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '4.2') AS decimal(4, 2)))
														FROM          result
														WHERE      result_type = 'layer analyte' AND dbo.result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																			   result.analyte_key = 25) IS NULL THEN 'db_3rw'
								 WHEN NOT (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '4.2') AS decimal(4, 2)))
														FROM          result
														WHERE      result_type = 'layer analyte' AND dbo.result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																			   result.analyte_key = 28) IS NULL THEN 'db_3est'
								 ELSE 'default'
							END 
						AS bulk_density_3rd_bar_source,
							ISNULL((SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '4.2') AS decimal(4, 2)))
														FROM          result
														WHERE      result_type = 'layer analyte' AND dbo.result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																					   result.analyte_key = 243),
							ISNULL((SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '4.2') AS decimal(4, 2)))
														FROM          result
														WHERE      result_type = 'layer analyte' AND dbo.result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																			   result.analyte_key = 242),
							2.65)) 
						AS particle_density_for_calc,
							CASE WHEN NOT (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '4.2') AS decimal(4, 2)))
														FROM          result
														WHERE      result_type = 'layer analyte' AND dbo.result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																			   result.analyte_key = 243) IS NULL THEN 'pd_g2'
								 WHEN NOT (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '4.2') AS decimal(4, 2)))
														FROM          result
														WHERE      result_type = 'layer analyte' AND dbo.result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																			   result.analyte_key = 242) IS NULL THEN 'pd_l2'
								 ELSE 'default'
							END 
						AS particle_density_calc_sour,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_42
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (590))) 
                         AS bulk_density_third_bar_ws, 
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_41
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (591))) 
                         AS bulk_density_oven_dry_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_40
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (593))) 
                         AS bulk_density_saturated_whole_so,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_34
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (516))) 
                         AS bulk_density_whole_soil_moist,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.0') AS decimal(15, 3)))
                            FROM          result
                            WHERE      result_type = 'layer result' AND dbo.result.result_value <> '' AND result_source_key = q1.result_source_key AND 
                                                   result.analyte_key IN (600)) 
						AS weight_percent_gt_2_mm_ws,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.0') AS decimal(15, 3)))
                            FROM          result
                            WHERE      result_type = 'layer result' AND dbo.result.result_value <> '' AND result_source_key = q1.result_source_key AND 
                                                   result.analyte_key IN (614)) 
						AS weight_percent_gt_250_mm_ws,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.0') AS decimal(15, 3)))
                            FROM          result
                            WHERE      result_type = 'layer result' AND dbo.result.result_value <> '' AND result_source_key = q1.result_source_key AND 
                                                   result.analyte_key IN (617)) 
						AS weight_pct_75_to_250_mm_ws,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.0') AS decimal(15, 3)))
                            FROM          result
                            WHERE      result_type = 'layer result' AND dbo.result.result_value <> '' AND result_source_key = q1.result_source_key AND 
                                                   result.analyte_key IN (610)) 
						AS weight_pct_2_to_75_mm_ws,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.0') AS decimal(15, 3)))
                            FROM          result
                            WHERE      result_type = 'layer result' AND dbo.result.result_value <> '' AND result_source_key = q1.result_source_key AND 
                                                   result.analyte_key IN (613)) 
						AS weight_pct_20_to_75_mm_ws,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.0') AS decimal(15, 3)))
                            FROM          result
                            WHERE      result_type = 'layer result' AND dbo.result.result_value <> '' AND result_source_key = q1.result_source_key AND 
                                                   result.analyte_key IN (615)) 
						AS weight_pct_5_to_20_mm_ws,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.0') AS decimal(15, 3)))
                            FROM          result
                            WHERE      result_type = 'layer result' AND dbo.result.result_value <> '' AND result_source_key = q1.result_source_key AND 
                                                   result.analyte_key IN (594)) 
						AS weight_pct_2_to_5_mm_ws,
                          (SELECT     TOP 1 (cast(dbo.AsymArithRnd(dbo.result.result_value, '3.0') AS decimal(15, 3)))
                            FROM          result
                            WHERE      result_type = 'layer result' AND dbo.result.result_value <> '' AND result_source_key = q1.result_source_key AND 
                                                   result.analyte_key IN (598)) 
						AS weight_pct_less_than_2_mm_ws,




                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_34
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (575))) 
						AS volume_pct_gt_2_mm_thirdbarws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_33
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (580))) 
						AS volume_pct_gt_250_mm_thirdbarw,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_32
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (582))) 
						AS volume_pct_75_to_250_mm_third,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_31
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (578))) 
						AS volume_pct_2_to_75_mm_third_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_30
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (579))) 
						AS volume_pct_20_to_75_mm_third_w,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_29
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (581))) 
						AS volume_pct_5_to_20_mm_third_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_28
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (577))) 
						AS volume_pct_2_to_5_mm_third_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_27
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (574))) 
						AS volume_pct_lt_2_mm_third_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_26
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (583))) 
						AS volume_pct_usda_sand_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_25
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (576))) 
						AS vol_pct_usda_silt_third_bar_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_24
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (573))) 
						AS volume_pct_usda_clay_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (555))) 
                         AS pct_pores_drained_third_bar_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_35
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (556))) 
                         AS pct_pores_filled_third_bar_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_1
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (599))) 
                         AS wt_pct_gt_2_mm_clay_free_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_20
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (612))) 
                         AS wt_pct_2_75_mm_clay_free_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_19
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (611))) 
                         AS wt_pct_2_20_mm_clay_free_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_18
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (604))) 
                         AS wt_pct_sand_clay_free_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_17
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (602))) 
                         AS wt_pct_silt_clay_free_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_16
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (596))) 
                         AS wt_pct_tot_clay_clay_free_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_15
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (609))) 
                         AS wt_pct_vcs_clay_free_lt2mmbase,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_14
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (608))) 
                         AS wt_pct_cs_clay_free_lt2mmbase,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_13
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (607))) 
                         AS wt_pct_ms_clay_free_lt2mmbase,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_12
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (605))) 
                         AS wt_pct_fs_clay_free_lt2mmbase,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_11
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (587))) 
                         AS wt_pct_vfs_clay_free_lt2mmbase,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_10
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (603))) 
                         AS wt_pct_csi_clay_free_lt2mmbase,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_9
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (601))) 
                         AS wt_pct_fsi_clay_free_lt2mmbase,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_8
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (595))) 
                         AS wt_pct_clay_clay_free_2mmbase,
                          (SELECT     TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                            FROM          dbo.result AS result_5
                            WHERE      (result_type = 'layer result') AND (result_value <> '') AND (isnumeric(result_value) = 1) AND (result_source_key = q1.result_source_key) AND 
                                                   (analyte_key IN (628))) 
						AS wf_25,
                          (SELECT     TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                            FROM          dbo.result AS result_4
                            WHERE      (result_type = 'layer result') AND (result_value <> '') AND (isnumeric(result_value) = 1) AND (result_source_key = q1.result_source_key) AND 
                                                   (analyte_key IN (631))) 
						AS wf_520,
                          (SELECT     TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                            FROM          dbo.result AS result_3
                            WHERE      (result_type = 'layer result') AND (result_value <> '') AND (isnumeric(result_value) = 1) AND (result_source_key = q1.result_source_key) AND 
                                                   (analyte_key IN (630))) 
						AS wf_2075,
                          (SELECT     TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                            FROM          dbo.result AS result_2
                            WHERE      (result_type = 'layer result') AND (result_value <> '') AND (isnumeric(result_value) = 1) AND (result_source_key = q1.result_source_key) AND 
                                                   (analyte_key IN (606))) 
						AS wf_0175,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM            dbo.result
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (547))) 
						AS percent_passing_3_inch_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM            dbo.result
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (544))) 
						AS percent_passing_2_inch_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM            dbo.result AS result_65
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (542))) 
						AS percent_passing_1_and_1_half,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM            dbo.result AS result_64
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (543))) 
						AS percent_passing_1_inch_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM            dbo.result AS result_63
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (548)))
						AS percent_passing_3_quarter_inch,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM            dbo.result AS result_62
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (549))) 
						AS percent_passing_3_eights_inch,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM            dbo.result AS result_61
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (553))) 
                         AS percent_passing_no_4_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM            dbo.result AS result_60
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (551))) 
                         AS percent_passing_no_10_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM            dbo.result AS result_59
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (554))) 
                         AS percent_passing_no_40_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM            dbo.result AS result_58
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (552))) 
                         AS percent_passing_no_200_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM            dbo.result AS result_57
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (546))) 
                         AS percent_passing_20_micron_siev,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM            dbo.result AS result_56
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (550))) 
                         AS percent_passing_5_micron_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM            dbo.result AS result_55
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (545))) 
                         AS percent_passing_2_micron_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM            dbo.result AS result_54
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (528))) 
                         AS cumulative_curve_less_than_1mm,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM            dbo.result AS result_53
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (526))) 
                         AS cumulative_curve_lt_1_half_mm,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM            dbo.result AS result_52
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (525))) 
                         AS cumulative_curve_lt_1_fourthmm,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM            dbo.result AS result_51
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (524))) 
                         AS cumulative_curve_lt_1_tenth_mm,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM            dbo.result AS result_50
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (523))) 
                         AS cumulative_curve_lt_5_hundredt,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '5.2') AS decimal(12, 2)) AS Expr1
                               FROM            dbo.result AS result_49
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (530))) 
                         AS cumulative_curve_size_lt_60_pe,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '6.3') AS decimal(13, 3)) AS Expr1
                               FROM            dbo.result AS result_48
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (529))) 
                         AS cumulative_curve_size_lt_50_pe,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '6.3') AS decimal(13, 3)) AS Expr1
                               FROM            dbo.result AS result_47
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (527))) 
                         AS cumulative_curve_size_lt_10_pe,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '7.1') AS decimal(13, 1)) AS Expr1
                               FROM            dbo.result AS result_44
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (534))) 
                         AS gradiation_uniformity,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(11, 1)) AS Expr1
                               FROM            dbo.result AS result_43
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (533))) 
                         AS gradation_curvature,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_7
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (538))) 
						AS le_third_ovendry_whole_soi,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_7
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (537))) 
						AS le_third_bar_to_oven_dry_rewet,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_8
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (539))) 
						AS le_third_fifteen_whole_soil,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_31
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (571))) 
                         AS void_ratio_third_bar_lt_2_mm,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_32
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (572))) 
                         AS void_ratio_third_bar_whole_soi,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_32
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (586))) 
                         AS water_retention_difference_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_32
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (555))) 
                         AS pores_drained_third_bar_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM            dbo.result AS result_32
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key IN (556))) 
                         AS pores_filled_third_bar_ws--,


FROM            dbo.supp4tier19list AS q1 INNER JOIN
                         dbo.layer ON q1.result_source_key = dbo.layer.layer_key INNER JOIN
                         dbo.site_area_selection ON dbo.layer.site_key = dbo.site_area_selection.site_key
GROUP BY q1.result_source_key, q1.prep_code, dbo.layer.natural_key


GO

