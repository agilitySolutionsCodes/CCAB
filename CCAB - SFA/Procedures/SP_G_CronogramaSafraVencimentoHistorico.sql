set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_G_CronogramaSafraVencimentoHistorico.sql
**		Name: SP_G_CronogramaSafraVencimentoHistorico
**		Desc: Obtem uma lista de registros da tabela CronogramaSafraVencimentoHistorico
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CronogramaSafraVencimentoHistorico]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_CronogramaSafraVencimentoHistorico]
END
GO
 
CREATE PROCEDURE [dbo].[SP_G_CronogramaSafraVencimentoHistorico]
	 @cdCronogramaSafraVencimentoSEQ	BIGINT
 
AS
 
	--seleção
	SELECT
		 HIS.cdCronogramaSafraVencimentoHistoricoSEQ
		,HIS.cdCronogramaSafraVencimentoSEQ
		,HIS.cdCronogramaSafraSEQ
		,HIS.cdTipoCronogramaSafraVencimento
		,HIS.dtCronogramaSafraVencimento
		,HIS.pcCorrecaoPrecoTipoCulturaVencimento
		,HIS.wkCronogramaSafraVencimento
		,HIS.cdTipoEventoHistorico
		,HIS.dtOcorrenciaHistorico
		,HIS.cdUsuarioOcorrenciaHistorico

		,(
			CASE cdTipoEventoHistorico 
				WHEN 1 THEN 'Inclusão'
				ELSE 'Alteração'
			END	
		)	as dsTipoEventoHistorico 


		,(
			SELECT 
				USU.dsLoginPessoa
			FROM
				dbo.Pessoa	USU	(nolock)
			WHERE
				USU.cdPessoaSEQ = HIS.cdUsuarioOcorrenciaHistorico
		)	as nmUsuario


	FROM
		CronogramaSafraVencimentoHistorico	HIS		(nolock)	

	WHERE 
		cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ
