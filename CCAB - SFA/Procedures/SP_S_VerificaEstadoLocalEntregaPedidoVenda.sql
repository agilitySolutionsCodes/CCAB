

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_VerificaEstadoLocalEntregaPedidoVenda.sql
**		Name: SP_S_VerificaEstadoLocalEntregaPedidoVenda
**		Desc: Verifica Disponibilidade para cadastro de ColunaPreco
**
**		Auth: Convergence
**		Date: 10/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_VerificaEstadoLocalEntregaPedidoVenda]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_VerificaEstadoLocalEntregaPedidoVenda]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_VerificaEstadoLocalEntregaPedidoVenda]
	  @cdClienteFaturamentoPedidoVenda BIGINT
	 ,@cdClienteEntregaPedidoVenda bigint
  
AS

	declare @cdSiglaEstadoEnderecoPrincipalPessoa varchar(05)
	declare @cdSiglaEstadoEnderecoEntregaPessoa varchar(05)

	set @cdSiglaEstadoEnderecoPrincipalPessoa = ''
	set @cdSiglaEstadoEnderecoEntregaPessoa = ''

	-- Busca Estado do Endereco Principal do Cliente Faturamento
	select	@cdSiglaEstadoEnderecoPrincipalPessoa = cdSiglaEstadoEnderecoPrincipalPessoa
	from	Pessoa
	Where	cdPessoaSEQ = @cdClienteFaturamentoPedidoVenda
	
	-- Busca Estado do Endereco de entrega do Cliente Entrega
	select	@cdSiglaEstadoEnderecoEntregaPessoa = cdSiglaEstadoEnderecoEntregaPessoa
	from	Pessoa
	Where	cdPessoaSEQ = @cdClienteEntregaPedidoVenda
	
	IF @cdSiglaEstadoEnderecoPrincipalPessoa <> @cdSiglaEstadoEnderecoEntregaPessoa
	BEGIN
		SELECT @cdClienteFaturamentoPedidoVenda
	END
	ELSE
	BEGIN
		SELECT cdPessoaSEQ
		from Pessoa where cdPessoaSEQ = -1	
	END
	
	
	