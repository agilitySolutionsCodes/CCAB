set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_CronogramaSafra.sql
**		Name: SP_S_CronogramaSafra
**		Desc: Obtem um registro da tabela CronogramaSafra
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_CronogramaSafra]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_CronogramaSafra]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_CronogramaSafra]
	 @cdCronogramaSafraSEQ	BIGINT
 
 
AS
 
	--seleção
	SELECT 
		 cdCronogramaSafraSEQ
		,dsCronogramaSafra
		,dtInicioCronogramaSafra
		,dtFimCronogramaSafra
		,dtLimiteLiberacaoCCCronogramaSafra
		,dtLimiteAprovacaoCCCronogramaSafra
		,dtLimiteLiberacaoPVCronogramaSafra
		,dtLimiteAprovacaoPVRCCronogramaSafra
		,dtLimiteAprovacaoPVACCronogramaSafra
		,wkCronogramaSafra
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
		,cdIndicadorSituacaoCronogramaSafra		as cdIndicadorStatusCronogramaSafra
		,qtProdutoPrecoCronogramaSafra

	FROM
		CronogramaSafra (nolock)
	WHERE 
		cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
 
 
/*
-----------------------------------------------
Método C#
 
Parâmetros:
Int64 cdCronogramaSafraSEQ
 
Corpo:
loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;
*/
