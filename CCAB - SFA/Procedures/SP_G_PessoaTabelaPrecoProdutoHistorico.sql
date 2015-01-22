set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_G_PessoaTabelaPrecoProdutoHistorico.sql
**		Name: SP_G_PessoaTabelaPrecoProdutoHistorico
**		Desc: Obtem uma lista de registros da tabela PessoaTabelaPrecoProdutoHistorico
**
**		Auth: Convergence
**		Date: 19/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_PessoaTabelaPrecoProdutoHistorico]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_PessoaTabelaPrecoProdutoHistorico]
END
GO
 
CREATE PROCEDURE [dbo].[SP_G_PessoaTabelaPrecoProdutoHistorico]
	 @cdPessoaTabelaPrecoProdutoSEQ	BIGINT
 
AS
 
	--seleção
	SELECT
		 HIS.cdPessoaTabelaPrecoProdutoHistoricoSEQ
		,HIS.cdPessoaTabelaPrecoProdutoSEQ
		,HIS.cdPessoaSEQ
		,HIS.cdCronogramaSafraSEQ
		,HIS.cdProdutoSEQ
		,HIS.cdTipoCulturaSEQ
		,HIS.cdCronogramaSafraVencimentoSEQ
		,HIS.vrDolarPessoaTabelaPrecoProduto
		,HIS.vrRealPessoaTabelaPrecoProduto
		,HIS.pcDescontoPontualidadePessoaTabelaPrecoProduto
		,HIS.wkPessoaTabelaPrecoProduto
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
		PessoaTabelaPrecoProdutoHistorico	HIS		(nolock)	

	WHERE 
		cdPessoaTabelaPrecoProdutoSEQ = @cdPessoaTabelaPrecoProdutoSEQ
