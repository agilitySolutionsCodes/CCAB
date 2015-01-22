set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_Pessoa_OnDemand_ERP
**		Name: SP_G_Pessoa_OnDemand_ERP
**		Desc: Seleciona os registros na tabela Pessoa pelo componente On Demand (Nome + Código ERP)
**
**		Auth: Roberto Chaparro
**		Date: Mar 16 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_Pessoa_OnDemand_ERP]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_Pessoa_OnDemand_ERP]
END
GO

CREATE PROCEDURE [dbo].[SP_G_Pessoa_OnDemand_ERP]
	 @cdIndicadorTipoPerfilPessoa			int		
	,@cdIndicadorTipoAgenteComercialPessoa	int		
AS


	if @cdIndicadorTipoAgenteComercialPessoa = 0
	begin
		SELECT
			cdPessoaSEQ
			,ltrim(rtrim(nmPessoa))
			+ ' - '
			+ isnull(convert(varchar, cdPessoaERP), '')



			as dsPessoa
			,nmPessoa + ' - ' isnull(convert(varchar, cdPessoaERP), '') as nmPessoa
			,isnull(cdPessoaERP, '')		as cdPessoaERP
		FROM
			dbo.Pessoa	PES
		WHERE
			cdIndicadorTipoPerfilPessoa				= @cdIndicadorTipoPerfilPessoa

		ORDER BY
			 nmPessoa
			,cdPessoaERP
	end
	else
	begin
		SELECT
			cdPessoaSEQ
			,ltrim(rtrim(nmPessoa))
			+ ' - '
			+ isnull(convert(varchar, cdPessoaERP), '')



			as dsPessoa
			,nmPessoa + ' - ' isnull(convert(varchar, cdPessoaERP), '') as nmPessoa
			,isnull(cdPessoaERP, '')		as cdPessoaERP
		FROM
			dbo.Pessoa	PES
		WHERE
			cdIndicadorTipoPerfilPessoa				= @cdIndicadorTipoPerfilPessoa
		AND	cdIndicadorTipoAgenteComercialPessoa	= @cdIndicadorTipoAgenteComercialPessoa
		
		ORDER BY
			 nmPessoa
			,cdPessoaERP
	end





SET QUOTED_IDENTIFIER OFF

