set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_Pessoa_Pedido_ClienteFaturamento
**		Name: SP_G_Pessoa_Pedido_ClienteFaturamento
**		Desc: Seleciona registros de um Cliente Faturamento (Pedidos)
**
**		Auth: Roberto Chaparro
**		Date: Abr 1 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_Pessoa_Pedido_ClienteFaturamento]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_Pessoa_Pedido_ClienteFaturamento]
END
GO

CREATE PROCEDURE [dbo].[SP_G_Pessoa_Pedido_ClienteFaturamento]
	@cdAgente								bigint

AS
	
	set nocount on
	
	select distinct
		 cdPessoaSEQ
		,nmPessoa + '-' + cdPessoaERP		as nmPessoa
	from
		dbo.Pessoa
	where
		(cdAgenteComercialCooperativaPessoa  = @cdAgente
	or	cdAgenteComercialRCPessoa			= @cdAgente)	
	and	cdIndicadorTipoPerfilPessoa			= 1 -- Cliente
	
	and cdIndicadorStatusPessoa = 1 -- Ativo
	
	order by
		nmPessoa

	set nocount off

