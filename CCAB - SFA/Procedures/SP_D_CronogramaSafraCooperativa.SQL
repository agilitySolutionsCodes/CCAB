/******************************************************************************
**		File: SP_D_CronogramaSafraCooperativa.SQL
**		Name: SP_D_CronogramaSafraCooperativa
**		Desc: Exclui o registro da tabela 
**
**		Auth: Roberto (Convergence)
**		Date: 05.05.2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_D_CronogramaSafraCooperativa]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_D_CronogramaSafraCooperativa]
END
GO

CREATE PROCEDURE [dbo].[SP_D_CronogramaSafraCooperativa]
	 @cdCronogramaSafraCooperativaSEQ						bigint
AS



	--Histórico
	DELETE 
		dbo.CronogramaSafraCooperativaVNCHistorico
	WHERE
		cdCronogramaSafraCooperativaSEQ = @cdCronogramaSafraCooperativaSEQ
		

	--Principal
	DELETE 
		dbo.CronogramaSafraCooperativa
	WHERE
		cdCronogramaSafraCooperativaSEQ = @cdCronogramaSafraCooperativaSEQ




