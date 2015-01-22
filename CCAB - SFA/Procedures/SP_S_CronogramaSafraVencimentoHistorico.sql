set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_CronogramaSafraVencimentoHistorico.sql
**		Name: SP_S_CronogramaSafraVencimentoHistorico
**		Desc: Obtem um de registro da tabela CronogramaSafraVencimentoHistorico
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_CronogramaSafraVencimentoHistorico]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_CronogramaSafraVencimentoHistorico]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_CronogramaSafraVencimentoHistorico]
	 @cdCronogramaSafraVencimentoHistoricoSEQ	BIGINT
 
AS
 
	--seleção
	SELECT
		 HIS.cdCronogramaSafraVencimentoHistoricoSEQ
		,HIS.cdCronogramaSafraVencimentoSEQ
		,HIS.cdCronogramaSafraSEQ
		,HIS.cdTipoCronogramaSafraVencimento
		,HIS.dtCronogramaSafraVencimento
		,HIS.pcCorrecaoPrecoTipoCulturaVencimento
		,HIS.pcDescontoPontualidade
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
		cdCronogramaSafraVencimentoHistoricoSEQ = @cdCronogramaSafraVencimentoHistoricoSEQ
