set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_Pessoa_OnDemand
**		Name: SP_G_Pessoa_OnDemand
**		Desc: Seleciona os registros na tabela PessoaContato pelo componente On Demand
**
**		Auth: Roberto Chaparro
**		Date: Mar 12 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_Pessoa_OnDemand]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_Pessoa_OnDemand]
END
GO

CREATE PROCEDURE [dbo].[SP_G_Pessoa_OnDemand]
	 @dsFiltro						varchar(70)
	,@cdIndicadorTipoPessoaPerfil	int				= null
AS



	SET ROWCOUNT 100

	IF NOT @cdIndicadorTipoPessoaPerfil is null
	BEGIN
		SELECT
			cdPessoaSEQ
			,ltrim(rtrim(nmRazaoSocialPessoaJuridica))
			+ ' - '
			+ convert(varchar, nuCNPJPessoaJuridica)
			as dsPessoa
			,nmRazaoSocialPessoaJuridica	as nmPessoa
			,nuCNPJPessoaJuridica			as nmDocumento
		FROM
			dbo.PessoaJuridica	PES
		WHERE
			rtrim(ltrim(nmRazaoSocialPessoaJuridica)) + ' - ' + convert(varchar, nuCNPJPessoaJuridica) like + '%' + @dsFiltro + '%'
		AND	EXISTS	( 
				SELECT 
					cdPessoaSEQ 
				FROM 
					dbo.PessoaPerfil 
				WHERE 
				cdPessoaSEQ = PES.cdPessoaSEQ 
				AND	 cdIndicadorTipoPessoaPerfil = @cdIndicadorTipoPessoaPerfil
					) 

		UNION

		SELECT
			cdPessoaSEQ
			,ltrim(rtrim(nmPessoaFisica))
			+ ' - '
			+ convert(varchar, nuCPFPessoaFisica)
			as dsPessoa
			,nmPessoaFisica		as nmPessoa
			,nuCPFPessoaFisica	as nmDocumento
		FROM
			dbo.PessoaFisica	PES
		WHERE
			rtrim(ltrim(nmPessoaFisica)) + ' - ' + convert(varchar, nuCPFPessoaFisica) like + '%' + @dsFiltro + '%'
		AND	EXISTS	( 
				SELECT 
					cdPessoaSEQ 
				FROM 
					dbo.PessoaPerfil 
				WHERE 
				cdPessoaSEQ = PES.cdPessoaSEQ 
				AND	 cdIndicadorTipoPessoaPerfil = @cdIndicadorTipoPessoaPerfil
					) 

		ORDER BY
			 nmPessoa
			,nmDocumento
	END
	ELSE
	BEGIN
		SELECT
			cdPessoaSEQ
			,ltrim(rtrim(nmRazaoSocialPessoaJuridica))
			+ ' - '
			+ convert(varchar, nuCNPJPessoaJuridica)
			as dsPessoa
			,nmRazaoSocialPessoaJuridica	as nmPessoa
			,nuCNPJPessoaJuridica			as nmDocumento
		FROM
			dbo.PessoaJuridica	PES
		WHERE
			rtrim(ltrim(nmRazaoSocialPessoaJuridica)) + ' - ' + convert(varchar, nuCNPJPessoaJuridica) like + '%' + @dsFiltro + '%'

		UNION

		SELECT
			cdPessoaSEQ
			,ltrim(rtrim(nmPessoaFisica))
			+ ' - '
			+ convert(varchar, nuCPFPessoaFisica)
			as dsPessoa
			,nmPessoaFisica		as nmPessoa
			,nuCPFPessoaFisica	as nmDocumento
		FROM
			dbo.PessoaFisica	PES
		WHERE
			rtrim(ltrim(nmPessoaFisica)) + ' - ' + convert(varchar, nuCPFPessoaFisica) like + '%' + @dsFiltro + '%'

		ORDER BY
			 nmPessoa
			,nmDocumento
	END




SET QUOTED_IDENTIFIER OFF

