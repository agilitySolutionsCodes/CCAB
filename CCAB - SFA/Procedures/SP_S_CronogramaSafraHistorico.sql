set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_CronogramaSafraHistorico.sql
**		Name: SP_S_CronogramaSafraHistorico
**		Desc: Obtem um de registro da tabela CronogramaSafraHistorico
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_CronogramaSafraHistorico]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_CronogramaSafraHistorico]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_CronogramaSafraHistorico]
	 @cdCronogramaSafraHistoricoSEQ	BIGINT
 
AS
 
	--seleção
	SELECT
		 HIS.cdCronogramaSafraHistoricoSEQ
		,HIS.cdCronogramaSafraSEQ
		,HIS.dsCronogramaSafra
		,HIS.dtInicioCronogramaSafra
		,HIS.dtFimCronogramaSafra
		,HIS.dtLimiteLiberacaoCCCronogramaSafra
		,HIS.dtLimiteAprovacaoCCCronogramaSafra
		,HIS.dtLimiteLiberacaoPVCronogramaSafra
		,HIS.dtLimiteAprovacaoPVRCCronogramaSafra
		,HIS.dtLimiteAprovacaoPVACCronogramaSafra
		,HIS.wkCronogramaSafra
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
		CronogramaSafraHistorico	HIS		(nolock)	

	WHERE 
		cdCronogramaSafraHistoricoSEQ = @cdCronogramaSafraHistoricoSEQ
