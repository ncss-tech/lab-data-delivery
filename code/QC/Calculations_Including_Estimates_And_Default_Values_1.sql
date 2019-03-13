USE [master]
GO
ALTER DATABASE [ncsslabdata] SET COMPATIBILITY_LEVEL = 130
GO

SELECT @@VERSION AS SQL_Server_Version

USE ncsslabdata
go

	  DROP TABLE IF EXISTS result_light
	  DROP TABLE IF EXISTS result_light_calcEst
	  DROP TABLE IF EXISTS #tempXX
	  DROP TABLE IF EXISTS SDA_Calculations_Including_Estimates_And_Default_Values1
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
		   (result_value IS NOT NULL AND 
		    analyte_key 
		   IN (4, 25, 28, 243, 242, 590, 591, 593))

  	CREATE INDEX  result_light_idx1c ON  result_light (analyte_key, result_type, result_source_key,  result_reliability) INCLUDE (result_value, proced_code,prep_code)
	CREATE INDEX  result_light_idx1b ON  result_light (analyte_key,  result_reliability)
	CREATE INDEX  result_light_result_source_key_idx2 ON  result_light (result_source_key )
	CREATE INDEX  result_light_prep_key_idx3 ON  result_light (prep_key)
	CREATE INDEX  result_source_system_key_idx4 ON result_light (source_system_key)
	CREATE INDEX  result_light_prep_code_idx5 ON  result_light (prep_code)

 
SELECT DISTINCT natural_key AS labsampnum, result_source_key, prep_code,					
							
							
							
								ISNULL((SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM  result_light AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																					   result.analyte_key = 4),
								ISNULL((SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM result_light AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																			   result.analyte_key = 25),
								ISNULL((SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM  result_light AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																			   result.analyte_key = 28),
								1.45))) 
							AS bulk_density_3rd_bar_for_calc, 

									CASE WHEN NOT (SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM result_light AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																			   result.analyte_key = 4) IS NULL THEN 'db_13b'
									 WHEN NOT (SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM result_light AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																			   result.analyte_key = 25) IS NULL THEN 'db_3rw'
									 WHEN NOT (SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM result_light AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																				   result.analyte_key = 28) IS NULL THEN 'db_3est'
									 ELSE 'default'
								END 
							AS bulk_density_3rd_bar_source,
												ISNULL((SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM result_light AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																						   result.analyte_key = 243),
								ISNULL((SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM result_light AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																				   result.analyte_key = 242),
								2.65)) 
							AS particle_density_for_calc,
								CASE WHEN NOT (SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM result_light AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																				   result.analyte_key = 243) IS NULL THEN 'pd_g2'
									 WHEN NOT (SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM result_light AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																				   result.analyte_key = 242) IS NULL THEN 'pd_l2'
									 ELSE 'default'
								END 
							AS particle_density_calc_sour,
		


						  (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(15, 3)) AS Expr1
				                          FROM result_light  result
	                               WHERE       (result.result_type = 'layer result') AND (result.result_source_key = q1.result_source_key)  AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 590)) AS bulk_density_third_bar_ws,

								     (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(15, 3)) AS Expr1
				                          FROM result_light  result
	                               WHERE       (result.result_type = 'layer result') AND (result.result_source_key = q1.result_source_key)  AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 591)) AS bulk_density_oven_dry_ws,

								     (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(15, 3)) AS Expr1
					                          FROM result_light  result
		                               WHERE       (result.result_type = 'layer result') AND (result.result_source_key = q1.result_source_key) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 593)) AS bulk_density_saturated_whole_so		
INTO SDA_Calculations_Including_Estimates_And_Default_Values1
FROM  dbo.layer 
INNER JOIN result_light AS q1 ON dbo.layer.layer_key = q1.result_source_key 

CREATE INDEX  SDA_Calculations_Including_Estimates_And_Default_Values1_idx1c ON  SDA_Calculations_Including_Estimates_And_Default_Values1 (labsampnum, result_source_key) INCLUDE (prep_code)
CREATE INDEX  SDA_Calculations_Including_Estimates_And_Default_Values1_result_source_key_idx2 ON  SDA_Calculations_Including_Estimates_And_Default_Values1 (result_source_key )
CREATE INDEX SDA_Calculations_Including_Estimates_And_Default_Values1_prep_code_idx5 ON  SDA_Calculations_Including_Estimates_And_Default_Values1 (prep_code)

GO
SET STATISTICS IO OFF
GO
								   		