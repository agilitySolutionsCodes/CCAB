/******************************************************************************
**		File: SP_G_PedidoVendaItem_Geral.sql
**		Name: SP_G_PedidoVendaItem_Geral
**		Desc: Obtem o tabelão dos Itens do Pedido
**
**		Auth: Convergence
**		Date: 2/4/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		20.05.2010		Ronaldo Mega			Inclusão Tipo Produto
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_PedidoVendaItem_Geral]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_PedidoVendaItem_Geral]
END
GO
 

CREATE PROCEDURE [dbo].[SP_G_PedidoVendaItem_Geral]
	@tmpPedidoVendaSEQ	bigint,
	@cdTipoProduto		INT		= NULL
 
AS

	set nocount on 

	CREATE TABLE #Tabela
	(
		 [CDProduto]	bigint
		,[VALTOTAL]		varchar(max)
		,[DSProduto]	varchar(max)
		,[FATOR]		varchar(max)
	) ON [PRIMARY]
	

	declare
		 @cdCronogramaSafraVencimentoSEQ		bigint
		,@dtCronogramaSafraVencimento			datetime
		,@dsTipoCronogramaSafraVencimento		varchar(100)

		,@cdProdutoSEQ							bigint
		,@dsProduto								varchar(70)
		,@qtEmbalagemProduto					numeric(22,6)

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
		,@qtCompromissoCompraItem				numeric(22,4)
		,@cdCronogramaSafraSEQ					bigint
		,@cdCompromissoCompraSEQ				bigint
		

		,@cdPedidoVendaItemSEQ					bigint
		,@qtPedidoVendaItem						numeric(22,4)
		,@qtAbertoPedidoVendaItem				numeric(22,4)

		,@qtAcumulada							numeric(22,4)
		,@vlAcumulado							numeric(22,4)
		
		,@cdIndicadorKit							int
		
		,@cdIndicadorTipoTransacao				bigint		

	select
		 @ctContadorCampos					= 1
		,@lsCampos							= ''
		,@lsValues							= ''
		
	-- Verifica o Tipo de Transação (1 - Inclusao, 2 - Alteracao)
	select @cdIndicadorTipoTransacao = cdPedidoVendaSEQ
	from tmpPedidoVenda
	Where tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
	
	IF @cdIndicadorTipoTransacao = 0
	BEGIN
		SET @cdIndicadorTipoTransacao = 1 -- Inclusao
	END
	ELSE
	BEGIN
		SET @cdIndicadorTipoTransacao = 2 -- Alteracao
	END

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
			 cdCronogramaSafraVencimentoSEQ
			,dtCronogramaSafraVencimento
			,(
 				SELECT 
 					wkDominioCodigoReferenciado
 				FROM
 					dbo.CodigoReferenciado
 				WHERE
 					vrDominioCodigoReferenciado = cdTipoCronogramaSafraVencimento
 				AND	dsDominioCodigoReferenciado = 'DMESPINDICADORTIPOVENCIMENTO'
			 )	as dsTipoCronogramaSafraVencimento

		from 
			dbo.CronogramaSafraVencimento
		where
			cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		and	cdCronogramaSafraVencimentoSEQ IN	(
												select
													cdCronogramaSafraVencimentoSEQ
												from
													dbo.CompromissoCompraItem
												where
													qtCompromissoCompraItem <> 0
												and cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ
												)



		order by
			 cdTipoCronogramaSafraVencimento	
			,dtCronogramaSafraVencimento		
		

	OPEN Cursor_Vencimentos

	FETCH NEXT FROM Cursor_Vencimentos 
	INTO 
		 @cdCronogramaSafraVencimentoSEQ
		,@dtCronogramaSafraVencimento
		,@dsTipoCronogramaSafraVencimento


	WHILE @@FETCH_STATUS = 0
	BEGIN

		select
			@lsComando = 'ALTER TABLE #Tabela ADD [KEYD' + Convert(varchar, @ctContadorCampos) + '] varchar(max)'
		exec(@lsComando)

		select
			@lsComando = 'ALTER TABLE #Tabela ADD [VALUED' + Convert(varchar, @ctContadorCampos) + '] varchar(max)'
		exec(@lsComando)

		select
			@lsComando = 'ALTER TABLE #Tabela ADD [KEYA' + Convert(varchar, @ctContadorCampos) + '] varchar(max)'
		exec(@lsComando)

		select
			@lsComando = 'ALTER TABLE #Tabela ADD [VALUEA' + Convert(varchar, @ctContadorCampos) + '] varchar(max)'
		exec(@lsComando)

		select
			@lsComando = 'ALTER TABLE #Tabela ADD [KEYV' + Convert(varchar, @ctContadorCampos) + '] varchar(max)'
		exec(@lsComando)

		select
			@lsComando = 'ALTER TABLE #Tabela ADD [VALUEV' + Convert(varchar, @ctContadorCampos) + '] varchar(max)'
		exec(@lsComando)



		--CAMPOS

		select
			 @lsCampos = @lsCampos + ',[KEYD' + Convert(varchar, @ctContadorCampos) + ']'
			,@lsCampos = @lsCampos + ',[VALUED' + Convert(varchar, @ctContadorCampos) + ']'
			,@lsCampos = @lsCampos + ',[KEYA' + Convert(varchar, @ctContadorCampos) + ']'
			,@lsCampos = @lsCampos + ',[VALUEA' + Convert(varchar, @ctContadorCampos) + ']'
			,@lsCampos = @lsCampos + ',[KEYV' + Convert(varchar, @ctContadorCampos) + ']'
			,@lsCampos = @lsCampos + ',[VALUEV' + Convert(varchar, @ctContadorCampos) + ']'



		--VALUES
		select
			@lsValues = @lsValues + ','''','


		if not @dtCronogramaSafraVencimento is null
		begin
			select
				@lsValues = @lsValues + '''' + Convert(varchar, @dtCronogramaSafraVencimento, 103) + ' Quantidade' + ''''
		end
		else
		begin
			select
				@lsValues = @lsValues + '''' + @dsTipoCronogramaSafraVencimento + ' Quantidade' + ''''
		end

		select
			@lsValues = @lsValues + ','''','

		if not @dtCronogramaSafraVencimento is null
		begin
			select
				@lsValues = @lsValues + '''' + Convert(varchar, @dtCronogramaSafraVencimento, 103) + ' - Qt. Aberto' + ''''
		end
		else
		begin
			select
				@lsValues = @lsValues + '''' + @dsTipoCronogramaSafraVencimento + ' - Qt. Aberto' + ''''
		end


		select
			@lsValues = @lsValues + ','''','''

		select
			@lsValues = @lsValues + ''''


		select
			 @ctContadorCampos = @ctContadorCampos + 1


		FETCH NEXT FROM Cursor_Vencimentos 
		INTO 
			 @cdCronogramaSafraVencimentoSEQ
			,@dtCronogramaSafraVencimento
			,@dsTipoCronogramaSafraVencimento

	END 
	CLOSE Cursor_Vencimentos
	DEALLOCATE Cursor_Vencimentos


	--Crio as linhas de Totais
	select
		@lsComando = 'ALTER TABLE #Tabela ADD [VALUEATOTAL] varchar(max)'
	exec(@lsComando)
	
	-- Cria a linha com a identificação dos produtos que pertencem a um KIT
	select
		@lsComando = 'ALTER TABLE #Tabela ADD [KIT] int null'
	exec(@lsComando)

	--Insiro na primeira linha
	select
		 @lsComando = 'insert into #Tabela ('
		,@lsComando = @lsComando + '[CDProduto]'
		,@lsComando = @lsComando + ',[FATOR]'
		,@lsComando = @lsComando + ',[VALTOTAL]'
		,@lsComando = @lsComando + ',[DSProduto]'
		,@lsComando = @lsComando + @lsCampos
		,@lsComando = @lsComando + ',[VALUEATOTAL]'
		,@lsComando = @lsComando + ') VALUES ('
		,@lsComando = @lsComando + '''''' 
		,@lsComando = @lsComando + ',' + '''' + 'Quantidade Embalagem' + ''''
		,@lsComando = @lsComando + ',' + '''''' 
		,@lsComando = @lsComando + ',' + '''' + 'Produto' + ''''
		,@lsComando = @lsComando + @lsValues
		,@lsComando = @lsComando + ',' + '''Quantidade Total''' 
		,@lsComando = @lsComando + ')'


	exec (@lsComando)
	
	-- Exclui da Tabela os Itens dos produtos que não constam no compromisso de compra
	-- JORGE
	delete from tmppedidovendaitem
	where tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
	and	cdProdutoSEQ not in (
								select distinct
									cdProdutoSEQ
								from
									dbo.CompromissoCompraItem
								where
									cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ
									and qtCompromissoCompraItem <> 0
							)


	--Populando a tabela
	/*
	DECLARE Cursor_Produtos CURSOR FOR 
		select 
			 PRO.cdProdutoSEQ
			,PRO.dsProduto
			,PRO.qtEmbalagemProduto
		from
			dbo.Produto					PRO
		where
			PRO.cdProdutoSEQ IN	(
								select distinct
									cdProdutoSEQ
								from
									dbo.CompromissoCompraItem
								where
									cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ
									and qtCompromissoCompraItem <> 0
								)
		order by
			-- PRO.cdGrupoProdutoSEQ, PRO.dsProduto
			PRO.dsProduto
	*/
		
	DECLARE Cursor_Produtos CURSOR FOR 
		select 
			 PRO.cdProdutoSEQ
			,PRO.dsProduto
			,PRO.qtEmbalagemProduto
		from
			dbo.Produto					PRO
		where
			(PRO.cdTipoProduto = @cdTipoProduto OR @cdTipoProduto IS NULL)
			AND (	(PRO.cdProdutoSEQ IN	(
								select distinct
									cdProdutoSEQ
								from
									dbo.CompromissoCompraItem
								where
									cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ
									and qtCompromissoCompraItem <> 0
										) AND @cdIndicadorTipoTransacao = 2 and (PRO.cdIndicadorLiberadoPedidoProduto = 1
										                                           or PRO.cdProdutoSEQ IN (	select distinct cdProdutoSEQ
										                                                                    from tmpPedidoVendaItem
										                                                                    where tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
										                                                                    and   qtPedidoVendaItem <> 0)))-- Alteracao
			OR
				(PRO.cdProdutoSEQ IN	(
								select distinct
									cdProdutoSEQ
								from
									dbo.CompromissoCompraItem
								where
									cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ
									and qtCompromissoCompraItem <> 0
										) AND @cdIndicadorTipoTransacao = 1 and PRO.cdIndicadorLiberadoPedidoProduto = 1 )	-- Inclusao e Produto liberado		
			)
			
		order by
			-- PRO.cdGrupoProdutoSEQ, PRO.dsProduto
			PRO.dsProduto




	OPEN Cursor_Produtos

	FETCH NEXT FROM Cursor_Produtos 
	INTO 
		 @cdProdutoSEQ
		,@dsProduto
		,@qtEmbalagemProduto


	WHILE @@FETCH_STATUS = 0
	BEGIN

		select
			 @lsComandoCampos						= ''
			,@lsComandoValores						= ''
			,@vrUnitarioMoedaCompromissoCompraItem	= 0
			,@qtCompromissoCompraItem				= 0
			,@qtAcumulada							= 0
			,@vlAcumulado							= 0

		-- Verifica se o Produto faz parte de um Kit
		SET @cdIndicadorKit = 0 -- não faz parte de KIT
		IF EXISTS (select 1 from ProdutoKit where cdProdutoFilho = @cdProdutoSEQ and cdIndicadorStatusProdutoKit = 1)
		BEGIN
			SET @cdIndicadorKit = 1 -- inibe a linha de Produto
		END

		select
			@ctContadorCampos = 1

		DECLARE Cursor_Vencimentos CURSOR FOR 
			select
				 cdCronogramaSafraVencimentoSEQ
				,dtCronogramaSafraVencimento
				,(
 					SELECT 
 						wkDominioCodigoReferenciado
 					FROM
 						dbo.CodigoReferenciado
 					WHERE
 						vrDominioCodigoReferenciado = cdTipoCronogramaSafraVencimento
 					AND	dsDominioCodigoReferenciado = 'DMESPINDICADORTIPOVENCIMENTO'
				 )	as dsTipoCronogramaSafraVencimento

			from 
				dbo.CronogramaSafraVencimento
			where
				cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
			and	cdCronogramaSafraVencimentoSEQ IN	(
													select
														cdCronogramaSafraVencimentoSEQ
													from
														dbo.CompromissoCompraItem
													where
														qtCompromissoCompraItem <> 0
													and cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ
													)
			order by
				 cdTipoCronogramaSafraVencimento	
				,dtCronogramaSafraVencimento		
				
			

		OPEN Cursor_Vencimentos

		FETCH NEXT FROM Cursor_Vencimentos 
		INTO 
			 @cdCronogramaSafraVencimentoSEQ
			,@dtCronogramaSafraVencimento
			,@dsTipoCronogramaSafraVencimento


		WHILE @@FETCH_STATUS = 0
		BEGIN

			--Obtenho o Valor Unitário
			set @vrUnitarioMoedaCompromissoCompraItem = 0
			set @qtCompromissoCompraItem = 0
			select
				@vrUnitarioMoedaCompromissoCompraItem = CCI.vrUnitarioMoedaCompromissoCompraItem,
				@qtCompromissoCompraItem = qtCompromissoCompraItem
			from
				dbo.CompromissoCompraItem	CCI
			where
				CCI.cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ
			and	CCI.cdProdutoSEQ = @cdProdutoSEQ
			and CCI.cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ

			--Obtenho as Quantidades, se houver
			select
				 @cdPedidoVendaItemSEQ		= 0
				,@qtPedidoVendaItem			= 0
				,@qtAbertoPedidoVendaItem	= 0


			select
				 @cdPedidoVendaItemSEQ		= tmpPedidoVendaItemSEQ
				,@qtPedidoVendaItem			= qtPedidoVendaItem	
				,@qtAbertoPedidoVendaItem	= qtAbertoPedidoVendaItem
			from
				dbo.tmpPedidoVendaItem
			where
				tmpPedidoVendaSEQ			= @tmpPedidoVendaSEQ			
			and
				cdProdutoSEQ				= @cdProdutoSEQ
			and
				cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ 

			select
				 @qtAcumulada = @qtAcumulada + @qtPedidoVendaItem
				,@vlAcumulado = @qtAcumulada + (@qtPedidoVendaItem * @vrUnitarioMoedaCompromissoCompraItem)

			-- Verifica se a quantidade/preco foi encontrado
			IF @qtCompromissoCompraItem = 0
			BEGIN
				-- Atribui o valor -1 para inibir a coluna/linha na digitação
				set @qtPedidoVendaItem = -1
			END

			select
				 @lsNomeCampoChave = 'KEYD' + convert(varchar, @ctContadorCampos)
				,@lsNomeCampoQtPedido = 'VALUED' + convert(varchar, @ctContadorCampos)
				,@lsNomeCampoChaveQtAberto = 'KEYA' + convert(varchar, @ctContadorCampos)
				,@lsNomeCampoQtAberto = 'VALUEA' + convert(varchar, @ctContadorCampos)
				,@lsNomeCampoChaveValor = 'KEYV' + convert(varchar, @ctContadorCampos)
				,@lsNomeCampoValor = 'VALUEV' + convert(varchar, @ctContadorCampos)
				

			select
				 @cdChaveVirtual = convert(varchar, @cdPedidoVendaItemSEQ) + '-'
				,@cdChaveVirtual = @cdChaveVirtual + convert(varchar, @tmpPedidoVendaSEQ) + '-'
				,@cdChaveVirtual = @cdChaveVirtual + convert(varchar, @cdProdutoSEQ) + '-'
				,@cdChaveVirtual = @cdChaveVirtual + convert(varchar, @cdCronogramaSafraSEQ) + '-'
				,@cdChaveVirtual = @cdChaveVirtual + convert(varchar, @cdCronogramaSafraVencimentoSEQ) 


				select
					 @ctContadorCampos = @ctContadorCampos + 1


			--Monto o comando
			select
				 @lsComandoCampos	= @lsComandoCampos + ',[' + @lsNomeCampoQtPedido + ']'
				,@lsComandoCampos	= @lsComandoCampos + ',[' + @lsNomeCampoQtAberto + ']'
				,@lsComandoCampos	= @lsComandoCampos + ',[' + @lsNomeCampoValor + ']'
				,@lsComandoCampos	= @lsComandoCampos + ',[' + @lsNomeCampoChave + ']'
				,@lsComandoCampos	= @lsComandoCampos + ',[' + @lsNomeCampoChaveQtAberto + ']'
				,@lsComandoCampos	= @lsComandoCampos + ',[' + @lsNomeCampoChaveValor + ']'


			select
				 @lsComandoValores	= @lsComandoValores + ',''' + dbo.FN_FormatarValor(@qtPedidoVendaItem, 1) + ''' '
				,@lsComandoValores	= @lsComandoValores + ',''' + dbo.FN_FormatarValor(@qtAbertoPedidoVendaItem, 1) + ''' '
				,@lsComandoValores	= @lsComandoValores + ',''' + dbo.FN_FormatarValor(@vrUnitarioMoedaCompromissoCompraItem, 2) + ''' '
				,@lsComandoValores	= @lsComandoValores + ',''' + 'X-' + @cdChaveVirtual + ''' '
				,@lsComandoValores	= @lsComandoValores + ',''' + 'Y-' + @cdChaveVirtual + ''' '
				,@lsComandoValores	= @lsComandoValores + ',''' + 'Y-' + @cdChaveVirtual + ''' '
				


			FETCH NEXT FROM Cursor_Vencimentos 
			INTO 
				 @cdCronogramaSafraVencimentoSEQ
				,@dtCronogramaSafraVencimento
				,@dsTipoCronogramaSafraVencimento

		END 
		CLOSE Cursor_Vencimentos
		DEALLOCATE Cursor_Vencimentos



		select
			 @lsComando = 'insert into #Tabela ('
			,@lsComando = @lsComando + '[CDProduto]'
			,@lsComando = @lsComando + ',[FATOR]'
			,@lsComando = @lsComando + ',[VALTOTAL]'
			,@lsComando = @lsComando + ',[DSProduto]'
			,@lsComando = @lsComando + @lsComandoCampos 
			,@lsComando = @lsComando + ',[VALUEATOTAL]'
			,@lsComando = @lsComando + ',[KIT]) values ('
			,@lsComando = @lsComando + '''' + convert(varchar, @cdProdutoSEQ) + ''''
			,@lsComando = @lsComando + ',''' + dbo.FN_FormatarValor(@qtEmbalagemProduto, 1) + ''''
			,@lsComando = @lsComando + ',''' + dbo.FN_FormatarValor(@vlAcumulado, 2) + ''''
			,@lsComando = @lsComando + ',''' + @dsProduto + ''''
			,@lsComando = @lsComando + @lsComandoValores 
			,@lsComando = @lsComando + ',''' + dbo.FN_FormatarValor(@qtAcumulada, 1) +  ''''
			,@lsComando = @lsComando + ',''' + LTRIM(@cdIndicadorKit) + '''' 
			,@lsComando = @lsComando + ')'

		exec (@lsComando)

		FETCH NEXT FROM Cursor_Produtos 
		INTO 
			 @cdProdutoSEQ
			,@dsProduto
			,@qtEmbalagemProduto

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
	set nocount off