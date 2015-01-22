/******************************************************************************
**		File: SP_G_CompromissoCompraItemReal_Geral.sql
**		Name: SP_G_CompromissoCompraItemReal_Geral
**		Desc: Obtem o tabelão dos Itens do CompromissoCompra
**
**		Auth: Convergence
**		Date: 2/4/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		24.05.2010		Ronaldo Mega			Inclusao Tipo Produto
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CompromissoCompraItemReal_Geral]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_CompromissoCompraItemReal_Geral]
END
GO
 

CREATE PROCEDURE [dbo].[SP_G_CompromissoCompraItemReal_Geral] 
	@tmpCompromissoCompraSEQ	bigint
 
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
		,@cdCronogramaSafraSEQ					bigint
		,@cdAgenteComercialCooperativaCompromissoCompra	bigint
		,@cdIndicadorMoedaCompromissoCompra		int
	
		,@cdCompromissoCompraItemSEQ			bigint
		,@qtCompromissoCompraItem				numeric(22,4)
		,@qtAbertoCompromissoCompraItem			numeric(22,4)

		,@qtAcumulada							numeric(22,4)
		,@vlAcumulado							numeric(22,4)
		
		,@cdIndicadorTipoTransacao				bigint
		

	select
		 @ctContadorCampos					= 1
		,@lsCampos							= ''
		,@lsValues							= ''
	
	-- Verifica o Tipo de Transação (1 - Inclusao, 2 - Alteracao)
	select @cdIndicadorTipoTransacao = cdCompromissoCompraSEQ
	from tmpCompromissoCompra
	Where tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ
	
	IF @cdIndicadorTipoTransacao = 0
	BEGIN
		SET @cdIndicadorTipoTransacao = 1 -- Inclusao
	END
	ELSE
	BEGIN
		SET @cdIndicadorTipoTransacao = 2 -- Alteracao
	END
	

	--Obtenho os dados do Compromisso de Compra
	select
		 @cdCronogramaSafraSEQ		= cdCronogramaSafraSEQ
		,@cdAgenteComercialCooperativaCompromissoCompra	= cdAgenteComercialCooperativaCompromissoCompra
		,@cdIndicadorMoedaCompromissoCompra = cdIndicadorMoedaCompromissoCompra
	from
		dbo.tmpCompromissoCompra
	where 
		tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ

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
													dbo.PessoaTabelaPrecoProduto
												where
													vrRealPessoaTabelaPrecoProduto <> 0
												and cdPessoaSEQ = @cdAgenteComercialCooperativaCompromissoCompra
												and cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
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

	--Populando a tabela
	DECLARE Cursor_Produtos CURSOR FOR 
		select 
			 PRO.cdProdutoSEQ
			,PRO.dsProduto + ' [' + ISNULL((SELECT wkDominioCodigoReferenciado FROM dbo.CodigoReferenciado WITH(NOLOCK) WHERE vrDominioCodigoReferenciado	= PRO.cdTipoProduto AND dsDominioCodigoReferenciado	= 'DMESPTIPOPRODUTO'),'-') + ']'
			,PRO.qtEmbalagemProduto
		from
			dbo.Produto					PRO
		where
			(	(PRO.cdProdutoSEQ IN	(
								select distinct
									cdProdutoSEQ
								from
									dbo.PessoaTabelaPrecoProduto
								where
									cdPessoaSEQ = @cdAgenteComercialCooperativaCompromissoCompra
								and cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
								and vrRealPessoaTabelaPrecoProduto <> 0
										) AND @cdIndicadorTipoTransacao = 2 and (PRO.cdIndicadorLiberadoPedidoProduto = 1
										                                           or PRO.cdProdutoSEQ IN (	select distinct cdProdutoSEQ
										                                                                    from tmpCompromissoCompraItem
										                                                                    where tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ
										                                                                    and   qtCompromissoCompraItem <> 0)))-- Alteracao
			OR
				(PRO.cdProdutoSEQ IN	(
								select distinct
									cdProdutoSEQ
								from
									dbo.PessoaTabelaPrecoProduto
								where
									cdPessoaSEQ = @cdAgenteComercialCooperativaCompromissoCompra
								and cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
								and vrRealPessoaTabelaPrecoProduto <> 0
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
			,@qtAcumulada							= 0
			,@vlAcumulado							= 0


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
													dbo.PessoaTabelaPrecoProduto
												where
													vrRealPessoaTabelaPrecoProduto <> 0
												and cdPessoaSEQ = @cdAgenteComercialCooperativaCompromissoCompra
												and cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
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
			select
				@vrUnitarioMoedaCompromissoCompraItem = CCI.vrRealPessoaTabelaPrecoProduto
			from
				dbo.PessoaTabelaPrecoProduto CCI
			where
				CCI.cdPessoaSEQ = @cdAgenteComercialCooperativaCompromissoCompra
			and	CCI.cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
			and	CCI.cdProdutoSEQ = @cdProdutoSEQ
			and CCI.cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ

			--Obtenho as Quantidades, se houver
			select
				 @cdCompromissoCompraItemSEQ	= 0
				,@qtCompromissoCompraItem		= 0
				,@qtAbertoCompromissoCompraItem	= 0


			select
				 @cdCompromissoCompraItemSEQ	= tmpCompromissoCompraItemSEQ
				,@qtCompromissoCompraItem		= qtCompromissoCompraItem	
				,@qtAbertoCompromissoCompraItem	= qtAbertoCompromissoCompraItem
			from
				dbo.tmpCompromissoCompraItem
			where
				tmpCompromissoCompraSEQ			= @tmpCompromissoCompraSEQ			
			and
				cdProdutoSEQ					= @cdProdutoSEQ
			and
				cdCronogramaSafraVencimentoSEQ	= @cdCronogramaSafraVencimentoSEQ 

			select
				 @qtAcumulada = @qtAcumulada + @qtCompromissoCompraItem
				,@vlAcumulado = @qtAcumulada + (@qtCompromissoCompraItem * @vrUnitarioMoedaCompromissoCompraItem)


			select
				 @lsNomeCampoChave = 'KEYD' + convert(varchar, @ctContadorCampos)
				,@lsNomeCampoQtPedido = 'VALUED' + convert(varchar, @ctContadorCampos)
				,@lsNomeCampoChaveQtAberto = 'KEYA' + convert(varchar, @ctContadorCampos)
				,@lsNomeCampoQtAberto = 'VALUEA' + convert(varchar, @ctContadorCampos)
				,@lsNomeCampoChaveValor = 'KEYV' + convert(varchar, @ctContadorCampos)
				,@lsNomeCampoValor = 'VALUEV' + convert(varchar, @ctContadorCampos)
				

			select
				 @cdChaveVirtual = convert(varchar, @cdCompromissoCompraItemSEQ) + '-'
				,@cdChaveVirtual = @cdChaveVirtual + convert(varchar, @tmpCompromissoCompraSEQ) + '-'
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
				 @lsComandoValores	= @lsComandoValores + ',''' + dbo.FN_FormatarValor(@qtCompromissoCompraItem, 1) + ''' '
				,@lsComandoValores	= @lsComandoValores + ',''' + dbo.FN_FormatarValor(@qtAbertoCompromissoCompraItem, 1) + ''' '
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
			,@lsComando = @lsComando + ',[VALUEATOTAL]) values ('
			,@lsComando = @lsComando + '''' + convert(varchar, @cdProdutoSEQ) + ''''
			,@lsComando = @lsComando + ',''' + dbo.FN_FormatarValor(@qtEmbalagemProduto, 1) + ''''
			,@lsComando = @lsComando + ',''' + dbo.FN_FormatarValor(@vlAcumulado, 2) + ''''
			,@lsComando = @lsComando + ',''' + @dsProduto + ''''
			,@lsComando = @lsComando + @lsComandoValores 
			,@lsComando = @lsComando + ',''' + dbo.FN_FormatarValor(@qtAcumulada, 1) +  ''''
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
	
	/*
		Teste
		[SP_G_CompromissoCompraItemReal_Geral] 424
	*/