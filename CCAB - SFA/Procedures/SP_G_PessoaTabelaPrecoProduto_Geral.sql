/******************************************************************************
**		File: SP_G_PessoaTabelaPrecoProduto_Geral.sql
**		Name: SP_G_PessoaTabelaPrecoProduto_Geral
**		Desc: Obtem o tabelão da Tabela de Preços
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		10.05.2010		Ronaldo Mega			Amarraçao Principio Ativo
**		13.05.2010		Ronaldo Mega			Remoção Fornedor 
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_PessoaTabelaPrecoProduto_Geral]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_PessoaTabelaPrecoProduto_Geral]
END
GO
 

CREATE PROCEDURE [dbo].[SP_G_PessoaTabelaPrecoProduto_Geral]
	 @cdPessoaSEQ			bigint
	,@cdCronogramaSafraSEQ	bigint
	,@cdTipoProduto			bigint
 
AS

	set nocount on 

	CREATE TABLE #Tabela
	(
		 [CDProduto]		bigint
		,[DSProduto]		varchar(max)
	)	

	declare
		 @cdCronogramaSafraVencimentoSEQ		bigint
		,@dtCronogramaSafraVencimento			datetime
		,@dsTipoCronogramaSafraVencimento		varchar(100)

		,@cdProdutoSEQ							bigint
		,@dsProduto								varchar(70)
		,@dsFornecedor							varchar(100)
		,@dsPrincipioAtivo						char(3)

		,@lsComando								varchar(max)
		,@lsComandoCampos						varchar(max)
		,@lsComandoValores						varchar(max)
		,@lsNomeCampoReal						varchar(max)
		,@lsNomeCampoDolar						varchar(max)

		,@lsNomeCampoChaveReal					varchar(max)
		,@lsNomeCampoChaveDolar					varchar(max)

		,@cdPessoaTabelaPrecoProdutoSEQ			bigint
		,@vrDolarPessoaTabelaPrecoProduto		numeric(22,4)
		,@vrRealPessoaTabelaPrecoProduto		numeric(22,4)
		,@cdChaveVirtualReal					varchar(max)
		,@cdChaveVirtualDolar					varchar(max)
		,@ctContadorCampos						int
	
		,@lsCampos								varchar(max)
		,@lsValues								varchar(max)

		,@ctContador							int
		,@ctContadorMoeda						int
		,@dsMoeda								varchar(3)
		


	select
		 @cdPessoaTabelaPrecoProdutoSEQ		= 0
		,@vrDolarPessoaTabelaPrecoProduto	= 0
		,@vrRealPessoaTabelaPrecoProduto	= 0
		,@ctContadorCampos					= 1
		,@lsCampos							= ''
		,@lsValues							= ''
		

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
		order by
			 cdTipoCronogramaSafraVencimento	desc
			,dtCronogramaSafraVencimento		desc

	OPEN Cursor_Vencimentos

	FETCH NEXT FROM Cursor_Vencimentos 
	INTO 
		 @cdCronogramaSafraVencimentoSEQ
		,@dtCronogramaSafraVencimento
		,@dsTipoCronogramaSafraVencimento


	WHILE @@FETCH_STATUS = 0
	BEGIN

		select
			@ctContadorMoeda = 1	--Reais

		while @ctContadorMoeda < 3
		begin
			
			if @ctContadorMoeda = 1
			begin
				select
					@dsMoeda = 'R$'
			end
			else
			begin
				select
					@dsMoeda = 'US$'
			end

			select
				@lsComando = 'ALTER TABLE #Tabela ADD [KEY' + Convert(varchar, @ctContadorCampos) + '] varchar(max)'

			exec(@lsComando)

			select
				@lsComando = 'ALTER TABLE #Tabela ADD [VALUE' + Convert(varchar, @ctContadorCampos) + '] varchar(max)'


			exec(@lsComando)


			--CAMPOS

			select
				 @lsCampos = @lsCampos + ',[KEY' + Convert(varchar, @ctContadorCampos) + ']'
				,@lsCampos = @lsCampos + ',[VALUE' + Convert(varchar, @ctContadorCampos) + ']'



			--VALUES
			select
				@lsValues = @lsValues + ','''','''

			if not @dtCronogramaSafraVencimento is null
			begin
				select
					@lsValues = @lsValues + Convert(varchar, @dtCronogramaSafraVencimento, 103)
			end
			else
			begin
				select
					@lsValues = @lsValues + @dsTipoCronogramaSafraVencimento 
			end

			select
				@lsValues = @lsValues + ' ' + @dsMoeda

			select
				@lsValues = @lsValues + ''''

	

			select
				 @ctContadorCampos = @ctContadorCampos + 1
				,@ctContadorMoeda = @ctContadorMoeda + 1

			
			
		end

		FETCH NEXT FROM Cursor_Vencimentos 
		INTO 
			 @cdCronogramaSafraVencimentoSEQ
			,@dtCronogramaSafraVencimento
			,@dsTipoCronogramaSafraVencimento

	END 
	CLOSE Cursor_Vencimentos
	DEALLOCATE Cursor_Vencimentos


	--Insiro na primeira linha
	select
		 @lsComando = 'insert into #Tabela ([CDProduto], [DSProduto] '
		,@lsComando = @lsComando + @lsCampos
		,@lsComando = @lsComando + ') VALUES ('
		,@lsComando = @lsComando + '''''' + ',' + '''' + ' Produto' + ''''
		,@lsComando = @lsComando + @lsValues
		,@lsComando = @lsComando + ')'
		
	print @lsComando

	exec (@lsComando)

	--Populando a tabela
	DECLARE Cursor_Produtos CURSOR FOR 
		select
			 cdProdutoSEQ
			,dsProduto /*+ ' [' + IsNull((SELECT 
								wkDominioCodigoReferenciado 
							FROM  
								CodigoReferenciado 				
							WHERE 
								vrDominioCodigoReferenciado	= (SELECT cdTipoProduto FROM PRODUTO WITH(NOLOCK) WHERE A.cdProdutoSEQ = cdProdutoSEQ)
								AND	dsDominioCodigoReferenciado	= 'DMESPTIPOPRODUTO'
						),'Tipo') + ']'*/
			
		from
			dbo.Produto A
			INNER JOIN CooperativaPrincipioAtivo B ON (B.cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ AND B.cdCooperativaSEQ = @cdPessoaSEQ)									
		where
			--A.cdTipoProduto = B.cdTipoProduto
			(A.cdTipoProduto = @cdTipoProduto OR @cdTipoProduto IS NULL)
			--B.cdFornecedorPrincipioAtivo = 	A.cdFornecedorSEQ
			--AND ((CASE WHEN B.cdIndicadorPrincipioAtivo = 1 THEN 2 ELSE 1 END) =  A.cdTipoProduto OR (CASE WHEN B.cdIndicadorProdutoAcabado = 1 THEN 1 ELSE 2 END) =  A.cdTipoProduto)
			
			AND ( cdIndicadorLiberadoPedidoProduto = 1 --Sim	
			  or cdProdutoSEQ in (	select 
										distinct cdProdutoSEQ 
									from 
										pessoatabelaprecoproduto										
									where 
										cdPessoaSEQ = @cdPessoaSEQ
										and cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
										and (vrDolarPessoaTabelaPrecoProduto <> 0 or vrRealPessoaTabelaPrecoProduto <> 0) ) )
			
			
			
		
		order by dsProduto

	OPEN Cursor_Produtos

	FETCH NEXT FROM Cursor_Produtos 
	INTO 
		 @cdProdutoSEQ
		,@dsProduto

	WHILE @@FETCH_STATUS = 0
	BEGIN

		select
			 @lsComandoCampos = ''
			,@lsComandoValores = ''


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
			order by
				cdTipoCronogramaSafraVencimento	desc
				,dtCronogramaSafraVencimento		desc
			

		OPEN Cursor_Vencimentos

		FETCH NEXT FROM Cursor_Vencimentos 
		INTO 
			 @cdCronogramaSafraVencimentoSEQ
			,@dtCronogramaSafraVencimento
			,@dsTipoCronogramaSafraVencimento


		WHILE @@FETCH_STATUS = 0
		BEGIN

			select
				@ctContadorMoeda = 1	--Reais

			select
				 @cdPessoaTabelaPrecoProdutoSEQ		= 0
				,@vrDolarPessoaTabelaPrecoProduto	= 0
				,@vrRealPessoaTabelaPrecoProduto	= 0

			select
				 @cdPessoaTabelaPrecoProdutoSEQ		= cdPessoaTabelaPrecoProdutoSEQ
				,@vrDolarPessoaTabelaPrecoProduto	= vrDolarPessoaTabelaPrecoProduto
				,@vrRealPessoaTabelaPrecoProduto	= vrRealPessoaTabelaPrecoProduto
			from
				dbo.PessoaTabelaPrecoProduto
			where
				cdPessoaSEQ						= @cdPessoaSEQ
			and cdCronogramaSafraSEQ			= @cdCronogramaSafraSEQ
			and cdProdutoSEQ					= @cdProdutoSEQ
			and cdCronogramaSafraVencimentoSEQ	= @cdCronogramaSafraVencimentoSEQ

			while @ctContadorMoeda < 3
			begin
				
				if @ctContadorMoeda = 1
				begin
					select
						 @dsMoeda = 'R$'
						,@lsNomeCampoReal = 'VALUE' + convert(varchar, @ctContadorCampos)
						,@lsNomeCampoChaveReal = 'KEY' + convert(varchar, @ctContadorCampos)

					select
						 @cdChaveVirtualReal = convert(varchar, @cdPessoaTabelaPrecoProdutoSEQ) + '-'
						,@cdChaveVirtualReal = @cdChaveVirtualReal + convert(varchar, @cdPessoaSEQ) + '-'
						,@cdChaveVirtualReal = @cdChaveVirtualReal + convert(varchar, @cdCronogramaSafraSEQ) + '-'
						,@cdChaveVirtualReal = @cdChaveVirtualReal + convert(varchar, @cdProdutoSEQ) + '-'
						,@cdChaveVirtualReal = @cdChaveVirtualReal + convert(varchar, @cdCronogramaSafraVencimentoSEQ) + '-'
						,@cdChaveVirtualReal = @cdChaveVirtualReal + convert(varchar, @ctContadorMoeda)

				end
				else
				begin
					select
						 @dsMoeda = 'US$'
						,@lsNomeCampoDolar = 'VALUE' + convert(varchar, @ctContadorCampos)
						,@lsNomeCampoChaveDolar = 'KEY' + convert(varchar, @ctContadorCampos)

					select
						 @cdChaveVirtualDolar = convert(varchar, @cdPessoaTabelaPrecoProdutoSEQ) + '-'
						,@cdChaveVirtualDolar = @cdChaveVirtualDolar + convert(varchar, @cdPessoaSEQ) + '-'
						,@cdChaveVirtualDolar = @cdChaveVirtualDolar + convert(varchar, @cdCronogramaSafraSEQ) + '-'
						,@cdChaveVirtualDolar = @cdChaveVirtualDolar + convert(varchar, @cdProdutoSEQ) + '-'
						,@cdChaveVirtualDolar = @cdChaveVirtualDolar + convert(varchar, @cdCronogramaSafraVencimentoSEQ) + '-'
						,@cdChaveVirtualDolar = @cdChaveVirtualDolar + convert(varchar, @ctContadorMoeda)

				end
				
				select
					 @ctContadorCampos = @ctContadorCampos + 1
					,@ctContadorMoeda = @ctContadorMoeda + 1

				
				
			end


			--Monto o comando
			select
				 @lsComandoCampos	= @lsComandoCampos + ',[' + @lsNomeCampoReal + ']'
				,@lsComandoCampos	= @lsComandoCampos + ',[' + @lsNomeCampoDolar + ']'
				,@lsComandoCampos	= @lsComandoCampos + ',[' + @lsNomeCampoChaveReal + ']'
				,@lsComandoCampos	= @lsComandoCampos + ',[' + @lsNomeCampoChaveDolar + ']'

			select
				 @lsComandoValores	= @lsComandoValores + ',''' + dbo.FN_FormatarValor(@vrRealPessoaTabelaPrecoProduto, 4) + ''' '
				,@lsComandoValores	= @lsComandoValores + ',''' + dbo.FN_FormatarValor(@vrDolarPessoaTabelaPrecoProduto, 4) + ''' '
				,@lsComandoValores	= @lsComandoValores + ',''' + @cdChaveVirtualReal + ''' '
				,@lsComandoValores	= @lsComandoValores + ',''' + @cdChaveVirtualDolar + ''' '

			FETCH NEXT FROM Cursor_Vencimentos 
			INTO 
				 @cdCronogramaSafraVencimentoSEQ
				,@dtCronogramaSafraVencimento
				,@dsTipoCronogramaSafraVencimento

		END 
		CLOSE Cursor_Vencimentos
		DEALLOCATE Cursor_Vencimentos

		select
			 @lsComando = 'insert into #Tabela ([CDProduto],[DSProduto]'
			,@lsComando = @lsComando + @lsComandoCampos
			,@lsComando = @lsComando + ') values ('
			,@lsComando = @lsComando + convert(varchar, @cdProdutoSEQ) + ',''' + @dsProduto + ''''

			,@lsComando = @lsComando + @lsComandoValores
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

	select								
		* 
	from 
		#Tabela A		
	order by 
		[DSProduto]
	
	drop table #tabela 

	set nocount off

/*
	[SP_G_PessoaTabelaPrecoProduto_Geral] 2388,49
*/