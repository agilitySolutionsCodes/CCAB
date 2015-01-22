set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_CronogramaSafraVencimento.sql
**		Name: SP_S_CronogramaSafraVencimento
**		Desc: Obtem um registro da tabela CronogramaSafraVencimento
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_CronogramaSafraVencimento]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_CronogramaSafraVencimento]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_CronogramaSafraVencimento]
	 @cdCronogramaSafraVencimentoSEQ	BIGINT
 
 
AS
 
	--seleção
	SELECT 
		 cdCronogramaSafraVencimentoSEQ
		,cdCronogramaSafraSEQ
		,cdTipoCronogramaSafraVencimento
		,dtCronogramaSafraVencimento
		,pcCorrecaoPrecoTipoCulturaVencimento
		,wkCronogramaSafraVencimento
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
		,pcDescontoPontualidade
		
		,pcParcela1CronogramaSafraVencimento
		,pcParcela2CronogramaSafraVencimento
		,pcParcela3CronogramaSafraVencimento
		,pcParcela4CronogramaSafraVencimento
		,pcParcela5CronogramaSafraVencimento
		,pcParcela6CronogramaSafraVencimento
		,dtParcela1CronogramaSafraVencimento
		,dtParcela2CronogramaSafraVencimento
		,dtParcela3CronogramaSafraVencimento
		,dtParcela4CronogramaSafraVencimento
		,dtParcela5CronogramaSafraVencimento
		,dtParcela6CronogramaSafraVencimento		

	FROM
		CronogramaSafraVencimento (nolock)
	WHERE 
		cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ
 
 
/*
-----------------------------------------------
Método C#
 
Parâmetros:
Int64 cdCronogramaSafraVencimentoSEQ
 
Corpo:
loSqlCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
loSqlCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;
*/
