set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_G_CronogramaSafraVencimento.sql
**		Name: SP_G_CronogramaSafraVencimento
**		Desc: Obtem registros da tabela CronogramaSafraVencimento
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CronogramaSafraVencimento]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_CronogramaSafraVencimento]
END
GO
 
CREATE PROCEDURE [dbo].[SP_G_CronogramaSafraVencimento]
	@cdCronogramaSafraSEQ	bigint

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

		,(
	 		SELECT 
	 			wkDominioCodigoReferenciado
	 		FROM
	 			dbo.CodigoReferenciado
	 		WHERE
	 			vrDominioCodigoReferenciado = cdTipoCronogramaSafraVencimento
	 		AND	dsDominioCodigoReferenciado = 'DMESPINDICADORTIPOVENCIMENTO'
		 )	as dsTipoCronogramaSafraVencimento




	FROM
		CronogramaSafraVencimento (nolock)

	WHERE
		cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
	ORDER BY
		cdTipoCronogramaSafraVencimento desc, dtCronogramaSafraVencimento desc
