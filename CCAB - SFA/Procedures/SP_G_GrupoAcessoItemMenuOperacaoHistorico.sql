set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_G_GrupoAcessoItemMenuOperacaoHistorico.sql
**		Name: SP_G_GrupoAcessoItemMenuOperacaoHistorico
**		Desc: Obtem uma lista de registros da tabela GrupoAcessoItemMenuOperacaoHistorico
**
**		Auth: Convergence
**		Date: 18/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_GrupoAcessoItemMenuOperacaoHistorico]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_GrupoAcessoItemMenuOperacaoHistorico]
END
GO
 
CREATE PROCEDURE [dbo].[SP_G_GrupoAcessoItemMenuOperacaoHistorico]
	 @cdGrupoAcessoSEQ	BIGINT
 
AS
 
	--seleção
	SELECT
		 HIS.cdGrupoAcessoItemMenuOperacaoHistoricoSEQ
		,HIS.cdGrupoAcessoSEQ
		,HIS.cdItemMenuSEQ
		,HIS.cdIndicadorTipoMenuOperacao
		,HIS.cdIndicadorStatusGrupoAcessoItemMenuOperacao
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
		GrupoAcessoItemMenuOperacaoHistorico	HIS		(nolock)	

	WHERE 
		cdGrupoAcessoSEQ = @cdGrupoAcessoSEQ
