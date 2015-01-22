set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_G_ProdutoTipoCulturaHistorico.sql
**		Name: SP_G_ProdutoTipoCulturaHistorico
**		Desc: Obtem uma lista de registros da tabela ProdutoTipoCulturaHistorico
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_ProdutoTipoCulturaHistorico]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_ProdutoTipoCulturaHistorico]
END
GO
 
CREATE PROCEDURE [dbo].[SP_G_ProdutoTipoCulturaHistorico]
	 @cdProdutoTipoCulturaSEQ	BIGINT
 
AS
 
	--seleção
	SELECT
		 HIS.cdProdutoTipoCulturaHistoricoSEQ
		,HIS.cdProdutoSEQ
		,HIS.cdTipoCulturaSEQ
		,HIS.cdIndicadorStatusProdutoTipoCultura
		,HIS.wkProdutoTipoCultura
		,HIS.dtOcorrenciaHistorico
		,HIS.cdUsuarioOcorrenciaHistorico
		,HIS.cdProdutoTipoCulturaSEQ
		,HIS.cdTipoEventoHistorico

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
		ProdutoTipoCulturaHistorico	HIS		(nolock)	

	WHERE 
		cdProdutoTipoCulturaSEQ = @cdProdutoTipoCulturaSEQ
