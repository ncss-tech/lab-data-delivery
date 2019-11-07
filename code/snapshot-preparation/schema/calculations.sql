CREATE TABLE calculations 
( `labsampnum` TEXT,
	`result_source_key` REAL,
	`prep_code` TEXT,
	`bulk_density_3rd_bar_for_calc` REAL,
	`bulk_density_3rd_bar_source` TEXT,
	`particle_density_for_calc` REAL,
	`particle_density_calc_sour` TEXT,
	`bulk_density_third_bar_ws` REAL,
	`bulk_density_oven_dry_ws` REAL,
	`bulk_density_saturated_whole_so` REAL,
	`volume_pct_lt_2_mm_third_ws` REAL,
	`volume_pct_usda_sand_ws` REAL,
	`vol_pct_usda_silt_third_bar_ws` REAL,
	`volume_pct_usda_clay_ws` REAL,
	`pct_pores_drained_third_bar_ws` REAL,
	`pct_pores_filled_third_bar_ws` REAL,
	`wt_pct_gt_2_mm_clay_free_ws` REAL,
	`wt_pct_2_75_mm_clay_free_ws` REAL,
	`wt_pct_2_20_mm_clay_free_ws` REAL,
	`wt_pct_sand_clay_free_ws` REAL,
	`wt_pct_silt_clay_free_ws` REAL,
	`wt_pct_tot_clay_clay_free_ws` REAL,
	`wt_pct_vcs_clay_free_lt2mmbase` REAL,
	`wt_pct_cs_clay_free_lt2mmbase` REAL,
	`wt_pct_ms_clay_free_lt2mmbase` REAL,
	`wt_pct_fs_clay_free_lt2mmbase` REAL,
	`wt_pct_vfs_clay_free_lt2mmbase` REAL,
	`wt_pct_csi_clay_free_lt2mmbase` REAL,
	`wt_pct_fsi_clay_free_lt2mmbase` REAL,
	`wt_pct_clay_clay_free_2mmbase` REAL,
	`wf_25` REAL,
	`wf_520` REAL,
	`wf_2075` REAL,
	`wf_0175` REAL,
	`percent_passing_3_inch_sieve` INTEGER,
	`bulk_density_whole_soil_moist` REAL,
	`weight_percent_gt_2_mm_ws` REAL,
	`weight_percent_gt_250_mm_ws` REAL,
	`weight_pct_75_to_250_mm_ws` REAL,
	`weight_pct_2_to_75_mm_ws` REAL,
	`weight_pct_20_to_75_mm_ws` REAL,
	`weight_pct_5_to_20_mm_ws` REAL,
	`cumulative_curve_lt_1_fourthmm` REAL,
	`cumulative_curve_lt_1_tenth_mm` REAL,
	`cumulative_curve_lt_5_hundredt` REAL,
	`cumulative_curve_size_lt_60_pe` REAL,
	`cumulative_curve_size_lt_50_pe` REAL,
	`cumulative_curve_size_lt_10_pe` REAL,
	`gradiation_uniformity` REAL,
	`gradation_curvature` REAL,
	`le_third_ovendry_whole_soi` REAL,
	`le_third_bar_to_oven_dry_rewet` REAL,
	`le_third_fifteen_whole_soil` REAL,
	`void_ratio_third_bar_lt_2_mm` REAL,
	`void_ratio_third_bar_whole_soi` REAL,
	`water_retention_difference_ws` REAL,
	`pores_drained_third_bar_ws` REAL,
	`pores_filled_third_bar_ws` REAL,
	`weight_pct_2_to_5_mm_ws` REAL,
	`weight_pct_less_than_2_mm_ws` REAL,
	`volume_pct_gt_2_mm_thirdbarws` REAL,
	`volume_pct_gt_250_mm_thirdbarw` REAL,
	`volume_pct_75_to_250_mm_third` REAL,
	`volume_pct_2_to_75_mm_third_ws` REAL,
	`volume_pct_20_to_75_mm_third_w` REAL,
	`volume_pct_5_to_20_mm_third_ws` REAL,
	`volume_pct_2_to_5_mm_third_ws` REAL,
	`percent_passing_2_inch_sieve` REAL,
	`percent_passing_1_and_1_half` REAL,
	`percent_passing_1_inch_sieve` REAL,
	`percent_passing_3_quarter_inch` REAL,
	`percent_passing_3_eights_inch` REAL,
	`percent_passing_no_4_sieve` REAL,
	`percent_passing_no_10_sieve` REAL,
	`percent_passing_no_40_sieve` REAL,
	`percent_passing_no_200_sieve` REAL,
	`percent_passing_20_micron_siev` REAL,
	`percent_passing_5_micron_sieve` REAL,
	`percent_passing_2_micron_sieve` REAL,
	`cumulative_curve_less_than_1mm` REAL,
	`cumulative_curve_lt_1_half_mm` REAL 
)