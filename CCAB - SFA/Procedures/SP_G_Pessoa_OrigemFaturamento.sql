set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_Pessoa_OrigemFaturamento
**		Name: SP_G_Pessoa_OrigemFaturamento
**		Desc: Seleciona registros de um Agente (Pedidos)
**
**		Auth: Roberto Chaparro
**		Date: Abr 1 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_Pessoa_OrigemFaturamento]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_Pessoa_OrigemFaturamento]
END
GO

CREATE PROCEDURE [dbo].[SP_G_Pessoa_OrigemFaturamento]
	 @cdIndicadorStatusPessoa	bigint	= null
AS

	if @cdIndicadorStatusPessoa is null or @cdIndicadorStatusPessoa = 0
	begin
	
		select	 cdPessoaSEQ	as cdPessoaOrigemFaturamento
				,ltrim(rtrim(nmPessoa))+'-'+ltrim(rtrim(cdPessoaERP)) as dsPessoaOrigemFaturamento
		from	Pessoa
		Where	cdIndicadorTipoPerfilPessoa in (2) -- Empresa CCAB
		
	end
	else
	begin
	
		select	 cdPessoaSEQ	as cdPessoaOrigemFaturamento
				,ltrim(rtrim(nmPessoa))+'-'+ltrim(rtrim(cdPessoaERP)) as dsPessoaOrigemFaturamento
		from	Pessoa
		Where	cdIndicadorTipoPerfilPessoa in (2) -- Empresa CCAB
		and     cdIndicadorStatusPessoa = @cdIndicadorStatusPessoa
		
	end
		

