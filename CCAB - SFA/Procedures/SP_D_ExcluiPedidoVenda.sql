set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_D_ExcluiPedidoVenda
**		Name: SP_D_ExcluiPedidoVenda
**		Desc: Efetua a Exclusao do Pedido de Venda
**
**		Auth: Roberto Chaparro
**		Date: Jan 14 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_D_ExcluiPedidoVenda]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_D_ExcluiPedidoVenda]
END
GO	

CREATE PROCEDURE [dbo].[SP_D_ExcluiPedidoVenda]
	 @arPedidoVenda			varchar(max)
	,@cdUsuarioUltimaAlteracao		bigint

AS


DECLARE 
	 @DELIMITADOR	VARCHAR(100)
	,@S				VARCHAR(8000)
	,@cdAgenteComercialCooperativaPedidoVenda bigint
	,@cdSolicitacaoEnvioEmailSEQ	bigint
	
	SELECT 
		@DELIMITADOR = ','

	IF LEN(@arPedidoVenda) > 0
	BEGIN
		SELECT
			@arPedidoVenda = @arPedidoVenda + @DELIMITADOR 
	END

	CREATE TABLE 
		#ARRAY
	(ITEM_ARRAY	VARCHAR(max))

	WHILE LEN(@arPedidoVenda) > 0
	BEGIN
		SELECT 
			@S = LTRIM(SUBSTRING(@arPedidoVenda, 1, CHARINDEX(@DELIMITADOR, @arPedidoVenda) - 1))
	   
		INSERT INTO 
			#ARRAY 
			(ITEM_ARRAY) 
		VALUES 
			(@S)
		
		-- Busca o codigo da Cooperativa	
		select	@cdAgenteComercialCooperativaPedidoVenda = cdAgenteComercialCooperativaPedidoVenda
		from	PedidoVenda
		Where	cdPedidoVendaSEQ = @S			
			
		--Envio de Email para a Cooperativa avisando da Exclusão do Pedido
		IF @cdUsuarioUltimaAlteracao not in (	select	cdPessoaSEQ
												from	Pessoa	
												Where	cdPessoaSEQ = @cdAgenteComercialCooperativaPedidoVenda
												union
												select  cdPessoaSEQ
												from	Pessoa
												where	cdEmpresaColaboradorPessoa = @cdAgenteComercialCooperativaPedidoVenda
												and     cdIndicadorTipoPerfilPessoa = 4)		-- Perfil Colaborador Agente
		BEGIN
	
			EXEC SP_I_SolicitacaoEnvioEmail_ExclusaoPedido
				 @cdPedidoVendaSEQ						= @S
				,@cdUsuarioUltimaAlteracao				= @cdUsuarioUltimaAlteracao
				,@cdSolicitacaoEnvioEmailSEQ			= @cdSolicitacaoEnvioEmailSEQ
			
		END

		SELECT 
			@arPedidoVenda = SUBSTRING(@arPedidoVenda, CHARINDEX(@DELIMITADOR, @arPedidoVenda) + 1, LEN(@arPedidoVenda))
	END

	-- Exclui Compromisso de Compra

	--PedidoVendaItemHistorico
	DELETE	PedidoVendaItemHistorico
	WHERE cdPedidoVendaSEQ in (	select	ITEM_ARRAY from #ARRAY )

	-- PedidoVendaItem
	DELETE	PedidoVendaItem
	WHERE cdPedidoVendaSEQ in (	select	ITEM_ARRAY from #ARRAY )

	-- PedidoVendaItemEntregaHistorico
	DELETE	PedidoVendaItemEntregaHistorico
	WHERE cdPedidoVendaSEQ in (	select	ITEM_ARRAY from #ARRAY )
	
	-- PedidoVendaItemEntrega
	DELETE	PedidoVendaItemEntrega
	WHERE cdPedidoVendaSEQ in (	select	ITEM_ARRAY from #ARRAY )
	
	-- PedidoVendaItemCulturaHistorico
	DELETE	PedidoVendaItemCulturaHistorico
	WHERE cdPedidoVendaSEQ in (	select	ITEM_ARRAY from #ARRAY )
	
	-- PedidoVendaItemCultura
	DELETE	PedidoVendaItemCultura
	WHERE cdPedidoVendaSEQ in (	select	ITEM_ARRAY from #ARRAY )

	-- PedidoVendaHistorico	
	DELETE	PedidoVendaHistorico
	WHERE cdPedidoVendaSEQ in (	select	ITEM_ARRAY from #ARRAY )
	
	-- PedidoVenda
	DELETE	PedidoVenda
	WHERE cdPedidoVendaSEQ in (	select	ITEM_ARRAY from #ARRAY )
	AND   cdIndicadorStatusPedidoVenda in (1,4)

	DROP TABLE #ARRAY


SET QUOTED_IDENTIFIER OFF

