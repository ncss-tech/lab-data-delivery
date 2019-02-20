GO
SET STATISTICS IO ON
GO

DROP TABLE IF EXISTS SDA_Calculations_Including_Estimates_And_Default_Values

SELECT DISTINCT

--1
c1.labsampnum,c1.result_source_key,c1.prep_code,bulk_density_3rd_bar_for_calc,bulk_density_3rd_bar_source,particle_density_for_calc,particle_density_calc_sour,bulk_density_third_bar_ws,bulk_density_oven_dry_ws,bulk_density_saturated_whole_so, 
--2
volume_pct_lt_2_mm_third_ws,volume_pct_usda_sand_ws,vol_pct_usda_silt_third_bar_ws,volume_pct_usda_clay_ws,pct_pores_drained_third_bar_ws,pct_pores_filled_third_bar_ws,wt_pct_gt_2_mm_clay_free_ws,wt_pct_2_75_mm_clay_free_ws,wt_pct_2_20_mm_clay_free_ws,wt_pct_sand_clay_free_ws,wt_pct_silt_clay_free_ws,wt_pct_tot_clay_clay_free_ws,wt_pct_vcs_clay_free_lt2mmbase,wt_pct_cs_clay_free_lt2mmbase,wt_pct_ms_clay_free_lt2mmbase,wt_pct_fs_clay_free_lt2mmbase,wt_pct_vfs_clay_free_lt2mmbase,wt_pct_csi_clay_free_lt2mmbase,wt_pct_fsi_clay_free_lt2mmbase,wt_pct_clay_clay_free_2mmbase,wf_25,wf_520,wf_2075,wf_0175,percent_passing_3_inch_sieve,
--3
bulk_density_whole_soil_moist,weight_percent_gt_2_mm_ws,weight_percent_gt_250_mm_ws,weight_pct_75_to_250_mm_ws,weight_pct_2_to_75_mm_ws,weight_pct_20_to_75_mm_ws,weight_pct_5_to_20_mm_ws,
--4
cumulative_curve_lt_1_fourthmm,cumulative_curve_lt_1_tenth_mm,cumulative_curve_lt_5_hundredt,cumulative_curve_size_lt_60_pe,cumulative_curve_size_lt_50_pe,cumulative_curve_size_lt_10_pe,gradiation_uniformity,gradation_curvature,le_third_ovendry_whole_soi,le_third_bar_to_oven_dry_rewet,le_third_fifteen_whole_soil,void_ratio_third_bar_lt_2_mm,void_ratio_third_bar_whole_soi,water_retention_difference_ws,pores_drained_third_bar_ws,pores_filled_third_bar_ws,

--5
weight_pct_2_to_5_mm_ws,weight_pct_less_than_2_mm_ws,volume_pct_gt_2_mm_thirdbarws,volume_pct_gt_250_mm_thirdbarw,volume_pct_75_to_250_mm_third,volume_pct_2_to_75_mm_third_ws,volume_pct_20_to_75_mm_third_w,volume_pct_5_to_20_mm_third_ws,volume_pct_2_to_5_mm_third_ws,
--6
percent_passing_2_inch_sieve,percent_passing_1_and_1_half,percent_passing_1_inch_sieve,percent_passing_3_quarter_inch,percent_passing_3_eights_inch,percent_passing_no_4_sieve,percent_passing_no_10_sieve,percent_passing_no_40_sieve,percent_passing_no_200_sieve,percent_passing_20_micron_siev,percent_passing_5_micron_sieve,percent_passing_2_micron_sieve,cumulative_curve_less_than_1mm,cumulative_curve_lt_1_half_mm

INTO SDA_Calculations_Including_Estimates_And_Default_Values
FROM   SDA_Calculations_Including_Estimates_And_Default_Values1 AS c1
INNER JOIN SDA_Calculations_Including_Estimates_And_Default_Values2 AS c2  ON c2.result_source_key = c1.result_source_key 
INNER JOIN  SDA_Calculations_Including_Estimates_And_Default_Values3 AS c3  ON c3.result_source_key = c1.result_source_key 
INNER JOIN SDA_Calculations_Including_Estimates_And_Default_Values4 AS c4  ON c4.result_source_key = c1.result_source_key 
INNER JOIN SDA_Calculations_Including_Estimates_And_Default_Values5 AS c5  ON c5.result_source_key = c1.result_source_key 
INNER JOIN SDA_Calculations_Including_Estimates_And_Default_Values6 AS c6  ON c6.result_source_key = c1.result_source_key 
GROUP BY --1
c1.labsampnum,c1.result_source_key,c1.prep_code,bulk_density_3rd_bar_for_calc,bulk_density_3rd_bar_source,particle_density_for_calc,particle_density_calc_sour,bulk_density_third_bar_ws,bulk_density_oven_dry_ws,bulk_density_saturated_whole_so, 
--2
volume_pct_lt_2_mm_third_ws,volume_pct_usda_sand_ws,vol_pct_usda_silt_third_bar_ws,volume_pct_usda_clay_ws,pct_pores_drained_third_bar_ws,pct_pores_filled_third_bar_ws,wt_pct_gt_2_mm_clay_free_ws,wt_pct_2_75_mm_clay_free_ws,wt_pct_2_20_mm_clay_free_ws,wt_pct_sand_clay_free_ws,wt_pct_silt_clay_free_ws,wt_pct_tot_clay_clay_free_ws,wt_pct_vcs_clay_free_lt2mmbase,wt_pct_cs_clay_free_lt2mmbase,wt_pct_ms_clay_free_lt2mmbase,wt_pct_fs_clay_free_lt2mmbase,wt_pct_vfs_clay_free_lt2mmbase,wt_pct_csi_clay_free_lt2mmbase,wt_pct_fsi_clay_free_lt2mmbase,wt_pct_clay_clay_free_2mmbase,wf_25,wf_520,wf_2075,wf_0175,percent_passing_3_inch_sieve,
--3
bulk_density_whole_soil_moist,weight_percent_gt_2_mm_ws,weight_percent_gt_250_mm_ws,weight_pct_75_to_250_mm_ws,weight_pct_2_to_75_mm_ws,weight_pct_20_to_75_mm_ws,weight_pct_5_to_20_mm_ws,
--4
cumulative_curve_lt_1_fourthmm,cumulative_curve_lt_1_tenth_mm,cumulative_curve_lt_5_hundredt,cumulative_curve_size_lt_60_pe,cumulative_curve_size_lt_50_pe,cumulative_curve_size_lt_10_pe,gradiation_uniformity,gradation_curvature,le_third_ovendry_whole_soi,le_third_bar_to_oven_dry_rewet,le_third_fifteen_whole_soil,void_ratio_third_bar_lt_2_mm,void_ratio_third_bar_whole_soi,water_retention_difference_ws,pores_drained_third_bar_ws,pores_filled_third_bar_ws,

--5
weight_pct_2_to_5_mm_ws,weight_pct_less_than_2_mm_ws,volume_pct_gt_2_mm_thirdbarws,volume_pct_gt_250_mm_thirdbarw,volume_pct_75_to_250_mm_third,volume_pct_2_to_75_mm_third_ws,volume_pct_20_to_75_mm_third_w,volume_pct_5_to_20_mm_third_ws,volume_pct_2_to_5_mm_third_ws,
--6
percent_passing_2_inch_sieve,percent_passing_1_and_1_half,percent_passing_1_inch_sieve,percent_passing_3_quarter_inch,percent_passing_3_eights_inch,percent_passing_no_4_sieve,percent_passing_no_10_sieve,percent_passing_no_40_sieve,percent_passing_no_200_sieve,percent_passing_20_micron_siev,percent_passing_5_micron_sieve,percent_passing_2_micron_sieve,cumulative_curve_less_than_1mm,cumulative_curve_lt_1_half_mm


CREATE INDEX  SDA_Calculations_Including_Estimates_And_Default_Values_idx1c ON  SDA_Calculations_Including_Estimates_And_Default_Values (labsampnum, result_source_key) INCLUDE (prep_code)
CREATE INDEX  SDA_Calculations_Including_Estimates_And_Default_Values_result_source_key_idx2 ON  SDA_Calculations_Including_Estimates_And_Default_Values (result_source_key )
CREATE INDEX SDA_Calculations_Including_Estimates_And_Default_Values_prep_code_idx5 ON  SDA_Calculations_Including_Estimates_And_Default_Values (prep_code)

GO
SET STATISTICS IO OFF
GO