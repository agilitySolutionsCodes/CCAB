set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_G_PedidoVendaItemCultura_Geral.sql
**		Name: SP_G_PedidoVendaItemCultura_Geral
**		Desc: Obtem o tabelão dos Itens do Pedido
**
**		Auth: Convergence
**		Date: 2/4/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_PedidoVendaItemCultura_Geral]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_PedidoVendaItemCultura_Geral]
END
GO
 

CREATE PROCEDURE [dbo].[SP_G_PedidoVendaItemCultura_Geral]
	@tmpPedidoVendaSEQ	bigint
 
AS

	set nocount on 

	CREATE TABLE #Tabela
	(
		 [CDProduto]	bigint
		,[VALTOTAL]		varchar(max)
		,[DSProduto]	varchar(max)
		,[VALUEATOTAL]	varchar(max)
	) ON [PRIMARY]
	

	CREATE TABLE #TabelaAnoMes
	(
		 [dtAnoMes]		datetime
		,[dsAnoMes]		varchar(max)
	) ON [PRIMARY]


	declare
		 @cdCronogramaSafraVencimentoSEQ		bigint
		,@dtCronogramaSafraVencimento			datetime
		,@dsTipoCronogramaSafraVencimento		varchar(100)

		,@cdProdutoSEQ							bigint
		,@dsProduto								varchar(70)

		,@lsComando								varchar(max)
		,@lsComandoCampos						varchar(max)
		,@lsComandoValores						varchar(max)
		,@lsNomeCampoQtPedido					varchar(max)
		,@lsNomeCampoQtAberto					varchar(max)
		,@lsNomeCampoValor						varchar(max)

		,@lsNomeCampoChave						varchar(max)
		,@lsNomeCampoChaveQtAberto				varchar(max)
		,@lsNomeCampoChaveValor					varchar(max)

		,@cdChaveVirtual						varchar(max)
		,@ctContadorCampos						int
	
		,@lsCampos								varchar(max)
		,@lsValues								varchar(max)

		,@ctContador							int

		,@vrUnitarioMoedaCompromissoCompraItem	numeric(22,4)
		,@cdCronogramaSafraSEQ					bigint
		,@cdCompromissoCompraSEQ				bigint
		
		,@tmpPedidoVendaItemCulturaSEQ				bigint
		,@cdPedidoVendaItemCulturaSEQ			bigint
		,@qtPedidoVendaItemCultura				numeric(22,4)
		,@qtAbertoPedidoVendaItemEntrega		numeric(22,4)

		,@qtAcumulada							numeric(22,4)
		,@vlAcumulado							numeric(22,4)
		,@qtPedidoVendaItem						numeric(22,4)

		,@dtDataInicial							datetime
		,@dtDataFinal							datetime
		,@dtDataLoop							datetime

		,@cdTipoCulturaSEQ						bigint
		,@dsTipoCultura							varchar(30)
		
		,@cdIndicadorKit							int		

	select
		 @ctContadorCampos					= 1
		,@lsCampos							= ''
		,@lsValues							= ''
		

	--Obtenho os dados do Pedido
	select
		 @cdCronogramaSafraSEQ		= cdCronogramaSafraSEQ
		,@cdCompromissoCompraSEQ	= cdCompromissoCompraSEQ
	from
		dbo.tmpPedidoVenda
	where 
		tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ

	--Criação das Colunas
	DECLARE Cursor_Vencimentos CURSOR FOR 
		select
			 cdTipoCulturaSEQ
			,dsTipoCultura
		from
			dbo.TipoCultura
		where 
			cdIndicadorStatusTipoCultura = 1 -- 1-Ativo
		order by nuOrdemApresentacaoTipoCultura

	OPEN Cursor_Vencimentos

	FETCH NEXT FROM Cursor_Vencimentos 
	INTO 
		 @cdTipoCulturaSEQ
		,@dsTipoCultura


	WHILE @@FETCH_STATUS = 0
	BEGIN

		select
			@lsComando = 'ALTER TABLE #Tabela ADD [KEYD' + Convert(varchar, @ctContadorCampos) + '] varchar(max)'
		exec(@lsComando)

		select
			@lsComando = 'ALTER TABLE #Tabela ADD [VALUED' + Convert(varchar, @ctContadorCampos) + '] varchar(max)'
		exec(@lsComando)


		--CAMPOS

		select
			 @lsCampos = @lsCampos + ',[KEYD' + Convert(varchar, @ctContadorCampos) + ']'
			,@lsCampos = @lsCampos + ',[VALUED' + Convert(varchar, @ctContadorCampos) + ']'



		--VALUES
		select
			@lsValues = @lsValues + ','''','


		select
			@lsValues = @lsValues + '''' + @dsTipoCultura + ' %' + ''


		select
			@lsValues = @lsValues + ''''


		select
			 @ctContadorCampos = @ctContadorCampos + 1


		FETCH NEXT FROM Cursor_Vencimentos 
		INTO 
			 @cdTipoCulturaSEQ
			,@dsTipoCultura

	END 
	CLOSE Cursor_Vencimentos
	DEALLOCATE Cursor_Vencimentos


	--Crio as colunas de Totais
	select
		@lsComando = 'ALTER TABLE #Tabela ADD [VALUEAPLANEJADA] varchar(max)'
	exec(@lsComando)
	
	-- Cria a linha com a identificação dos produtos que pertencem a um KIT
	select
		@lsComando = 'ALTER TABLE #Tabela ADD [KIT] int null'
	exec(@lsComando)

	--Insiro na primeira linha
	select
		 @lsComando = 'insert into #Tabela ('
		,@lsComando = @lsComando + '[CDProduto]'
		,@lsComando = @lsComando + ',[VALUEATOTAL]'
		,@lsComando = @lsComando + ',[VALTOTAL]'
		,@lsComando = @lsComando + ',[DSProduto]'
		,@lsComando = @lsComando + @lsCampos
		,@lsComando = @lsComando + ',[VALUEAPLANEJADA]'
		,@lsComando = @lsComando + ') VALUES ('
		,@lsComando = @lsComando + '''''' 
		,@lsComando = @lsComando + ',' + '''' + 'Quantidade Total' + ''''
		,@lsComando = @lsComando + ',' + '''''' 
		,@lsComando = @lsComando + ',' + '''' + 'Produto' + ''''
		,@lsComando = @lsComando + @lsValues
		,@lsComando = @lsComando + ',' + '''Percentual Planejado''' 
		,@lsComando = @lsComando + ')'


	exec (@lsComando)

	-- Exclui da Tabela de Itens entrega os produtos que estão zerados
	delete from tmppedidovendaitemcultura
	where tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
	and	cdProdutoSEQ not in (
							select
								cdProdutoSEQ
							from
								dbo.tmpPedidoVendaItem
							where
								tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
							and	qtPedidoVendaItem <> 0
							)

	--Populando a tabela
	DECLARE Cursor_Produtos CURSOR FOR 
		select 
			 PRO.cdProdutoSEQ
			,PRO.dsProduto
		from
			dbo.Produto					PRO
		where
			PRO.cdProdutoSEQ IN	(
								select
									cdProdutoSEQ
								from
									dbo.tmpPedidoVendaItem
								where
									tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
								and	qtPedidoVendaItem <> 0
								)
		order by
			-- PRO.cdGrupoProdutoSEQ, PRO.dsProduto
			PRO.dsProduto

	-- Inicializa os valores 
	set @qtAcumulada = 0
	set @vlAcumulado = 0

	OPEN Cursor_Produtos

	FETCH NEXT FROM Cursor_Produtos 
	INTO 
		 @cdProdutoSEQ
		,@dsProduto

	WHILE @@FETCH_STATUS = 0
	BEGIN

		select
			 @lsComandoCampos						= ''
			,@lsComandoValores						= ''
			
		select
			@ctContadorCampos = 1
			
		-- Verifica se o Produto faz parte de um Kit
		SET @cdIndicadorKit = 0 -- não faz parte de KIT
		IF EXISTS (select 1 from ProdutoKit where cdProdutoFilho = @cdProdutoSEQ and cdIndicadorStatusProdutoKit = 1)
		BEGIN
			SET @cdIndicadorKit = 1 -- inibe a linha de Produto
		END
			
		DECLARE Cursor_Vencimentos CURSOR FOR 
			select
				 cdTipoCulturaSEQ
				,dsTipoCultura
			from
				dbo.TipoCultura	
			where
				cdIndicadorStatusTipoCultura = 1 -- 1-Ativo
			order by
				nuOrdemApresentacaoTipoCultura
			
		OPEN Cursor_Vencimentos

		FETCH NEXT FROM Cursor_Vencimentos 
		INTO 
			 @cdTipoCulturaSEQ
			,@dsTipoCultura


		WHILE @@FETCH_STATUS = 0
		BEGIN

			--Obtenho as Quantidades de cultura, se houver
			select
				 @tmpPedidoVendaItemCulturaSEQ		= 0
				,@qtPedidoVendaItemCultura			= 0
				,@qtAbertoPedidoVendaItemEntrega	= 0


			select
				 @tmpPedidoVendaItemCulturaSEQ  	= tmpPedidoVendaItemCulturaSEQ
				,@qtPedidoVendaItemCultura			= qtPedidoVendaItemCultura	
				,@qtAbertoPedidoVendaItemEntrega	= 0
			from
				dbo.tmpPedidoVendaItemCultura
			where
				tmpPedidoVendaSEQ			= @tmpPedidoVendaSEQ			
			and	cdProdutoSEQ				= @cdProdutoSEQ
			and	cdTipoCulturaSEQ			= @cdTipoCulturaSEQ 
			
			set  @vlAcumulado = @vlAcumulado + @qtPedidoVendaItemCultura


			select
				 @lsNomeCampoChave = 'KEYD' + convert(varchar, @ctContadorCampos)
				,@lsNomeCampoQtPedido = 'VALUED' + convert(varchar, @ctContadorCampos)

				

			select
				 @cdChaveVirtual = convert(varchar, @tmpPedidoVendaItemCulturaSEQ) + '-'
				,@cdChaveVirtual = @cdChaveVirtual + convert(varchar, @tmpPedidoVendaSEQ) + '-'
				,@cdChaveVirtual = @cdChaveVirtual + convert(varchar, @cdProdutoSEQ) + '-'
				,@cdChaveVirtual = @cdChaveVirtual + convert(varchar, @cdCronogramaSafraSEQ) + '-'
				,@cdChaveVirtual = @cdChaveVirtual + convert(varchar, @cdTipoCulturaSEQ)


				select
					 @ctContadorCampos = @ctContadorCampos + 1


			--Monto o comando
			select
				 @lsComandoCampos	= @lsComandoCampos + ',[' + @lsNomeCampoQtPedido + ']'
				,@lsComandoCampos	= @lsComandoCampos + ',[' + @lsNomeCampoChave + ']'

			select
				 @lsComandoValores	= @lsComandoValores + ',''' + dbo.FN_FormatarValor(@qtPedidoVendaItemCultura, 1) + ''' '
				,@lsComandoValores	= @lsComandoValores + ',''' + @cdChaveVirtual + ''' '

			FETCH NEXT FROM Cursor_Vencimentos 
			INTO
				 @cdTipoCulturaSEQ
				,@dsTipoCultura

		END 
		CLOSE Cursor_Vencimentos
		DEALLOCATE Cursor_Vencimentos
		
		-- Busca a Quantidade Total para compor o percentual
		set @qtAcumulada = 0
		select
				 @qtAcumulada = sum(qtPedidoVendaItem)
			from
				dbo.tmpPedidoVendaItem
			where
				tmpPedidoVendaSEQ			= @tmpPedidoVendaSEQ			
			and	cdProdutoSEQ				= @cdProdutoSEQ
		
		if @qtAcumulada is null
		begin
			set @qtAcumulada = 0
		end
		
		set @vlacumulado = 0
		select
			@vlacumulado = sum(qtPedidoVendaItemCultura)
		from
			dbo.tmpPedidoVendaItemCultura
		where
			tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
		and cdProdutoSEQ = @cdProdutoSEQ
		
		if @vlacumulado is null
		begin
			set @vlacumulado = 0
		end		
			
		select
			 @lsComando = 'insert into #Tabela ('
			,@lsComando = @lsComando + '[CDProduto]'
			,@lsComando = @lsComando + ',[VALUEATOTAL]'
			,@lsComando = @lsComando + ',[VALTOTAL]'
			,@lsComando = @lsComando + ',[DSProduto]'
			,@lsComando = @lsComando + @lsComandoCampos 
			,@lsComando = @lsComando + ',[VALUEAPLANEJADA]'
			,@lsComando = @lsComando + ',[KIT]) values ('			
			,@lsComando = @lsComando + '''' + convert(varchar, @cdProdutoSEQ) + ''''
			,@lsComando = @lsComando + ',''' + dbo.FN_FormatarValor(@qtAcumulada, 1) + ''''
			,@lsComando = @lsComando + ',''' + dbo.FN_FormatarValor(0, 1) + ''''
			,@lsComando = @lsComando + ',''' + @dsProduto + ''''
			,@lsComando = @lsComando + @lsComandoValores 
			,@lsComando = @lsComando + ',''' + dbo.FN_FormatarValor(@vlacumulado,2) +  ''''
			,@lsComando = @lsComando + ',''' + LTRIM(@cdIndicadorKit) + '''' 			
			,@lsComando = @lsComando + ')'
			

		exec (@lsComando)

		FETCH NEXT FROM Cursor_Produtos 
		INTO 
			 @cdProdutoSEQ
			,@dsProduto

	END 
	CLOSE Cursor_Produtos
	DEALLOCATE Cursor_Produtos


	--Se houver apenas o cabeçalho, apagar tudo
	select
		@ctContador = count(*) 
	from 
		#Tabela

	if @ctContador = 1
	begin
		delete from #Tabela
	end

	select * from #Tabela

	drop TABLE #Tabela
	drop TABLE #TabelaAnoMes

	set nocount off