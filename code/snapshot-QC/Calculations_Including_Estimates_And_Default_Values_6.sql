USE [master]
GO
ALTER DATABASE [ncsslabdata] SET COMPATIBILITY_LEVEL = 130
GO

SELECT @@VERSION AS SQL_Server_Version

USE ncsslabdata
go


	  DROP TABLE IF EXISTS result_light
	  DROP TABLE IF EXISTS #tempXX
	  DROP TABLE IF EXISTS SDA_Calculations_Including_Estimates_And_Default_Values6
	  DROP TABLE IF EXISTS SDA_Calculations_Including_Estimates_And_Default_Values


 CREATE TABLE result_light (result_key INT NOT NULL  , result_source_key INT, 
	  prep_key int,  result_type VARCHAR(128), result_reliability VARCHAR(20), 
	  analyte_key int, procedure_key int, source_system_key int, result_value VARCHAR(128) , 
	  prep_code VARCHAR(64) , proced_code VARCHAR(12),
	   CONSTRAINT pk_result_light PRIMARY KEY CLUSTERED (result_key))
	  go


	  INSERT INTO result_light
	  SELECT result_key, result_source_key, r.prep_key,  result_type, result_reliability, analyte_key, r.procedure_key, r.source_system_key, result_value, p.prep_code  , b.proced_code

	FROM dbo.result r
    LEFT OUTER JOIN dbo.preparation AS p  ON r.prep_key = p.prep_key
    LEFT OUTER JOIN dbo.bridge_proced_ss AS b  ON r.procedure_key = b.procedure_key AND r.source_system_key = b.source_system_key 
            WHERE 
		   (result_value IS NOT NULL AND result_type = 'layer result' AND
		    analyte_key 
		   IN (544,542, 543, 548, 549,553,551,554,552,546,550,545,528,526))

 	CREATE INDEX  result_light_idx1c ON  result_light (analyte_key, result_type, result_source_key,  result_reliability) INCLUDE (result_value, proced_code,prep_code)
	CREATE INDEX  result_light_idx1b ON  result_light (analyte_key,  result_reliability)
	CREATE INDEX  result_light_result_source_key_idx2 ON  result_light (result_source_key )
	CREATE INDEX  result_light_prep_key_idx3 ON  result_light (prep_key)
	CREATE INDEX  result_source_system_key_idx4 ON result_light (source_system_key)
	CREATE INDEX  result_light_prep_code_idx5 ON  result_light (prep_code)

GO
SET STATISTICS IO ON
GO

SELECT  natural_key AS labsampnum, result_source_key, prep_code ,                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light  result
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =544)) 
						AS percent_passing_2_inch_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light  AS result_65
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =542)) 
						AS percent_passing_1_and_1_half,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light  AS result_64
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =543)) 
						AS percent_passing_1_inch_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light  AS result_63
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =548))
						AS percent_passing_3_quarter_inch,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light  AS result_62
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =549)) 
						AS percent_passing_3_eights_inch,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light  AS result_61
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =553)) 
                         AS percent_passing_no_4_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light  AS result_60
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =551)) 
                         AS percent_passing_no_10_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light  AS result_59
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =554)) 
                         AS percent_passing_no_40_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light  AS result_58
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =552)) 
                         AS percent_passing_no_200_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light  AS result_57
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =546)) 
                         AS percent_passing_20_micron_siev,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light  AS result_56
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =550)) 
                         AS percent_passing_5_micron_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light  AS result_55
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =545)) 
                         AS percent_passing_2_micron_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light  AS result_54
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =528)) 
                         AS cumulative_curve_less_than_1mm,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light  AS result_53
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =526)) 
                         AS cumulative_curve_lt_1_half_mm


INTO SDA_Calculations_Including_Estimates_And_Default_Values6
FROM  dbo.layer 
INNER JOIN result_light AS q1 ON dbo.layer.layer_key = q1.result_source_key 

CREATE INDEX  SDA_Calculations_Including_Estimates_And_Default_Values6_idx1c ON  SDA_Calculations_Including_Estimates_And_Default_Values6 (labsampnum, result_source_key) INCLUDE (prep_code)
CREATE INDEX  SDA_Calculations_Including_Estimates_And_Default_Values2_result_source_key_idx6 ON  SDA_Calculations_Including_Estimates_And_Default_Values6 (result_source_key )
CREATE INDEX SDA_Calculations_Including_Estimates_And_Default_Values2_prep_code_idx6 ON  SDA_Calculations_Including_Estimates_And_Default_Values6 (prep_code)

GO
SET STATISTICS IO OFF
GO