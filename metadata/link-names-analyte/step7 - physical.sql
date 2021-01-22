----- time 1:30 
USE ncsslabdata;
GO


------ drop the temp table
DROP TABLE IF EXISTS #temp_results_step7;

---- create temp table
CREATE TABLE #temp_results_step7
    (
        [labsampnum]                        VARCHAR(10),
        [result_source_key]                 INT            NULL,
        [prep_code]                         VARCHAR(64)    NULL,
        [texture_lab]                       VARCHAR(128)   NULL,
        [particle_size_method]              VARCHAR(12)    NULL,
        [clay_total]                        DECIMAL(10, 3) NULL,
        [silt_total]                        DECIMAL(15, 3) NULL,
        [sand_total]                        DECIMAL(15, 3) NULL,
        [clay_fine]                         DECIMAL(10, 3) NULL,
        [clay_caco3]                        DECIMAL(10, 3) NULL,
        [silt_fine]                         DECIMAL(10, 3) NULL,
        [silt_coarse]                       DECIMAL(15, 3) NULL,
        [sand_very_fine]                    DECIMAL(10, 3) NULL,
        [sand_fine]                         DECIMAL(10, 3) NULL,
        [sand_medium]                       DECIMAL(10, 3) NULL,
        [sand_coarse]                       DECIMAL(10, 3) NULL,
        [sand_very_coarse]                  DECIMAL(10, 3) NULL,
        [frag_2_5_mm_wt_pct_lt_75]          DECIMAL(10, 3) NULL,
        [frag__2_20_mm_wt_pct_lt_75]        DECIMAL(10, 3) NULL,
        [frag_5_20_mm_wt_pct_lt_75]         DECIMAL(10, 3) NULL,
        [frag_20_75_mm_wt_pct_lt_75]        DECIMAL(10, 3) NULL,
        [total_frag_wt_pct_gt_2_mm_ws]      DECIMAL(10, 3) NULL,
        [wt_pct_1_tenth_to_75_mm]           DECIMAL(10, 3) NULL,
        [bulk_density_tenth_bar]            DECIMAL(10, 2) NULL,
        [bulk_density_tenth_bar_method]     VARCHAR(12)    NULL,
        [bulk_density_third_bar]            DECIMAL(10, 2) NULL,
        [bulk_density_third_bar_method]     VARCHAR(12)    NULL,
        [bulk_density_oven_dry]             DECIMAL(10, 2) NULL,
        [bulk_density_oven_dry_method]      VARCHAR(12)    NULL,
        [bulk_density_lt_2_mm_air_dry]      DECIMAL(10, 2) NULL,
        [bulk_density_air_dry_method]       VARCHAR(12)    NULL,
        [bd_third_bar_lt2_reconstituted]    DECIMAL(10, 2) NULL,
        [bd_thirdbar_reconstituted_method]  VARCHAR(12)    NULL,
        [bulk_den_ovendry_reconstituted]    DECIMAL(10, 2) NULL,
        [bulk_de_odreconstituted_method]    VARCHAR(12)    NULL,
        [bulk_density_field_moist]          DECIMAL(11, 3) NULL,
        [bulk_density_field_moist_metho]    VARCHAR(12)    NULL,
        [particle_density_less_than_2mm]    DECIMAL(11, 3) NULL,
        [particle_density_lt_2mm_method]    VARCHAR(12)    NULL,
        [particle_density_gt_2_mm]          DECIMAL(11, 3) NULL,
        [particle_density_gt_2mm_method]    VARCHAR(12)    NULL,
        [cole_whole_soil]                   DECIMAL(11, 3) NULL,
        [cole_whole_soil_method]            VARCHAR(12)    NULL,
        [le_third_fifteen_lt2_mm]           DECIMAL(10, 3) NULL,
        [le_third_fifteen_lt2_metho]        VARCHAR(12)    NULL,
        [le_third_ovendry_lt_2_mm]          DECIMAL(10, 3) NULL,
        [le_third_ovendry_lt_2_mm_metho]    VARCHAR(12)    NULL,
        [le_field_moist_to_oben_dry]        DECIMAL(10, 3) NULL,
        [le_fm_to_od_method]                VARCHAR(12)    NULL,
        [water_retention_0_bar_sieve]       DECIMAL(10, 3) NULL,
        [water_retention_0_bar_method]      VARCHAR(12)    NULL,
        [water_retention_6_hundredths]      DECIMAL(10, 3) NULL,
        [water_retention_6_hund_method]     VARCHAR(12)    NULL,
        [water_retention_10th_bar]          DECIMAL(10, 3) NULL,
        [water_retention_10th_bar_meth]     VARCHAR(12)    NULL,
        [water_retention_third_bar]         DECIMAL(10, 3) NULL,
        [water_retention_thirdbar_metho]    VARCHAR(12)    NULL,
        [water_retention_1_bar]             DECIMAL(10, 3) NULL,
        [water_retention_1_bar_method]      VARCHAR(12)    NULL,
        [water_retention_2_bar]             DECIMAL(10, 3) NULL,
        [water_retention_2_bar_method]      VARCHAR(12)    NULL,
        [water_retention_3_bar_sieve]       DECIMAL(10, 3) NULL,
        [water_retention_3_bar_method]      VARCHAR(12)    NULL,
        [water_retention_5_bar_sieve]       DECIMAL(10, 3) NULL,
        [water_retention_5_bar_method]      VARCHAR(12)    NULL,
        [water_retention_15_bar]            DECIMAL(10, 3) NULL,
        [water_retention_15_bar_method]     VARCHAR(12)    NULL,
        [water_retention_field_state]       DECIMAL(10, 3) NULL,
        [water_retention_field_state_me]    VARCHAR(12)    NULL,
        [airdry_ovendry_ratio]              DECIMAL(10, 3) NULL,
        [atterberg_liquid_limit]            VARCHAR(128)   NULL,
        [atterberg_liquid_limit_method]     VARCHAR(12)    NULL,
        [atterberg_plasticity_index]        VARCHAR(128)   NULL,
        [plastic_limit]                     VARCHAR(128)   NULL,
        [plastic_limit_method]              VARCHAR(12)    NULL,
        [aggregate_stability_05_2_mm]       DECIMAL(15, 3) NULL,
        [aggregate_stability_05_2_metho]    VARCHAR(12)    NULL,
        [le_to_clay_third_bar_to_ovendr]    DECIMAL(15, 3) NULL,
        [water_15_bar_to_clay_ratio]        DECIMAL(15, 3) NULL,
        [cec7_clay_ratio]                   DECIMAL(15, 3) NULL,
        [effective_cec_to_clay_ratio]       DECIMAL(15, 3) NULL,
        [psda_ethanol_dispersion_method]    VARCHAR(12)    NULL,
        [sand_total_ethanol_dispersible]    DECIMAL(15, 3) NULL,
        [silt_total_ethanol_dispersible]    DECIMAL(15, 3) NULL,
        [clay_total_ethanol_dispersible]    DECIMAL(10, 3) NULL,
        [sand_very_fine_ethanol_dispers]    DECIMAL(10, 3) NULL,
        [sand_fine_ethanol_dispersible]     DECIMAL(10, 3) NULL,
        [sand_medium_ethanol_dispersibl]    DECIMAL(10, 3) NULL,
        [sand_coarse_ethanol_dispersibl]    DECIMAL(10, 3) NULL,
        [sand_very_coarse_ethanol_disp]     DECIMAL(10, 3) NULL,
        [water_dispersible_fraction_method] VARCHAR(12)    NULL,
        [clay_tot_h2o_dispersible]          DECIMAL(10, 3) NULL,
        [clay_fine_h2o_dispersible]         DECIMAL(10, 3) NULL,
        [clay_co3_h2o_dispersible]          DECIMAL(10, 3) NULL,
        [silt_total_h2o_dispersible]        DECIMAL(15, 3) NULL,
        [silt_fine_h2o_dispersible]         DECIMAL(10, 3) NULL,
        [silt_coarse_h2o_dispersible]       DECIMAL(15, 3) NULL,
        [sand_total_h2o_dispersible]        DECIMAL(15, 3) NULL,
        [sand_vf_h2o_dispersible]           DECIMAL(10, 3) NULL,
        [sand_fine_h2o_dispersible]         DECIMAL(10, 3) NULL,
        [sand_medium_h2o_dispersible]       DECIMAL(10, 3) NULL,
        [sand_coarse_h2o_dispersible]       DECIMAL(10, 3) NULL,
        [sand_vc_h2o_dispersible]           DECIMAL(10, 3) NULL,
        [color_pyrophosphate_extract]       VARCHAR(128)   NULL,
        [color_pyrophosphate_method]        VARCHAR(12)    NULL,
        [bd_thirdbar_before_rewet_organ]    DECIMAL(10, 3) NULL,
        [bd_before_rewet_organic_method]    VARCHAR(12)    NULL,
        [bd_thirdbar_rewet_organic_soil]    DECIMAL(10, 3) NULL,
        [bd_third_rewet_organic_method]     VARCHAR(12)    NULL,
        [bulk_den_rewet_oven_dry]           DECIMAL(11, 3) NULL,
        [bulk_den_rewet_oven_dry_method]    VARCHAR(12)    NULL,
        [mineral_content_loss_on_igniti]    DECIMAL(10, 3) NULL,
        [mineral_content_loi_method]        VARCHAR(12)    NULL,
        [estimated_organic_matter]          DECIMAL(15, 3) NULL,
        [estimated_om_plus_mineral]         DECIMAL(15, 3) NULL,
        [fiber_analysis_method]             VARCHAR(12)    NULL,
        [fiber_unrubbed]                    DECIMAL(10, 3) NULL,
        [fiber_rubbed]                      DECIMAL(10, 3) NULL,
        [decomposition_state]               VARCHAR(128)   NULL,
        [limnic_material_type]              VARCHAR(128)   NULL
    );


-------- truncate existing data
TRUNCATE TABLE dbo.result_light;


------------ insert data into result_light table
INSERT INTO result_light
            SELECT 
                result_key,
                result_source_key,
                r.prep_key,
                result_type,
                result_reliability,
                r.analyte_key,
                r.procedure_key,
                r.source_system_key,
                result_value,
                p.prep_code,
                ISNULL(b.proced_code, '') AS procedure_code
            --FROM            dbo.layer AS l INNER JOIN
            --                         dbo.result AS r INNER JOIN
            --                         dbo.analyte AS a ON r.analyte_key = a.analyte_key INNER JOIN
            --                         dbo.preparation  AS p ON r.prep_key = p.prep_key ON l.layer_key = r.result_source_key LEFT OUTER JOIN
            --                         dbo.bridge_proced_ss AS b ON r.procedure_key = b.procedure_key AND 
            --                         r.source_system_key = b.source_system_key
            FROM
                dbo.layer AS l
                INNER JOIN
                    dbo.result AS r
                        ON l.layer_key = r.result_source_key
                INNER JOIN
                    dbo.analyte AS a
                        ON r.analyte_key = a.analyte_key
                LEFT OUTER JOIN
                    dbo.preparation AS p
                        ON r.prep_key = p.prep_key
                           AND CASE
                                   WHEN r.result_reliability IS NULL
                                       THEN 1
                                   WHEN r.result_reliability = '0'
                                       THEN 1
                                   ELSE
                                       2
                               END = 1
                LEFT OUTER JOIN
                    dbo.bridge_proced_ss AS b
                        ON r.procedure_key = b.procedure_key
                           AND r.source_system_key = b.source_system_key
            WHERE
                (r.analyte_key IN (
                                      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23,
                                      24, 25, 30, 76, 239, 240, 240, 241, 241, 242, 243, 282, 282, 283, 284, 286, 286,
                                      287, 287, 288, 288, 289, 289, 290, 290, 291, 291, 313, 313, 314, 315, 317, 317,
                                      318, 318, 319, 319, 320, 320, 321, 321, 322, 322, 330, 331, 332, 333, 333, 334,
                                      334, 335, 335, 336, 336, 337, 337, 338, 339, 339, 341, 341, 342, 390, 391, 392,
                                      393, 394, 395, 396, 458, 459, 536, 540, 541, 546, 557, 558, 560, 562, 564, 565,
                                      565, 566, 566, 567, 569, 600, 606, 622, 625, 628, 630, 631, 637, 637, 638, 639,
                                      639, 640, 640, 641, 641, 642, 643, 649, 656, 657, 671, 672, 672, 673, 674, 685,
                                      686, 686, 687, 739, 741, 743, 745, 746, 747, 775, 776, 777, 777, 778, 778, 785,
                                      786, 797, 1018, 1022, 1022, 1023, 1023, 1024, 1024, 1025, 1025, 1026, 1026, 1027,
                                      1027, 1028, 1028, 1029, 1029, 1039, 1040, 1041, 1047, 1049, 1053, 1054, 1054,
                                      1055, 1055, 1056, 1057, 1058, 1058, 1059, 1059, 1060, 1060, 1061, 1061, 1062,
                                      1062, 1063, 1063, 1064, 1064, 1065, 1065, 1066, 1066, 1067, 1067, 1068, 1069,
                                      1188, 1189, 1190, 1190, 1191, 1191, 1192, 1192, 1193, 1193, 1194, 1194, 1195,
                                      1195, 1196, 1196, 1197, 1198, 1198, 1241, 1526, 1526, 1527, 1527, 1528, 1528,
                                      1529, 1529, 1530, 1530, 1531, 1531, 1532, 1532, 1533, 1533, 1534, 1534, 1535,
                                      1536, 1537, 1537, 1538, 1538, 1539, 1539, 1540, 1540, 1541, 1541, 1542, 1542,
                                      1544, 1544, 1546, 1547, 1566, 1567, 1568, 1568, 1569, 1569, 1570, 1570, 1571,
                                      1571, 1572, 1572, 1573, 1573, 1574, 1574, 1575, 1575, 1576, 1576, 1763, 1764,
                                      1765, 1766, 1767, 1768, 1769, 1770, 1772, 1904, 1904, 1905, 1905, 1906, 1906,
                                      1924, 2141, 2173
                                  )
                )
                AND (
                        r.result_reliability IS NULL
                        OR r.result_reliability = '0'
                    );



------- add data to temp table
INSERT INTO #temp_results_step7
    (
        labsampnum,
        result_source_key,
        prep_code,
        texture_lab,
        particle_size_method,
        clay_total,
        silt_total,
        sand_total,
        clay_fine,
        clay_caco3,
        silt_fine,
        silt_coarse,
        sand_very_fine,
        sand_fine,
        sand_medium,
        sand_coarse,
        sand_very_coarse,
        frag_2_5_mm_wt_pct_lt_75,
        frag__2_20_mm_wt_pct_lt_75,
        frag_5_20_mm_wt_pct_lt_75,
        frag_20_75_mm_wt_pct_lt_75,
        total_frag_wt_pct_gt_2_mm_ws,
        wt_pct_1_tenth_to_75_mm,
        bulk_density_tenth_bar,
        bulk_density_tenth_bar_method,
        bulk_density_third_bar,
        bulk_density_third_bar_method,
        bulk_density_oven_dry,
        bulk_density_oven_dry_method,
        bulk_density_lt_2_mm_air_dry,
        bulk_density_air_dry_method,
        bd_third_bar_lt2_reconstituted,
        bd_thirdbar_reconstituted_method,
        bulk_den_ovendry_reconstituted,
        bulk_de_odreconstituted_method,
        bulk_density_field_moist,
        bulk_density_field_moist_metho,
        particle_density_less_than_2mm,
        particle_density_lt_2mm_method,
        particle_density_gt_2_mm,
        particle_density_gt_2mm_method,
        cole_whole_soil,
        cole_whole_soil_method,
        le_third_fifteen_lt2_mm,
        le_third_fifteen_lt2_metho,
        le_third_ovendry_lt_2_mm,
        le_third_ovendry_lt_2_mm_metho,
        le_field_moist_to_oben_dry,
        le_fm_to_od_method,
        water_retention_0_bar_sieve,
        water_retention_0_bar_method,
        water_retention_6_hundredths,
        water_retention_6_hund_method,
        water_retention_10th_bar,
        water_retention_10th_bar_meth,
        water_retention_third_bar,
        water_retention_thirdbar_metho,
        water_retention_1_bar,
        water_retention_1_bar_method,
        water_retention_2_bar,
        water_retention_2_bar_method,
        water_retention_3_bar_sieve,
        water_retention_3_bar_method,
        water_retention_5_bar_sieve,
        water_retention_5_bar_method,
        water_retention_15_bar,
        water_retention_15_bar_method,
        water_retention_field_state,
        water_retention_field_state_me,
        airdry_ovendry_ratio,
        atterberg_liquid_limit,
        atterberg_liquid_limit_method,
        atterberg_plasticity_index,
        plastic_limit,
        plastic_limit_method,
        aggregate_stability_05_2_mm,
        aggregate_stability_05_2_metho,
        le_to_clay_third_bar_to_ovendr,
        water_15_bar_to_clay_ratio,
        cec7_clay_ratio,
        effective_cec_to_clay_ratio,
        psda_ethanol_dispersion_method,
        sand_total_ethanol_dispersible,
        silt_total_ethanol_dispersible,
        clay_total_ethanol_dispersible,
        sand_very_fine_ethanol_dispers,
        sand_fine_ethanol_dispersible,
        sand_medium_ethanol_dispersibl,
        sand_coarse_ethanol_dispersibl,
        sand_very_coarse_ethanol_disp,
        water_dispersible_fraction_method,
        clay_tot_h2o_dispersible,
        clay_fine_h2o_dispersible,
        clay_co3_h2o_dispersible,
        silt_total_h2o_dispersible,
        silt_fine_h2o_dispersible,
        silt_coarse_h2o_dispersible,
        sand_total_h2o_dispersible,
        sand_vf_h2o_dispersible,
        sand_fine_h2o_dispersible,
        sand_medium_h2o_dispersible,
        sand_coarse_h2o_dispersible,
        sand_vc_h2o_dispersible,
        color_pyrophosphate_extract,
        color_pyrophosphate_method,
        bd_thirdbar_before_rewet_organ,
        bd_before_rewet_organic_method,
        bd_thirdbar_rewet_organic_soil,
        bd_third_rewet_organic_method,
        bulk_den_rewet_oven_dry,
        bulk_den_rewet_oven_dry_method,
        mineral_content_loss_on_igniti,
        mineral_content_loi_method,
        estimated_organic_matter,
        estimated_om_plus_mineral,
        fiber_analysis_method,
        fiber_unrubbed,
        fiber_rubbed,
        decomposition_state,
        limnic_material_type
    )
            SELECT
                natural_key      AS labsampnum,
                result_source_key,
                (
                    SELECT TOP (1)
                        prep_code
                    FROM
                        result_light AS result
                    WHERE
                        (
                            prep_code IS NOT NULL
                            AND (result.result_source_key = q1.result_source_key)
                        )
                    ORDER BY
                        CASE
                            WHEN prep_code = 's'
                                THEN 1
                            ELSE
                                2
                        END ASC
                )                AS prep_code,
                (
                    SELECT TOP (1)
                        result_value
                    FROM
                        (
                            SELECT
                                result_value,
                                'S' AS prep_code
                            FROM
                                result_light
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key IN (
                                                        1566, 1547, 1536, 569
                                                    )
                                    )
                            UNION
                            SELECT
                                result_value,
                                'N' AS prep_code
                            FROM
                                result_light AS result_60
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 674)
                            UNION
                            SELECT
                                result_value,
                                'GP' AS prep_code
                            FROM
                                result_light AS result_59
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 1068)
                            UNION
                            SELECT
                                result_value,
                                'S_SK' AS prep_code
                            FROM
                                result_light AS result_58
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key IN (
                                                        1069, 643
                                                    )
                                    )
                        ) AS result_1_9
                -- WHERE        (prep_code = q1.prep_code)
                )                AS texture_lab,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code)
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         282, 286, 287, 288, 289, 290, 291, 313, 317, 318, 319, 320,
                                                         321, 322, 565, 566, 567, 640, 641, 642, 671, 672, 673, 685,
                                                         686, 687, 1053, 1054, 1055, 1056, 1057, 1058, 1526, 1527,
                                                         1528, 1529, 1530, 1531, 1532, 1533, 1534, 1535, 1537, 1538,
                                                         1539, 1540, 1541, 1542, 1544, 1546, 1567, 1568, 1569, 1570,
                                                         1571, 1572, 1573, 1574, 1575, 1576
                                                     )
                            )
                )                AS particle_size_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_57.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_57
                        INNER JOIN
                            dbo.preparation
                                ON result_57.prep_key = dbo.preparation.prep_key
                    WHERE
                        (result_57.result_type = 'layer analyte')
                        AND (result_57.result_value <> '')
                        AND (result_57.result_source_key = q1.result_source_key) --AND 
                        -- (dbo.preparation.prep_code = q1.prep_code)
                        AND (
                                result_57.result_reliability IS NULL
                                OR result_57.result_reliability = '0'
                            )
                        AND (result_57.analyte_key IN (
                                                          282, 313, 1576, 1537, 1526
                                                      )
                            )
                )                AS clay_total,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '4.1') AS DECIMAL(15, 3)) AS Expr1
                    FROM
                        (
                            SELECT
                                result_value,
                                'S' AS prep_code
                            FROM
                                result_light AS result_56
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key IN (
                                                        1567, 1546, 1535, 567
                                                    )
                                    )
                            UNION
                            SELECT
                                result_value,
                                'M' AS prep_code
                            FROM
                                result_light AS result_55
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 687)
                            UNION
                            SELECT
                                result_value,
                                'N' AS prep_code
                            FROM
                                result_light AS result_54
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 673)
                            UNION
                            SELECT
                                result_value,
                                'GP' AS prep_code
                            FROM
                                result_light AS result_53
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 1056)
                            UNION
                            SELECT
                                result_value,
                                'S_SK' AS prep_code
                            FROM
                                result_light AS result_52
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key IN (
                                                        1053, 642
                                                    )
                                    )
                        ) AS result_1_8
                -- WHERE        (prep_code = q1.prep_code)
                )                AS silt_total,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '4.1') AS DECIMAL(15, 3)) AS Expr1
                    FROM
                        (
                            SELECT
                                result_value,
                                'S' AS prep_code
                            FROM
                                result_light AS result_51
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key IN (
                                                        1569, 1544, 1533, 565
                                                    )
                                    )
                            UNION
                            SELECT
                                result_value,
                                'M' AS prep_code
                            FROM
                                result_light AS result_50
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 685)
                            UNION
                            SELECT
                                result_value,
                                'N' AS prep_code
                            FROM
                                result_light AS result_49
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 671)
                            UNION
                            SELECT
                                result_value,
                                'GP' AS prep_code
                            FROM
                                result_light AS result_47
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 1057)
                            UNION
                            SELECT
                                result_value,
                                'S_SK' AS prep_code
                            FROM
                                result_light AS result_46
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key IN (
                                                        1054, 640
                                                    )
                                    )
                        ) AS result_1_7
                --WHERE        (prep_code = q1.prep_code)
                )                AS sand_total,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_14.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_14
                        INNER JOIN
                            dbo.preparation AS preparation_8
                                ON result_14.prep_key = preparation_8.prep_key
                    WHERE
                        (result_14.result_type = 'layer analyte')
                        AND (result_14.result_value <> '')
                        AND (result_14.result_source_key = q1.result_source_key) --AND 
                        -- (preparation_8.prep_code = q1.prep_code) 
                        AND (
                                result_14.result_reliability IS NULL
                                OR result_14.result_reliability = '0'
                            )
                        AND (result_14.analyte_key IN (
                                                          284, 315
                                                      )
                            )
                )                AS clay_fine,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_13.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_13
                        INNER JOIN
                            dbo.preparation AS preparation_7
                                ON result_13.prep_key = preparation_7.prep_key
                    WHERE
                        (result_13.result_type = 'layer analyte')
                        AND (result_13.result_value <> '')
                        AND (result_13.result_source_key = q1.result_source_key) --AND 
                        -- (preparation_7.prep_code = q1.prep_code) 
                        AND (
                                result_13.result_reliability IS NULL
                                OR result_13.result_reliability = '0'
                            )
                        AND (result_13.analyte_key IN (
                                                          283, 314
                                                      )
                            )
                )                AS clay_caco3,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_12.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_12
                        INNER JOIN
                            dbo.preparation AS preparation_6
                                ON result_12.prep_key = preparation_6.prep_key
                    WHERE
                        (result_12.result_type = 'layer analyte')
                        AND (result_12.result_value <> '')
                        AND (result_12.result_source_key = q1.result_source_key) --AND 
                        --  (preparation_6.prep_code = q1.prep_code) 
                        AND (
                                result_12.result_reliability IS NULL
                                OR result_12.result_reliability = '0'
                            )
                        AND (result_12.analyte_key IN (
                                                          291, 322, 1532, 1570
                                                      )
                            )
                )                AS silt_fine,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '4.1') AS DECIMAL(15, 3)) AS Expr1
                    FROM
                        (
                            SELECT
                                result_value,
                                'S' AS prep_code
                            FROM
                                result_light AS result_45
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key IN (
                                                        1568, 1534, 566
                                                    )
                                    )
                            UNION
                            SELECT
                                result_value,
                                'M' AS prep_code
                            FROM
                                result_light AS result_44
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 686)
                            UNION
                            SELECT
                                result_value,
                                'N' AS prep_code
                            FROM
                                result_light AS result_43
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 672)
                            UNION
                            SELECT
                                result_value,
                                'GP' AS prep_code
                            FROM
                                result_light AS result_42
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 1058)
                            UNION
                            SELECT
                                result_value,
                                'S_SK' AS prep_code
                            FROM
                                result_light AS result_41
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key IN (
                                                        1055, 641
                                                    )
                                    )
                        ) AS result_1_6
                --WHERE        (prep_code = q1.prep_code)
                )                AS silt_coarse,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_10.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_10
                        INNER JOIN
                            dbo.preparation AS preparation_5
                                ON result_10.prep_key = preparation_5.prep_key
                    WHERE
                        (result_10.result_type = 'layer analyte')
                        AND (result_10.result_value <> '')
                        AND (result_10.result_source_key = q1.result_source_key) -- AND 
                        --  (preparation_5.prep_code = q1.prep_code) 
                        AND (
                                result_10.result_reliability IS NULL
                                OR result_10.result_reliability = '0'
                            )
                        AND (result_10.analyte_key IN (
                                                          290, 321, 1531, 1542, 1571
                                                      )
                            )
                )                AS sand_very_fine,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_9.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_9
                        INNER JOIN
                            dbo.preparation AS preparation_4
                                ON result_9.prep_key = preparation_4.prep_key
                    WHERE
                        (result_9.result_type = 'layer analyte')
                        AND (result_9.result_value <> '')
                        AND (result_9.result_source_key = q1.result_source_key) -- AND 
                        --  (preparation_4.prep_code = q1.prep_code) 
                        AND (
                                result_9.result_reliability IS NULL
                                OR result_9.result_reliability = '0'
                            )
                        AND (result_9.analyte_key IN (
                                                         287, 318, 1528, 1539, 1574
                                                     )
                            )
                )                AS sand_fine,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_8.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_8
                        INNER JOIN
                            dbo.preparation AS preparation_3
                                ON result_8.prep_key = preparation_3.prep_key
                    WHERE
                        (result_8.result_type = 'layer analyte')
                        AND (result_8.result_value <> '')
                        AND (result_8.result_source_key = q1.result_source_key) --AND 
                        -- (preparation_3.prep_code = q1.prep_code) 
                        AND (
                                result_8.result_reliability IS NULL
                                OR result_8.result_reliability = '0'
                            )
                        AND (result_8.analyte_key IN (
                                                         288, 319, 1529, 1540, 1573
                                                     )
                            )
                )                AS sand_medium,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_7.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_7
                        INNER JOIN
                            dbo.preparation AS preparation_2
                                ON result_7.prep_key = preparation_2.prep_key
                    WHERE
                        (result_7.result_type = 'layer analyte')
                        AND (result_7.result_value <> '')
                        AND (result_7.result_source_key = q1.result_source_key) --AND 
                        --  (preparation_2.prep_code = q1.prep_code) 

                        AND (
                                result_7.result_reliability IS NULL
                                OR result_7.result_reliability = '0'
                            )
                        AND (result_7.analyte_key IN (
                                                         286, 317, 1527, 1538, 1575
                                                     )
                            )
                )                AS sand_coarse,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_6.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_6
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_6.prep_key = preparation_1.prep_key
                    WHERE
                        (result_6.result_type = 'layer analyte')
                        AND (result_6.result_value <> '')
                        AND (result_6.result_source_key = q1.result_source_key) --AND 
                        --  (preparation_1.prep_code = q1.prep_code) 

                        AND (
                                result_6.result_reliability IS NULL
                                OR result_6.result_reliability = '0'
                            )
                        AND (result_6.analyte_key IN (
                                                         289, 320, 1530, 1541, 1572
                                                     )
                            )
                )                AS sand_very_coarse,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_5
                    WHERE
                        (result_type = 'layer result')
                        AND (result_value <> '')
                        AND (ISNUMERIC(result_value) = 1)
                        AND (result_source_key = q1.result_source_key)
                        AND (analyte_key IN (
                                                628
                                            )
                            )
                )                AS frag_2_5_mm_wt_pct_lt_75,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_4
                    WHERE
                        (result_type = 'layer result')
                        AND (result_value <> '')
                        AND (ISNUMERIC(result_value) = 1)
                        AND (result_source_key = q1.result_source_key)
                        AND (analyte_key IN (
                                                1039
                                            )
                            )
                )                AS frag__2_20_mm_wt_pct_lt_75,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_4
                    WHERE
                        (result_type = 'layer result')
                        AND (result_value <> '')
                        AND (ISNUMERIC(result_value) = 1)
                        AND (result_source_key = q1.result_source_key)
                        AND (analyte_key IN (
                                                631
                                            )
                            )
                )                AS frag_5_20_mm_wt_pct_lt_75,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_3
                    WHERE
                        (result_type = 'layer result')
                        AND (result_value <> '')
                        AND (ISNUMERIC(result_value) = 1)
                        AND (result_source_key = q1.result_source_key)
                        AND (analyte_key IN (
                                                630
                                            )
                            )
                )                AS frag_20_75_mm_wt_pct_lt_75,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_1
                    WHERE
                        (result_type = 'layer result')
                        AND (result_value <> '')
                        AND (ISNUMERIC(result_value) = 1)
                        AND (result_source_key = q1.result_source_key)
                        AND (analyte_key IN (
                                                600
                                            )
                            )
                )                AS total_frag_wt_pct_gt_2_mm_ws,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '3.0') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_2
                    WHERE
                        (result_type = 'layer result')
                        AND (result_value <> '')
                        AND (ISNUMERIC(result_value) = 1)
                        AND (result_source_key = q1.result_source_key)
                        AND (analyte_key IN (
                                                606
                                            )
                            )
                )                AS wt_pct_1_tenth_to_75_mm,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_12.result_value, '4.2') AS DECIMAL(10, 2)) AS Expr1
                    FROM
                        result_light AS result_12
                        INNER JOIN
                            dbo.preparation AS preparation_8
                                ON result_12.prep_key = preparation_8.prep_key
                    WHERE
                        (result_12.result_type = 'layer analyte')
                        AND (result_12.result_source_key = q1.result_source_key)
                       -- AND ('S' = q1.prep_code) --dashed out prepcode JLN 07/08/2020
                        AND (
                                result_12.result_reliability IS NULL
                                OR result_12.result_reliability = '0'
                            )
                        AND (result_12.analyte_key = 10)
                )                AS bulk_density_tenth_bar,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         10
                                                     )
                            )
                )                AS bulk_density_tenth_bar_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_12.result_value, '4.2') AS DECIMAL(10, 2)) AS Expr1
                    FROM
                        result_light AS result_12
                        INNER JOIN
                            dbo.preparation AS preparation_8
                                ON result_12.prep_key = preparation_8.prep_key
                    WHERE
                        (result_12.result_type = 'layer analyte')
                        AND (result_12.result_source_key = q1.result_source_key) --AND ('S' = q1.prep_code) 
                        AND (
                                result_12.result_reliability IS NULL
                                OR result_12.result_reliability = '0'
                            )
                        AND (result_12.analyte_key = 4)
                )                AS bulk_density_third_bar,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code)
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         4
                                                     )
                            )
                )                AS bulk_density_third_bar_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_12.result_value, '4.2') AS DECIMAL(10, 2)) AS Expr1
                    FROM
                        result_light AS result_12
                        INNER JOIN
                            dbo.preparation AS preparation_8
                                ON result_12.prep_key = preparation_8.prep_key
                    WHERE
                        (result_12.result_type = 'layer analyte')
                        AND (result_12.result_source_key = q1.result_source_key) --AND ('S' = q1.prep_code) 
                        AND (
                                result_12.result_reliability IS NULL
                                OR result_12.result_reliability = '0'
                            )
                        AND (result_12.analyte_key = 5)
                )                AS bulk_density_oven_dry,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) -- AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         5
                                                     )
                            )
                )                AS bulk_density_oven_dry_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_12.result_value, '4.2') AS DECIMAL(10, 2)) AS Expr1
                    FROM
                        result_light AS result_12
                        INNER JOIN
                            dbo.preparation AS preparation_8
                                ON result_12.prep_key = preparation_8.prep_key
                    WHERE
                        (result_12.result_type = 'layer analyte')
                        AND (result_12.result_source_key = q1.result_source_key) --AND ('S' = q1.prep_code) 
                        AND (
                                result_12.result_reliability IS NULL
                                OR result_12.result_reliability = '0'
                            )
                        AND (result_12.analyte_key = 786)
                )                AS bulk_density_lt_2_mm_air_dry,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) -- AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         786
                                                     )
                            )
                )                AS bulk_density_air_dry_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_12.result_value, '4.2') AS DECIMAL(10, 2)) AS Expr1
                    FROM
                        result_light AS result_12
                        INNER JOIN
                            dbo.preparation AS preparation_8
                                ON result_12.prep_key = preparation_8.prep_key
                    WHERE
                        (result_12.result_type = 'layer analyte')
                        AND (result_12.result_source_key = q1.result_source_key)
                       -- AND ('S' = q1.prep_code) --dashed out prepcode JLN 07/08/2020
                        AND (
                                result_12.result_reliability IS NULL
                                OR result_12.result_reliability = '0'
                            )
                        AND (result_12.analyte_key = 16)
                )                AS bd_third_bar_lt2_reconstituted,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         16
                                                     )
                            )
                )                AS bd_thirdbar_reconstituted_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_12.result_value, '4.2') AS DECIMAL(10, 2)) AS Expr1
                    FROM
                        result_light AS result_12
                        INNER JOIN
                            dbo.preparation AS preparation_8
                                ON result_12.prep_key = preparation_8.prep_key
                    WHERE
                        (result_12.result_type = 'layer analyte')
                        AND (result_12.result_source_key = q1.result_source_key)
                       -- AND ('S' = q1.prep_code) --dashed out prepcode JLN 07/08/2020
                        AND (
                                result_12.result_reliability IS NULL
                                OR result_12.result_reliability = '0'
                            )
                        AND (result_12.analyte_key = 17)
                )                AS bulk_den_ovendry_reconstituted,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         17
                                                     )
                            )
                )                AS bulk_de_odreconstituted_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '4.3') AS DECIMAL(11, 3)) AS Expr1
                    FROM
                        result_light AS result_11
                    WHERE
                        (result_type = 'layer analyte')
                        AND (result_value <> '')
                        AND (result_source_key = q1.result_source_key)
                        AND (analyte_key IN (
                                                19, 21, 22, 1772
                                            )
                            )
                )                AS bulk_density_field_moist,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         19, 21, 22, 1772
                                                     )
                            )
                )                AS bulk_density_field_moist_metho,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '4.3') AS DECIMAL(11, 3)) AS Expr1
                    FROM
                        result_light AS result_11
                    WHERE
                        (result_type = 'layer analyte')
                        AND (result_value <> '')
                        AND (result_source_key = q1.result_source_key)
                        AND (analyte_key = 242)
                )                AS particle_density_less_than_2mm,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         242
                                                     )
                            )
                )                AS particle_density_lt_2mm_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '4.3') AS DECIMAL(11, 3)) AS Expr1
                    FROM
                        result_light AS result_11
                    WHERE
                        (result_type = 'layer analyte')
                        AND (result_value <> '')
                        AND (result_source_key = q1.result_source_key)
                        AND (analyte_key = 243)
                )                AS particle_density_gt_2_mm,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         243
                                                     )
                            )
                )                AS particle_density_gt_2mm_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '4.3') AS DECIMAL(11, 3)) AS Expr1
                    FROM
                        result_light AS result_11
                    WHERE
                        (result_type = 'layer result')
                        AND (result_value <> '')
                        AND (result_source_key = q1.result_source_key)
                        AND (analyte_key = 625)
                )                AS cole_whole_soil,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        LEFT OUTER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer result')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key)
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         625
                                                     )
                            )
                )                AS cole_whole_soil_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_40 --INNER JOIN
                    ---  dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                    WHERE
                        (result_40.result_type = 'layer result')
                        AND (result_40.result_source_key = q1.result_source_key) --AND (preparation_17.prep_code = q1.prep_code) 
                        AND (result_40.analyte_key IN (
                                                          540
                                                      )
                            )
                )                AS le_third_fifteen_lt2_mm,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        LEFT OUTER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer result')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         540
                                                     )
                            )
                )                AS le_third_fifteen_lt2_metho,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_40
                        LEFT OUTER JOIN
                            dbo.preparation AS preparation_17
                                ON result_40.prep_key = preparation_17.prep_key
                    WHERE
                        (result_40.result_type = 'layer result')
                        AND (result_40.result_source_key = q1.result_source_key) --AND (preparation_17.prep_code = q1.prep_code) 
                        AND (result_40.analyte_key IN (
                                                          536
                                                      )
                            )
                )                AS le_third_ovendry_lt_2_mm,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        LEFT OUTER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer result')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         536
                                                     )
                            )
                )                AS le_third_ovendry_lt_2_mm_metho,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_40
                        LEFT OUTER JOIN
                            dbo.preparation AS preparation_17
                                ON result_40.prep_key = preparation_17.prep_key
                    WHERE
                        (result_40.result_type = 'layer result')
                        AND (result_40.result_source_key = q1.result_source_key) ---AND (preparation_17.prep_code = q1.prep_code) 
                        AND (result_40.analyte_key IN (
                                                          541
                                                      )
                            )
                )                AS le_field_moist_to_oben_dry,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        LEFT OUTER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer result')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key)
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         541
                                                     )
                            )
                )                AS le_fm_to_od_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_40
                        INNER JOIN
                            dbo.preparation AS preparation_17
                                ON result_40.prep_key = preparation_17.prep_key
                    WHERE
                        (result_40.result_type = 'layer analyte')
                        AND (result_40.result_source_key = q1.result_source_key) --AND (preparation_17.prep_code = q1.prep_code) 
                        AND (result_40.analyte_key IN (
                                                          1924
                                                      )
                            )
                )                AS water_retention_0_bar_sieve,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         1924
                                                     )
                            )
                )                AS water_retention_0_bar_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_40
                        INNER JOIN
                            dbo.preparation AS preparation_17
                                ON result_40.prep_key = preparation_17.prep_key
                    WHERE
                        (result_40.result_type = 'layer analyte')
                        AND (result_40.result_source_key = q1.result_source_key) --AND (preparation_17.prep_code = q1.prep_code) 
                        AND (result_40.analyte_key IN (
                                                          6, 11, 390
                                                      )
                            )
                )                AS water_retention_6_hundredths,
                --(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                --  FROM            result_light AS result_40 INNER JOIN
                --                            dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                --  WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                --                            AND (result_40.analyte_key IN (1924))) AS water_retention_6_hundr_sieve,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         6, 11, 390
                                                     )
                            )
                )                AS water_retention_6_hund_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_40
                        INNER JOIN
                            dbo.preparation AS preparation_17
                                ON result_40.prep_key = preparation_17.prep_key
                    WHERE
                        (result_40.result_type = 'layer analyte')
                        AND (result_40.result_source_key = q1.result_source_key)
                       -- AND (preparation_17.prep_code = q1.prep_code) --dashed out prepcode JLN 07/08/2020
                        AND (result_40.analyte_key IN (
                                                          8, 391, 13
                                                      )
                            )
                )                AS water_retention_10th_bar,
                --(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                --  FROM            result_light AS result_40 INNER JOIN
                --                            dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                --  WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                --                            AND (result_40.analyte_key IN (391))) AS water_retention_10th_bar_sieve,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         8, 391, 13
                                                     )
                            )
                )                AS water_retention_10th_bar_meth,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_40
                        INNER JOIN
                            dbo.preparation AS preparation_17
                                ON result_40.prep_key = preparation_17.prep_key
                    WHERE
                        (result_40.result_type = 'layer analyte')
                        AND (result_40.result_source_key = q1.result_source_key) --AND (preparation_17.prep_code = q1.prep_code) 
                        AND (result_40.analyte_key IN (
                                                          9, 392, 14, 18
                                                      )
                            )
                )                AS water_retention_third_bar,
                --(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                --  FROM            result_light AS result_40 INNER JOIN
                --                            dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                --  WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                --                            AND (result_40.analyte_key IN (392, 18))) AS water_retention_thirdbar_sieve,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         9, 392, 14, 18
                                                     )
                            )
                )                AS water_retention_thirdbar_metho,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_40
                        INNER JOIN
                            dbo.preparation AS preparation_17
                                ON result_40.prep_key = preparation_17.prep_key
                    WHERE
                        (result_40.result_type = 'layer analyte')
                        AND (result_40.result_source_key = q1.result_source_key) --AND (preparation_17.prep_code = q1.prep_code) 
                        AND (result_40.analyte_key IN (
                                                          7, 393, 1040
                                                      )
                            )
                )                AS water_retention_1_bar,
                --(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                --  FROM            result_light AS result_40 INNER JOIN
                --                            dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                --  WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                --                            AND (result_40.analyte_key IN (393, 1040))) AS water_retention_1_bar_sieve,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key)
                        --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         7, 393, 1040
                                                     )
                            )
                )                AS water_retention_1_bar_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_40
                        INNER JOIN
                            dbo.preparation AS preparation_17
                                ON result_40.prep_key = preparation_17.prep_key
                    WHERE
                        (result_40.result_type = 'layer analyte')
                        AND (result_40.result_source_key = q1.result_source_key) --AND (preparation_17.prep_code = q1.prep_code) 
                        AND (result_40.analyte_key IN (
                                                          15, 1041, 395
                                                      )
                            )
                )                AS water_retention_2_bar,
                --(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                --  FROM            result_light AS result_40 INNER JOIN
                --                            dbo.preparation AS preparation_17 ON result_40.prep_key = preparation_17.prep_key
                --  WHERE        (result_40.result_type = 'layer analyte') AND (result_40.result_source_key = q1.result_source_key) AND (preparation_17.prep_code = q1.prep_code) 
                --                            AND (result_40.analyte_key IN (1041, 395))) AS water_retention_2_bar_sieve,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         15, 1041, 395
                                                     )
                            )
                )                AS water_retention_2_bar_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_40
                        INNER JOIN
                            dbo.preparation AS preparation_17
                                ON result_40.prep_key = preparation_17.prep_key
                    WHERE
                        (result_40.result_type = 'layer analyte')
                        AND (result_40.result_source_key = q1.result_source_key) ---AND (preparation_17.prep_code = q1.prep_code) 
                        AND (result_40.analyte_key = 2173)
                )                AS water_retention_3_bar_sieve,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         2173
                                                     )
                            )
                )                AS water_retention_3_bar_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_40
                        INNER JOIN
                            dbo.preparation AS preparation_17
                                ON result_40.prep_key = preparation_17.prep_key
                    WHERE
                        (result_40.result_type = 'layer analyte')
                        AND (result_40.result_source_key = q1.result_source_key) --AND (preparation_17.prep_code = q1.prep_code) 
                        AND (result_40.analyte_key = 1241)
                )                AS water_retention_5_bar_sieve,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         1241
                                                     )
                            )
                )                AS water_retention_5_bar_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_40.result_value, '5.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_40
                        INNER JOIN
                            dbo.preparation AS preparation_17
                                ON result_40.prep_key = preparation_17.prep_key
                    WHERE
                        (result_40.result_type = 'layer analyte')
                        AND (result_40.result_source_key = q1.result_source_key) --AND (preparation_17.prep_code = q1.prep_code) 
                        AND (result_40.analyte_key IN (
                                                          394, 785
                                                      )
                            )
                )                AS water_retention_15_bar,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         394, 785
                                                     )
                            )
                )                AS water_retention_15_bar_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_48.result_value, '5.2') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_48
                        INNER JOIN
                            dbo.preparation AS preparation_25
                                ON result_48.prep_key = preparation_25.prep_key
                    WHERE
                        (result_48.result_type = 'layer analyte')
                        AND (result_48.result_source_key = q1.result_source_key) --AND (preparation_25.prep_code = q1.prep_code) 
                        AND (result_48.analyte_key IN (
                                                          458, 459, 20, 30
                                                      )
                            )
                )                AS water_retention_field_state,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         458, 459, 20, 30
                                                     )
                            )
                )                AS water_retention_field_state_me,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_39.result_value, '4.3') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_39
                        INNER JOIN
                            dbo.preparation AS preparation_16
                                ON result_39.prep_key = preparation_16.prep_key
                    WHERE
                        (result_39.result_type = 'layer analyte')
                        AND (result_39.result_value <> '')
                        AND (result_39.result_source_key = q1.result_source_key)
                        AND (result_39.analyte_key = 396)
                )                AS airdry_ovendry_ratio,
                (
                    SELECT TOP (1)
                        result_38.result_value
                    FROM
                        result_light AS result_38
                        INNER JOIN
                            dbo.preparation AS preparation_15
                                ON result_38.prep_key = preparation_15.prep_key
                    WHERE
                        (result_38.result_type = 'layer analyte')
                        AND (result_38.result_value <> '')
                        AND (result_38.result_source_key = q1.result_source_key)
                        AND (result_38.analyte_key = 2)
                )                AS atterberg_liquid_limit,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         2
                                                     )
                            )
                )                AS atterberg_liquid_limit_method,
                (
                    SELECT TOP (1)
                        result_37.result_value
                    FROM
                        result_light AS result_37
                        INNER JOIN
                            dbo.preparation AS preparation_14
                                ON result_37.prep_key = preparation_14.prep_key
                    WHERE
                        (result_37.result_type = 'layer analyte')
                        AND (result_37.result_value <> '')
                        AND (result_37.result_source_key = q1.result_source_key)
                        AND (result_37.analyte_key = 557)
                )                AS atterberg_plasticity_index,
                (
                    SELECT TOP (1)
                        result_37.result_value
                    FROM
                        result_light AS result_37
                        INNER JOIN
                            dbo.preparation AS preparation_14
                                ON result_37.prep_key = preparation_14.prep_key
                    WHERE
                        (result_37.result_type = 'layer analyte')
                        AND (result_37.result_value <> '')
                        AND (result_37.result_source_key = q1.result_source_key)
                        AND (result_37.analyte_key = 3)
                )                AS plastic_limit,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         3
                                                     )
                            )
                )                AS plastic_limit_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '5.3') AS DECIMAL(15, 3)) AS Expr1
                    FROM
                        result_light AS result_36
                    WHERE
                        (result_type = 'layer analyte')
                        AND (result_value <> '')
                        AND (result_source_key = q1.result_source_key)
                        AND (analyte_key IN (
                                                1
                                            )
                            )
                )                AS aggregate_stability_05_2_mm,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         1
                                                     )
                            )
                )                AS aggregate_stability_05_2_metho,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '5.3') AS DECIMAL(15, 3)) AS Expr1
                    FROM
                        result_light AS result_35
                    WHERE
                        (result_type = 'layer result')
                        AND (result_value <> '')
                        AND (result_source_key = q1.result_source_key)
                        AND (analyte_key IN (
                                                562
                                            )
                            )
                )                AS le_to_clay_third_bar_to_ovendr,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '4.2') AS DECIMAL(15, 3)) AS Expr1
                    FROM
                        (
                            SELECT
                                result_value,
                                'S' AS prep_code
                            FROM
                                result_light AS result_34
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key IN (
                                                        558
                                                    )
                                    )
                            UNION
                            SELECT
                                result_value,
                                'M' AS prep_code
                            FROM
                                result_light AS result_32
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key IN (
                                                        1049
                                                    )
                                    )
                        ) AS result_1_5
                --WHERE        (prep_code = q1.prep_code)
                )                AS water_15_bar_to_clay_ratio,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '5.2') AS DECIMAL(15, 3)) AS Expr1
                    FROM
                        (
                            SELECT
                                result_value --, --'S' AS prep_code
                            FROM
                                result_light AS result_31
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key IN (
                                                        797, 743, 741, 739, 649, 622, 560
                                                    )
                                    )
                            UNION
                            SELECT
                                result_value --, -'M' AS prep_code
                            FROM
                                result_light AS result_30
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key IN (
                                                        1047
                                                    )
                                    )
                        ) AS result_1_4
                -- WHERE        (prep_code = q1.prep_code)
                )                AS cec7_clay_ratio,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '4.2') AS DECIMAL(15, 3)) AS Expr1
                    FROM
                        result_light AS result_33
                    WHERE
                        (result_type = 'layer result')
                        AND (result_value <> '')
                        AND (result_source_key = q1.result_source_key)
                        AND (analyte_key IN (
                                                564, 656, 657, 745, 746, 747
                                            )
                            )
                )                AS effective_cec_to_clay_ratio,
                (
                    SELECT TOP (1)
                        ISNULL(dbo.bridge_proced_ss.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss
                                ON result_1.procedure_key = dbo.bridge_proced_ss.procedure_key
                                   AND result_1.source_system_key = dbo.bridge_proced_ss.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         1763, 1764, 1765, 1766, 1767, 1768, 1769, 1770
                                                     )
                            )
                )                AS psda_ethanol_dispersion_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '4.1') AS DECIMAL(15, 3)) AS Expr1
                    FROM
                        (
                            SELECT
                                result_value,
                                'S' AS prep_code
                            FROM
                                result_light AS result_27
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 1769)
                        ) AS result_1_3
                )                AS sand_total_ethanol_dispersible,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '4.1') AS DECIMAL(15, 3)) AS Expr1
                    FROM
                        (
                            SELECT
                                result_value,
                                'S' AS prep_code
                            FROM
                                result_light AS result_27
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 1770)
                        ) AS result_1_3_2
                --WHERE        (prep_code = q1.prep_code)
                )                AS silt_total_ethanol_dispersible,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_10.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_10
                        INNER JOIN
                            dbo.preparation AS preparation_5
                                ON result_10.prep_key = preparation_5.prep_key
                    WHERE
                        (result_10.result_type = 'layer analyte')
                        AND (result_10.result_value <> '')
                        AND (result_10.result_source_key = q1.result_source_key) --AND 
                        --  (preparation_5.prep_code = q1.prep_code)
                        AND (
                                result_10.result_reliability IS NULL
                                OR result_10.result_reliability = '0'
                            )
                        AND (result_10.analyte_key = 1763)
                )                AS clay_total_ethanol_dispersible,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_10.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_10
                        INNER JOIN
                            dbo.preparation AS preparation_5
                                ON result_10.prep_key = preparation_5.prep_key
                    WHERE
                        (result_10.result_type = 'layer analyte')
                        AND (result_10.result_value <> '')
                        AND (result_10.result_source_key = q1.result_source_key) -- AND 
                        --  (preparation_5.prep_code = q1.prep_code)
                        AND (
                                result_10.result_reliability IS NULL
                                OR result_10.result_reliability = '0'
                            )
                        AND (result_10.analyte_key = 1764)
                )                AS sand_very_fine_ethanol_dispers,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_9.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_9
                        INNER JOIN
                            dbo.preparation AS preparation_4
                                ON result_9.prep_key = preparation_4.prep_key
                    WHERE
                        (result_9.result_type = 'layer analyte')
                        AND (result_9.result_value <> '')
                        AND (result_9.result_source_key = q1.result_source_key) -- AND 
                        -- (preparation_4.prep_code = q1.prep_code) 
                        AND (
                                result_9.result_reliability IS NULL
                                OR result_9.result_reliability = '0'
                            )
                        AND (result_9.analyte_key = 1765)
                )                AS sand_fine_ethanol_dispersible,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_8.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_8
                        INNER JOIN
                            dbo.preparation AS preparation_3
                                ON result_8.prep_key = preparation_3.prep_key
                    WHERE
                        (result_8.result_type = 'layer analyte')
                        AND (result_8.result_value <> '')
                        AND (result_8.result_source_key = q1.result_source_key) -- AND 
                        --(preparation_3.prep_code = q1.prep_code)
                        AND (
                                result_8.result_reliability IS NULL
                                OR result_8.result_reliability = '0'
                            )
                        AND (result_8.analyte_key = 1766)
                )                AS sand_medium_ethanol_dispersibl,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_7.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_7
                        INNER JOIN
                            dbo.preparation AS preparation_2
                                ON result_7.prep_key = preparation_2.prep_key
                    WHERE
                        (result_7.result_type = 'layer analyte')
                        AND (result_7.result_value <> '')
                        AND (result_7.result_source_key = q1.result_source_key) --AND 
                        --(preparation_2.prep_code = q1.prep_code)
                        AND (
                                result_7.result_reliability IS NULL
                                OR result_7.result_reliability = '0'
                            )
                        AND (result_7.analyte_key = 1767)
                )                AS sand_coarse_ethanol_dispersibl,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_6.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_6
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_6.prep_key = preparation_1.prep_key
                    WHERE
                        (result_6.result_type = 'layer analyte')
                        AND (result_6.result_value <> '')
                        AND (result_6.result_source_key = q1.result_source_key) --AND 
                        --  (preparation_1.prep_code = q1.prep_code)
                        AND (
                                result_6.result_reliability IS NULL
                                OR result_6.result_reliability = '0'
                            )
                        AND (result_6.analyte_key = 1768)
                )                AS sand_very_coarse_ethanol_disp,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         1018, 1197, 1067, 1062, 337, 1026, 1194, 334, 1023, 1191, 335,
                                                         1024, 1192, 333, 1022, 1190, 336, 1025, 1193, 1065, 1059,
                                                         1904, 1028, 1198, 637, 1064, 1061, 1906, 1029, 1196, 639,
                                                         1063, 1066, 1060, 1905, 338, 1027, 1195, 341, 638, 330, 1188,
                                                         331, 1189, 332, 339, 342
                                                     )
                            )
                )                AS water_dispersible_fraction_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_29.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_29
                        INNER JOIN
                            dbo.preparation AS preparation_13
                                ON result_29.prep_key = preparation_13.prep_key
                    WHERE
                        (result_29.result_type = 'layer analyte')
                        AND (result_29.result_value <> '')
                        AND (result_29.result_source_key = q1.result_source_key) --AND 
                        -- (preparation_13.prep_code = q1.prep_code) 
                        AND (
                                result_29.result_reliability IS NULL
                                OR result_29.result_reliability = '0'
                            )
                        AND (result_29.analyte_key IN (
                                                          332, 339, 342
                                                      )
                            )
                )                AS clay_tot_h2o_dispersible,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_28.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_28
                        INNER JOIN
                            dbo.preparation AS preparation_12
                                ON result_28.prep_key = preparation_12.prep_key
                    WHERE
                        (result_28.result_type = 'layer analyte')
                        AND (result_28.result_value <> '')
                        AND (result_28.result_source_key = q1.result_source_key) --AND 
                        --(preparation_12.prep_code = q1.prep_code) 
                        AND (
                                result_28.result_reliability IS NULL
                                OR result_28.result_reliability = '0'
                            )
                        AND (result_28.analyte_key IN (
                                                          331, 1189
                                                      )
                            )
                )                AS clay_fine_h2o_dispersible,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_14.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_14
                        INNER JOIN
                            dbo.preparation AS preparation_8
                                ON result_14.prep_key = preparation_8.prep_key
                    WHERE
                        (result_14.result_type = 'layer analyte')
                        AND (result_14.result_value <> '')
                        AND (result_14.result_source_key = q1.result_source_key) --AND 
                        -- (preparation_8.prep_code = q1.prep_code)
                        AND (
                                result_14.result_reliability IS NULL
                                OR result_14.result_reliability = '0'
                            )
                        AND (result_14.analyte_key IN (
                                                          330, 1188
                                                      )
                            )
                )                AS clay_co3_h2o_dispersible,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '4.1') AS DECIMAL(15, 3)) AS Expr1
                    FROM
                        (
                            SELECT
                                result_value,
                                'S' AS prep_code
                            FROM
                                result_light AS result_27
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 638)
                            UNION
                            SELECT
                                result_value,
                                'M' AS prep_code
                            FROM
                                result_light AS result_26
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key IN (
                                                        1018, 1197
                                                    )
                                    )
                            UNION
                            SELECT
                                result_value,
                                'N' AS prep_code
                            FROM
                                result_light AS result_25
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key IN (
                                                        1060, 1905
                                                    )
                                    )
                            UNION
                            SELECT
                                result_value,
                                'GP' AS prep_code
                            FROM
                                result_light AS result_24
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 1066)
                            UNION
                            SELECT
                                result_value,
                                'HM' AS prep_code
                            FROM
                                result_light AS result_23
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 1063)
                        ) AS result_1_3_1
                )                AS silt_total_h2o_dispersible,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_12.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_12
                        INNER JOIN
                            dbo.preparation AS preparation_6
                                ON result_12.prep_key = preparation_6.prep_key
                    WHERE
                        (result_12.result_type = 'layer analyte')
                        AND (result_12.result_value <> '')
                        AND (result_12.result_source_key = q1.result_source_key) --AND 
                        --  (preparation_6.prep_code = q1.prep_code)
                        AND (
                                result_12.result_reliability IS NULL
                                OR result_12.result_reliability = '0'
                            )
                        AND (result_12.analyte_key IN (
                                                          338, 1027, 1195, 341
                                                      )
                            )
                )                AS silt_fine_h2o_dispersible,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '4.1') AS DECIMAL(15, 3)) AS Expr1
                    FROM
                        (
                            SELECT
                                result_value,
                                'S' AS prep_code
                            FROM
                                result_light AS result_22
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 639)
                            UNION
                            SELECT
                                result_value,
                                'M' AS prep_code
                            FROM
                                result_light AS result_21
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key IN (
                                                        1029, 1196
                                                    )
                                    )
                            UNION
                            SELECT
                                result_value,
                                'N' AS prep_code
                            FROM
                                result_light AS result_20
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key IN (
                                                        1061, 1906
                                                    )
                                    )
                            UNION
                            SELECT
                                result_value,
                                'HM' AS prep_code
                            FROM
                                result_light AS result_19
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 1064)
                            UNION
                            SELECT
                                result_value,
                                'GP' AS prep_code
                            FROM
                                result_light AS result_18
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 1067)
                        ) AS result_1_2
                )                AS silt_coarse_h2o_dispersible,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '4.1') AS DECIMAL(15, 3)) AS Expr1
                    FROM
                        (
                            SELECT
                                result_value,
                                'S' AS prep_code
                            FROM
                                result_light AS result_17
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 637)
                            UNION
                            SELECT
                                result_value,
                                'M' AS prep_code
                            FROM
                                result_light AS result_14
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key IN (
                                                        1028, 1198
                                                    )
                                    )
                            UNION
                            SELECT
                                result_value,
                                'N' AS prep_code
                            FROM
                                result_light AS result_13
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key IN (
                                                        1059, 1904
                                                    )
                                    )
                            UNION
                            SELECT
                                result_value,
                                'GP' AS prep_code
                            FROM
                                result_light AS result_12
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 1065)
                            UNION
                            SELECT
                                result_value,
                                'HM' AS prep_code
                            FROM
                                result_light AS result_5
                            WHERE
                                (result_type = 'layer result')
                                AND (result_value <> '')
                                AND (result_source_key = q1.result_source_key)
                                AND (analyte_key = 1062)
                        ) AS result_1_1
                )                AS sand_total_h2o_dispersible,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_10.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_10
                        INNER JOIN
                            dbo.preparation AS preparation_5
                                ON result_10.prep_key = preparation_5.prep_key
                    WHERE
                        (result_10.result_type = 'layer analyte')
                        AND (result_10.result_value <> '')
                        AND (result_10.result_source_key = q1.result_source_key) --AND 
                        --  (preparation_5.prep_code = q1.prep_code) 
                        AND (
                                result_10.result_reliability IS NULL
                                OR result_10.result_reliability = '0'
                            )
                        AND (result_10.analyte_key IN (
                                                          337, 1026, 1194
                                                      )
                            )
                )                AS sand_vf_h2o_dispersible,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_9.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_9
                        INNER JOIN
                            dbo.preparation AS preparation_4
                                ON result_9.prep_key = preparation_4.prep_key
                    WHERE
                        (result_9.result_type = 'layer analyte')
                        AND (result_9.result_value <> '')
                        AND (result_9.result_source_key = q1.result_source_key) --AND 
                        --(preparation_4.prep_code = q1.prep_code) 
                        AND (
                                result_9.result_reliability IS NULL
                                OR result_9.result_reliability = '0'
                            )
                        AND (result_9.analyte_key IN (
                                                         334, 1023, 1191
                                                     )
                            )
                )                AS sand_fine_h2o_dispersible,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_8.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_8
                        INNER JOIN
                            dbo.preparation AS preparation_3
                                ON result_8.prep_key = preparation_3.prep_key
                    WHERE
                        (result_8.result_type = 'layer analyte')
                        AND (result_8.result_value <> '')
                        AND (result_8.result_source_key = q1.result_source_key) --AND 
                        --   (preparation_3.prep_code = q1.prep_code)
                        AND (
                                result_8.result_reliability IS NULL
                                OR result_8.result_reliability = '0'
                            )
                        AND (result_8.analyte_key IN (
                                                         335, 1024, 1192
                                                     )
                            )
                )                AS sand_medium_h2o_dispersible,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_7.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_7
                        INNER JOIN
                            dbo.preparation AS preparation_2
                                ON result_7.prep_key = preparation_2.prep_key
                    WHERE
                        (result_7.result_type = 'layer analyte')
                        AND (result_7.result_value <> '')
                        AND (result_7.result_source_key = q1.result_source_key) --AND 
                        --- (preparation_2.prep_code = q1.prep_code)
                        AND (
                                result_7.result_reliability IS NULL
                                OR result_7.result_reliability = '0'
                            )
                        AND (result_7.analyte_key IN (
                                                         333, 1022, 1190
                                                     )
                            )
                )                AS sand_coarse_h2o_dispersible,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_6.result_value, '4.1') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_6
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_6.prep_key = preparation_1.prep_key
                    WHERE
                        (result_6.result_type = 'layer analyte')
                        AND (result_6.result_value <> '')
                        AND (result_6.result_source_key = q1.result_source_key) --AND 
                        -- (preparation_1.prep_code = q1.prep_code)
                        AND (
                                result_6.result_reliability IS NULL
                                OR result_6.result_reliability = '0'
                            )
                        AND (result_6.analyte_key IN (
                                                         336, 1025, 1193
                                                     )
                            )
                )                AS sand_vc_h2o_dispersible,
                (
                    SELECT TOP (1)
                        result_9.result_value
                    FROM
                        result_light AS result_9
                        INNER JOIN
                            dbo.preparation AS preparation_8
                                ON result_9.prep_key = preparation_8.prep_key
                    WHERE
                        (result_9.result_type = 'layer analyte')
                        AND (result_9.result_source_key = q1.result_source_key) --AND (preparation_8.prep_code = q1.prep_code)
                        AND (result_9.analyte_key = 239)
                )                AS color_pyrophosphate_extract,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_5.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_5
                                ON result_1.procedure_key = bridge_proced_ss_5.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_5.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         239
                                                     )
                            )
                )                AS color_pyrophosphate_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_4.result_value, '4.2') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_4
                        INNER JOIN
                            dbo.preparation AS preparation_4
                                ON result_4.prep_key = preparation_4.prep_key
                    WHERE
                        (result_4.result_type = 'layer analyte')
                        AND (result_4.result_source_key = q1.result_source_key)
                        --AND ('MW' = q1.prep_code) --dashed out prepcode JLN 07/08/2020
                        AND (result_4.analyte_key = 24)
                )                AS bd_thirdbar_before_rewet_organ,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_4.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_4
                                ON result_1.procedure_key = bridge_proced_ss_4.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_4.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         24
                                                     )
                            )
                )                AS bd_before_rewet_organic_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_3.result_value, '4.2') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_3
                        INNER JOIN
                            dbo.preparation AS preparation_3
                                ON result_3.prep_key = preparation_3.prep_key
                    WHERE
                        (result_3.result_type = 'layer analyte')
                        AND (result_3.result_source_key = q1.result_source_key)
                        --AND ('MW' = q1.prep_code)--dashed out prepcode JLN 07/08/2020
                        AND (result_3.analyte_key = 25)
                )                AS bd_thirdbar_rewet_organic_soil,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_3.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_3
                                ON result_1.procedure_key = bridge_proced_ss_3.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_3.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         25
                                                     )
                            )
                )                AS bd_third_rewet_organic_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '4.3') AS DECIMAL(11, 3)) AS Expr1
                    FROM
                        result_light AS result_11
                    WHERE
                        (result_type = 'layer analyte')
                        AND (result_value <> '')
                        AND (result_source_key = q1.result_source_key)
                        AND (analyte_key = 23)
                )                AS bulk_den_rewet_oven_dry,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_6.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_6
                                ON result_1.procedure_key = bridge_proced_ss_6.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_6.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code)
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         23
                                                     )
                            )
                )                AS bulk_den_rewet_oven_dry_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_2.result_value, '3.0') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_2
                        INNER JOIN
                            dbo.preparation AS preparation_11
                                ON result_2.prep_key = preparation_11.prep_key
                    WHERE
                        (result_2.result_type = 'layer analyte')
                        AND (result_2.result_source_key = q1.result_source_key) --AND (preparation_11.prep_code = q1.prep_code) 
                        AND (result_2.analyte_key = 76)
                )                AS mineral_content_loss_on_igniti,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_2.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_2
                                ON result_1.procedure_key = bridge_proced_ss_2.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_2.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code)
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         76
                                                     )
                            )
                )                AS mineral_content_loi_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '4.0') AS DECIMAL(15, 3)) AS Expr1
                    FROM
                        result_light AS result_16
                    WHERE
                        (result_type = 'layer result')
                        AND (result_source_key = q1.result_source_key)
                        AND (analyte_key IN (
                                                775
                                            )
                            )
                )                AS estimated_organic_matter,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_value, '4.0') AS DECIMAL(15, 3)) AS Expr1
                    FROM
                        result_light AS result_15
                    WHERE
                        (result_type = 'layer result')
                        AND (result_source_key = q1.result_source_key)
                        AND (analyte_key IN (
                                                776
                                            )
                            )
                )                AS estimated_om_plus_mineral,
                (
                    SELECT TOP (1)
                        ISNULL(bridge_proced_ss_1.proced_code, '') AS Expr1
                    FROM
                        result_light AS result_1
                        INNER JOIN
                            dbo.preparation AS preparation_1
                                ON result_1.prep_key = preparation_1.prep_key
                        LEFT OUTER JOIN
                            dbo.bridge_proced_ss AS bridge_proced_ss_1
                                ON result_1.procedure_key = bridge_proced_ss_1.procedure_key
                                   AND result_1.source_system_key = bridge_proced_ss_1.source_system_key
                    WHERE
                        (result_1.result_type = 'layer analyte')
                        AND (result_1.result_value <> '')
                        AND (NOT (result_1.result_value IS NULL))
                        AND (result_1.result_source_key = q1.result_source_key) --AND (preparation_1.prep_code = q1.prep_code) 
                        AND (
                                result_1.result_reliability IS NULL
                                OR result_1.result_reliability = '0'
                            )
                        AND (result_1.analyte_key IN (
                                                         240, 241, 777, 778
                                                     )
                            )
                )                AS fiber_analysis_method,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_11.result_value, '3.0') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_11
                        INNER JOIN
                            dbo.preparation AS preparation_10
                                ON result_11.prep_key = preparation_10.prep_key
                    WHERE
                        (result_11.result_type = 'layer analyte')
                        AND (result_11.result_source_key = q1.result_source_key) --AND (preparation_10.prep_code = q1.prep_code) 
                        AND (result_11.analyte_key = 241)
                )                AS fiber_unrubbed,
                (
                    SELECT TOP (1)
                        CAST(dbo.AsymArithRnd(result_10.result_value, '3.0') AS DECIMAL(10, 3)) AS Expr1
                    FROM
                        result_light AS result_10
                        INNER JOIN
                            dbo.preparation AS preparation_9
                                ON result_10.prep_key = preparation_9.prep_key
                    WHERE
                        (result_10.result_type = 'layer analyte')
                        AND (result_10.result_source_key = q1.result_source_key) --AND (preparation_9.prep_code = q1.prep_code) 
                        AND (result_10.analyte_key = 240)
                )                AS fiber_rubbed,
                (
                    SELECT TOP (1)
                        result_value
                    FROM
                        result_light AS result_8
                    WHERE
                        (result_type = 'layer result')
                        AND (result_source_key = q1.result_source_key)
                        AND (analyte_key IN (
                                                777
                                            )
                            )
                )                AS decomposition_state,
                (
                    SELECT TOP (1)
                        result_7.result_value
                    FROM
                        result_light AS result_7
                        LEFT OUTER JOIN
                            dbo.preparation AS preparation_7
                                ON result_7.prep_key = preparation_7.prep_key
                    WHERE
                        (result_7.result_type = 'layer result')
                        AND (result_7.result_source_key = q1.result_source_key)
                        AND (result_7.analyte_key = 778)
                )                AS limnic_material_type
            ----INTO  
            ----#temp_results_step7

            FROM
                dbo.layer
                INNER JOIN
                    result_light AS q1
                        ON dbo.layer.layer_key = q1.result_source_key;




----------- this is needed for a different step - temporary table in ncsslabdata database - will be dropped when all steps are complete
DROP TABLE IF EXISTS dbo.lab_physical_properties;
SELECT
    labsampnum,
    result_source_key,
    prep_code,
    [texture_lab],
    [particle_size_method],
    [clay_total],
    [silt_total],
    [sand_total],
    [clay_fine],
    [clay_caco3],
    [silt_fine],
    [silt_coarse],
    [sand_very_fine],
    [sand_fine],
    [sand_medium],
    [sand_coarse],
    [sand_very_coarse],
    [frag_2_5_mm_wt_pct_lt_75],
    [frag__2_20_mm_wt_pct_lt_75],
    [frag_5_20_mm_wt_pct_lt_75],
    [frag_20_75_mm_wt_pct_lt_75],
    [total_frag_wt_pct_gt_2_mm_ws],
    [wt_pct_1_tenth_to_75_mm],
    [bulk_density_tenth_bar],
    [bulk_density_tenth_bar_method],
    [bulk_density_third_bar],
    [bulk_density_third_bar_method],
    [bulk_density_oven_dry],
    [bulk_density_oven_dry_method],
    [bulk_density_lt_2_mm_air_dry],
    [bulk_density_air_dry_method],
    [bd_third_bar_lt2_reconstituted],
    [bd_thirdbar_reconstituted_method],
    [bulk_den_ovendry_reconstituted],
    [bulk_de_odreconstituted_method],
    [bulk_density_field_moist],
    [bulk_density_field_moist_metho],
    [particle_density_less_than_2mm],
    [particle_density_lt_2mm_method],
    [particle_density_gt_2_mm],
    [particle_density_gt_2mm_method],
    [cole_whole_soil],
    [cole_whole_soil_method],
    [le_third_fifteen_lt2_mm],
    [le_third_fifteen_lt2_metho],
    [le_third_ovendry_lt_2_mm],
    [le_third_ovendry_lt_2_mm_metho],
    [le_field_moist_to_oben_dry],
    [le_fm_to_od_method],
    [water_retention_0_bar_sieve],
    [water_retention_0_bar_method],
    [water_retention_6_hundredths],
    [water_retention_6_hund_method],
    [water_retention_10th_bar],
    [water_retention_10th_bar_meth],
    [water_retention_third_bar],
    [water_retention_thirdbar_metho],
    [water_retention_1_bar],
    [water_retention_1_bar_method],
    [water_retention_2_bar],
    [water_retention_2_bar_method],
    [water_retention_3_bar_sieve],
    [water_retention_3_bar_method],
    [water_retention_5_bar_sieve],
    [water_retention_5_bar_method],
    [water_retention_15_bar],
    [water_retention_15_bar_method],
    [water_retention_field_state],
    [water_retention_field_state_me],
    [airdry_ovendry_ratio],
    [atterberg_liquid_limit],
    [atterberg_liquid_limit_method],
    [atterberg_plasticity_index],
    [plastic_limit],
    [plastic_limit_method],
    [aggregate_stability_05_2_mm],
    [aggregate_stability_05_2_metho],
    [le_to_clay_third_bar_to_ovendr],
    [water_15_bar_to_clay_ratio],
    [cec7_clay_ratio],
    [effective_cec_to_clay_ratio],
    [psda_ethanol_dispersion_method],
    [sand_total_ethanol_dispersible],
    [silt_total_ethanol_dispersible],
    [clay_total_ethanol_dispersible],
    [sand_very_fine_ethanol_dispers],
    [sand_fine_ethanol_dispersible],
    [sand_medium_ethanol_dispersibl],
    [sand_coarse_ethanol_dispersibl],
    [sand_very_coarse_ethanol_disp],
    [water_dispersible_fraction_method],
    [clay_tot_h2o_dispersible],
    [clay_fine_h2o_dispersible],
    [clay_co3_h2o_dispersible],
    [silt_total_h2o_dispersible],
    [silt_fine_h2o_dispersible],
    [silt_coarse_h2o_dispersible],
    [sand_total_h2o_dispersible],
    [sand_vf_h2o_dispersible],
    [sand_fine_h2o_dispersible],
    [sand_medium_h2o_dispersible],
    [sand_coarse_h2o_dispersible],
    [sand_vc_h2o_dispersible],
    [color_pyrophosphate_extract],
    [color_pyrophosphate_method],
    [bd_thirdbar_before_rewet_organ],
    [bd_before_rewet_organic_method],
    [bd_thirdbar_rewet_organic_soil],
    [bd_third_rewet_organic_method],
    [bulk_den_rewet_oven_dry],
    [bulk_den_rewet_oven_dry_method],
    [mineral_content_loss_on_igniti],
    [mineral_content_loi_method],
    [estimated_organic_matter],
    [estimated_om_plus_mineral],
    [fiber_analysis_method],
    [fiber_unrubbed],
    [fiber_rubbed],
    [decomposition_state],
    [limnic_material_type]
INTO
    lab_physical_properties
FROM
    #temp_results_step7
GROUP BY
    labsampnum,
    result_source_key,
    prep_code,
    [texture_lab],
    [particle_size_method],
    [clay_total],
    [silt_total],
    [sand_total],
    [clay_fine],
    [clay_caco3],
    [silt_fine],
    [silt_coarse],
    [sand_very_fine],
    [sand_fine],
    [sand_medium],
    [sand_coarse],
    [sand_very_coarse],
    [frag_2_5_mm_wt_pct_lt_75],
    [frag__2_20_mm_wt_pct_lt_75],
    [frag_5_20_mm_wt_pct_lt_75],
    [frag_20_75_mm_wt_pct_lt_75],
    [total_frag_wt_pct_gt_2_mm_ws],
    [wt_pct_1_tenth_to_75_mm],
    [bulk_density_tenth_bar],
    [bulk_density_tenth_bar_method],
    [bulk_density_third_bar],
    [bulk_density_third_bar_method],
    [bulk_density_oven_dry],
    [bulk_density_oven_dry_method],
    [bulk_density_lt_2_mm_air_dry],
    [bulk_density_air_dry_method],
    [bd_third_bar_lt2_reconstituted],
    [bd_thirdbar_reconstituted_method],
    [bulk_den_ovendry_reconstituted],
    [bulk_de_odreconstituted_method],
    [bulk_density_field_moist],
    [bulk_density_field_moist_metho],
    [particle_density_less_than_2mm],
    [particle_density_lt_2mm_method],
    [particle_density_gt_2_mm],
    [particle_density_gt_2mm_method],
    [cole_whole_soil],
    [cole_whole_soil_method],
    [le_third_fifteen_lt2_mm],
    [le_third_fifteen_lt2_metho],
    [le_third_ovendry_lt_2_mm],
    [le_third_ovendry_lt_2_mm_metho],
    [le_field_moist_to_oben_dry],
    [le_fm_to_od_method],
    [water_retention_0_bar_sieve],
    [water_retention_0_bar_method],
    [water_retention_6_hundredths],
    [water_retention_6_hund_method],
    [water_retention_10th_bar],
    [water_retention_10th_bar_meth],
    [water_retention_third_bar],
    [water_retention_thirdbar_metho],
    [water_retention_1_bar],
    [water_retention_1_bar_method],
    [water_retention_2_bar],
    [water_retention_2_bar_method],
    [water_retention_3_bar_sieve],
    [water_retention_3_bar_method],
    [water_retention_5_bar_sieve],
    [water_retention_5_bar_method],
    [water_retention_15_bar],
    [water_retention_15_bar_method],
    [water_retention_field_state],
    [water_retention_field_state_me],
    [airdry_ovendry_ratio],
    [atterberg_liquid_limit],
    [atterberg_liquid_limit_method],
    [atterberg_plasticity_index],
    [plastic_limit],
    [plastic_limit_method],
    [aggregate_stability_05_2_mm],
    [aggregate_stability_05_2_metho],
    [le_to_clay_third_bar_to_ovendr],
    [water_15_bar_to_clay_ratio],
    [cec7_clay_ratio],
    [effective_cec_to_clay_ratio],
    [psda_ethanol_dispersion_method],
    [sand_total_ethanol_dispersible],
    [silt_total_ethanol_dispersible],
    [clay_total_ethanol_dispersible],
    [sand_very_fine_ethanol_dispers],
    [sand_fine_ethanol_dispersible],
    [sand_medium_ethanol_dispersibl],
    [sand_coarse_ethanol_dispersibl],
    [sand_very_coarse_ethanol_disp],
    [water_dispersible_fraction_method],
    [clay_tot_h2o_dispersible],
    [clay_fine_h2o_dispersible],
    [clay_co3_h2o_dispersible],
    [silt_total_h2o_dispersible],
    [silt_fine_h2o_dispersible],
    [silt_coarse_h2o_dispersible],
    [sand_total_h2o_dispersible],
    [sand_vf_h2o_dispersible],
    [sand_fine_h2o_dispersible],
    [sand_medium_h2o_dispersible],
    [sand_coarse_h2o_dispersible],
    [sand_vc_h2o_dispersible],
    [color_pyrophosphate_extract],
    [color_pyrophosphate_method],
    [bd_thirdbar_before_rewet_organ],
    [bd_before_rewet_organic_method],
    [bd_thirdbar_rewet_organic_soil],
    [bd_third_rewet_organic_method],
    [bulk_den_rewet_oven_dry],
    [bulk_den_rewet_oven_dry_method],
    [mineral_content_loss_on_igniti],
    [mineral_content_loi_method],
    [estimated_organic_matter],
    [estimated_om_plus_mineral],
    [fiber_analysis_method],
    [fiber_unrubbed],
    [fiber_rubbed],
    [decomposition_state],
    [limnic_material_type];



CREATE INDEX lab_physical_properties_idx1c
    ON lab_physical_properties (labsampnum, result_source_key)
    INCLUDE (prep_code);
CREATE INDEX lab_physical_properties_result_source_key_idx2
    ON lab_physical_properties (result_source_key);
CREATE INDEX lab_physical_properties_prep_code_idx5
    ON lab_physical_properties (prep_code);