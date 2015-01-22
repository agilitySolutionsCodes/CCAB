set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_G_PedidoVendaItemEntrega_Geral.sql
**		Name: SP_G_PedidoVendaItemEntrega_Geral
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
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_PedidoVendaItemEntrega_Geral]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_PedidoVendaItemEntrega_Geral]
END
GO
 

CREATE PROCEDURE [dbo].[SP_G_PedidoVendaItemEntrega_Geral]
	@tmpPedidoVendaSEQ	bigint
 
AS

	set nocount on 

	CREATE TABLE #Tabela
	(
		 [CDProduto]		bigint
		,[VALTOTAL]			varchar(max)
		,[DSProduto]		varchar(max)
		,[FATOR]			varchar(max)
		,[VALUEATOTAL]		varchar(max)		
		,[VALUEAPLANEJADA]	varchar(max)
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
		,@cdCronogramaSafraSEQ					bigint
		,@cdCompromissoCompraSEQ				bigint
		
		,@tmpPedidoVendaItemEntregaSEQ			bigint
		,@cdPedidoVendaItemEntregaSEQ			bigint
		,@qtPedidoVendaItemEntrega				numeric(22,4)
		,@qtAbertoPedidoVendaItemEntrega		numeric(22,4)

		,@qtAcumulada							numeric(22,4)
		,@vlAcumulado							numeric(22,4)
		,@qtAcumuladaPlanejada					numeric(22,4)

		,@dtDataInicial							datetime
		,@dtDataFinal							datetime
		,@dtDataLoop							datetime

		,@dtAnoMes								datetime
		,@dsAnoMes								varchar(max)
		
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

	--Obtenho as datas Inicial e Final
	select
		 @dtDataInicial	= convert(varchar, year(dtInicioCronogramaSafra)) + '/' + convert(varchar, month(dtInicioCronogramaSafra)) + '/01'
		,@dtDataFinal	= convert(varchar, year(dtFimCronogramaSafra)) + '/' + convert(varchar, month(dtFimCronogramaSafra)) + '/01'
	from
		dbo.CronogramaSafra
	where
		cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		

	--Rodo as datas
	select
		@dtDataLoop = @dtDataInicial

	while @dtDataLoop <= @dtDataFinal
	begin

		-- Insiro a primeira quinzena
		insert into #TabelaAnoMes
			([dtAnoMes]
			,[dsAnoMes])
		values
			(@dtDataLoop
			,dbo.FN_RetornarMesExtenso(month(@dtDataLoop)) + '/' + convert(varchar, year(@dtDataLoop)) + '') 


		-- Insiro a segunda quinzena
		-- Desativado conforme orientação do Teixeira (jorge)
		/*
		insert into #TabelaAnoMes
			([dtAnoMes]
			,[dsAnoMes])
		values
			(dateadd(day, 15, @dtDataLoop)
			,dbo.FN_RetornarMesExtenso(month(@dtDataLoop)) + '/' + convert(varchar, year(@dtDataLoop)) + ' - 2° Quinzena') 
		*/

		select
			@dtDataLoop = dateadd(month, 1, @dtDataLoop)


	end


	--Criação das Colunas
	DECLARE Cursor_Vencimentos CURSOR FOR 
		select
			 [dtAnoMes]
			,[dsAnoMes]
		from 
			#TabelaAnoMes	
		

	OPEN Cursor_Vencimentos

	FETCH NEXT FROM Cursor_Vencimentos 
	INTO 
		 @dtAnoMes
		,@dsAnoMes


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
			@lsValues = @lsValues + '''' + @dsAnoMes + ' Quantidade' + ''


		select
			@lsValues = @lsValues + ''''


		select
			 @ctContadorCampos = @ctContadorCampos + 1


		FETCH NEXT FROM Cursor_Vencimentos 
		INTO 
			 @dtAnoMes
			,@dsAnoMes

	END 
	CLOSE Cursor_Vencimentos
	DEALLOCATE Cursor_Vencimentos
	
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
		,@lsComando = @lsComando + ',[VALUEAPLANEJADA]'
		,@lsComando = @lsComando + ',[VALUEATOTAL]'
		,@lsComando = @lsComando + ') VALUES ('
		,@lsComando = @lsComando + '''''' 
		,@lsComando = @lsComando + ',' + '''' + 'Quantidade Embalagem' + ''''
		,@lsComando = @lsComando + ',' + '''''' 
		,@lsComando = @lsComando + ',' + '''' + 'Produto' + ''''
		,@lsComando = @lsComando + @lsValues
		,@lsComando = @lsComando + ',' + '''Quantidade Planejada''' 
		,@lsComando = @lsComando + ',' + '''Quantidade Total''' 
		,@lsComando = @lsComando + ')'


	exec (@lsComando)

	-- Exclui da Tabela de Itens entrega os produtos que estão zerados
	delete from tmppedidovendaitementrega 
	where tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
	and	cdProdutoSEQ not in (
							select
								cdProdutoSEQ
							from
								dbo.tmpPedidoVendaItem (nolock)
							where
								tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
							and	qtPedidoVendaItem <> 0
							)
						

	--Populando a tabela
	DECLARE Cursor_Produtos CURSOR FOR 
		select 
			 PRO.cdProdutoSEQ
			,PRO.dsProduto
			,PRO.qtEmbalagemProduto
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


	OPEN Cursor_Produtos

	FETCH NEXT FROM Cursor_Produtos 
	INTO 
		 @cdProdutoSEQ
		,@dsProduto
		,@qtEmbalagemProduto

    set @qtAcumuladaPlanejada = 0

	WHILE @@FETCH_STATUS = 0
	BEGIN

		select
			 @lsComandoCampos						= ''
			,@lsComandoValores						= ''
			,@vrUnitarioMoedaCompromissoCompraItem	= 0
			,@qtAcumulada							= 0
			,@vlAcumulado							= 0

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
				 [dtAnoMes]
				,[dsAnoMes]
			from 
				#TabelaAnoMes	
			

		OPEN Cursor_Vencimentos

		FETCH NEXT FROM Cursor_Vencimentos 
		INTO 
			 @dtAnoMes
			,@dsAnoMes


		WHILE @@FETCH_STATUS = 0
		BEGIN


			--Obtenho o Valor Unitário
			select
				@vrUnitarioMoedaCompromissoCompraItem = CCI.vrUnitarioMoedaCompromissoCompraItem
			from
				dbo.CompromissoCompraItem	CCI
			where
				CCI.cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ
			and	CCI.cdProdutoSEQ = @cdProdutoSEQ
			and CCI.cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ


			--Obtenho as Quantidades, se houver
			select
				 @tmpPedidoVendaItemEntregaSEQ		= 0
				,@cdPedidoVendaItemEntregaSEQ		= 0
				,@qtPedidoVendaItemEntrega			= 0	
				,@qtAbertoPedidoVendaItemEntrega	= 0


			select
				 @tmpPedidoVendaItemEntregaSEQ		= tmpPedidoVendaItemEntregaSEQ
				,@cdPedidoVendaItemEntregaSEQ		= cdPedidoVendaItemEntregaSEQ
				,@qtPedidoVendaItemEntrega			= qtPedidoVendaItemEntrega	
				,@qtAbertoPedidoVendaItemEntrega	= 0
			from
				dbo.tmpPedidoVendaItemEntrega
			where
				tmpPedidoVendaSEQ			= @tmpPedidoVendaSEQ			
			and	cdProdutoSEQ				= @cdProdutoSEQ
			and	dtAnoMesPedidoVendaItemEntrega = @dtAnoMes 


			select
				 @qtAcumulada = @qtAcumulada + @qtPedidoVendaItemEntrega
				,@vlAcumulado = @qtAcumulada + (@qtPedidoVendaItemEntrega * @vrUnitarioMoedaCompromissoCompraItem)
				,@qtAcumuladaPlanejada = @qtAcumuladaPlanejada + @qtPedidoVendaItemEntrega


			select
				 @lsNomeCampoChave = 'KEYD' + convert(varchar, @ctContadorCampos)
				,@lsNomeCampoQtPedido = 'VALUED' + convert(varchar, @ctContadorCampos)



			select

				 @cdChaveVirtual = convert(varchar, @tmpPedidoVendaItemEntregaSEQ) + '-'
				,@cdChaveVirtual = @cdChaveVirtual + convert(varchar, @tmpPedidoVendaSEQ) + '-'
				,@cdChaveVirtual = @cdChaveVirtual + convert(varchar, @cdProdutoSEQ) + '-'
				,@cdChaveVirtual = @cdChaveVirtual + convert(varchar, @cdCronogramaSafraSEQ) + '-'
				,@cdChaveVirtual = @cdChaveVirtual + convert(varchar, @dtAnoMes, 103)




				select
					 @ctContadorCampos = @ctContadorCampos + 1


			--Monto o comando
			select
				 @lsComandoCampos	= @lsComandoCampos + ',[' + @lsNomeCampoQtPedido + ']'
				,@lsComandoCampos	= @lsComandoCampos + ',[' + @lsNomeCampoChave + ']'


			select
				 @lsComandoValores	= @lsComandoValores + ',''' + dbo.FN_FormatarValor(@qtPedidoVendaItemEntrega, 1) + ''' '
				,@lsComandoValores	= @lsComandoValores + ',''' + @cdChaveVirtual + ''' '

			FETCH NEXT FROM Cursor_Vencimentos 
			INTO
				 @dtAnoMes 
				,@dsAnoMes

		END 
		CLOSE Cursor_Vencimentos
		DEALLOCATE Cursor_Vencimentos
		
		-- Busca a Quantidade Total
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
			
		-- Busca a Quantidade digitada
		set @qtAcumuladaPlanejada = 0
		select
			@qtAcumuladaPlanejada = sum(qtPedidoVendaItemEntrega)
		from
			dbo.tmpPedidoVendaItemEntrega
		where
			tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
		and cdProdutoSEQ = @cdProdutoSEQ	
		
		if @qtAcumuladaPlanejada is null
		begin
			set @qtAcumuladaPlanejada = 0
		end
		
		select
			 @lsComando = 'insert into #Tabela ('
			,@lsComando = @lsComando + '[CDProduto]'
			,@lsComando = @lsComando + ',[FATOR]'
			,@lsComando = @lsComando + ',[VALTOTAL]'
			,@lsComando = @lsComando + ',[DSProduto]'
			,@lsComando = @lsComando + @lsComandoCampos 
			,@lsComando = @lsComando + ',[VALUEAPLANEJADA]'
			,@lsComando = @lsComando + ',[VALUEATOTAL]'
			,@lsComando = @lsComando + ',[KIT]) values ('
			,@lsComando = @lsComando + '''' + convert(varchar, @cdProdutoSEQ) + ''''
			,@lsComando = @lsComando + ',''' + dbo.FN_FormatarValor(@qtEmbalagemProduto, 1) + ''''
			,@lsComando = @lsComando + ',''' + dbo.FN_FormatarValor(@vlAcumulado, 2) + ''''
			,@lsComando = @lsComando + ',''' + @dsProduto + ''''
			,@lsComando = @lsComando + @lsComandoValores 
			,@lsComando = @lsComando + ',''' + dbo.FN_FormatarValor(@qtAcumuladaPlanejada,1)  +  ''''
			,@lsComando = @lsComando + ',''' + dbo.FN_FormatarValor(@qtAcumulada, 2) +  ''''
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
	drop TABLE #TabelaAnoMes

	set nocount off