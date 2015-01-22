set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_Pessoa_Pedido_ClienteEntrega
**		Name: SP_G_Pessoa_Pedido_ClienteEntrega
**		Desc: Seleciona registros de um Cliente Entrega (Pedidos)
**
**		Auth: Roberto Chaparro
**		Date: Abr 1 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_Pessoa_Pedido_ClienteEntrega]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_Pessoa_Pedido_ClienteEntrega]
END
GO

CREATE PROCEDURE [dbo].[SP_G_Pessoa_Pedido_ClienteEntrega]
	@cdCliente								bigint

AS
	
	set nocount on
	
	declare
		@cdPessoaERP		varchar(30)


	select
		@cdPessoaERP = substring(cdPessoaERP, 1, len(cdPessoaERP) - 2)
	from 
		dbo.Pessoa
	where
		cdPessoaSEQ = @cdCliente



	select distinct
		 cdPessoaSEQ
		,nmPessoa + '-' + cdPessoaERP		as nmPessoa
	from
		dbo.Pessoa
	where
		substring(cdPessoaERP, 1, len(cdPessoaERP) - 2) = @cdPessoaERP
	and	cdIndicadorTipoPerfilPessoa			= 1 -- Cliente
	
	and cdIndicadorStatusPessoa = 1 -- Ativo
	
	order by
		nmPessoa

	set nocount off

