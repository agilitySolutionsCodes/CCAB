set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: sp_s_rel_CompromissoCompraConsolidado.sql
**		Name: sp_s_rel_CompromissoCompraConsolidado
**		Desc: Consulta os dados necessários para o Relatório de Compromisso de Compra Consolidado
**
**		Auth: Roberto Carlos
**		Date: 4/Jun/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_s_rel_CompromissoCompraConsolidado]'))
BEGIN
	DROP PROCEDURE [dbo].[sp_s_rel_CompromissoCompraConsolidado]
END
GO
 
CREATE PROCEDURE [dbo].[sp_s_rel_CompromissoCompraConsolidado]
	 @cdAgenteComercialCooperativaCompromissoCompra		bigint		= null
	,@cdCronogramaSafraSEQ								bigint

AS

	set nocount on

	declare
		 @cdPessoaSEQ							bigint
		,@cdAgrupamentoAgente					varchar(max)
		,@dsAgrupamentoAgente					varchar(max)

		,@cdProdutoSEQ							bigint
		,@dsProduto								varchar(70)
		,@qtEmbalagemProduto					numeric(22,6)

		,@cdPessoaSEQ_OrigemFaturamento			bigint
		,@nmPessoa_OrigemFaturamento			varchar(70)


		,@cdMoeda								bigint
		,@dsMoeda								varchar(100)

		,@Fetch_Agente							bigint
		,@Fetch_Produto							bigint
		,@Fetch_OrigemFaturamento				bigint
		,@Fetch_Moeda							int

		,@qtCompromissoCompraItem				numeric(22,6)
		,@vrUnitarioMoedaCompromissoCompraItem	numeric(22,4)
		,@vrTotalMoedaCompromissoCompraItem		numeric(22,4)


	--Crio a Temporária que vai retornar para o Relatório
	create table #Retorno
		(
		 cdAgrupamentoAgente			varchar(max)
		,dsAgrupamentoAgente			varchar(max)

		,cdProdutoSEQ					bigint
		,dsProduto						varchar(70)
		,qtEmbalagemProduto				numeric(22,6)

		,dsOrigemFaturamento			varchar(max)
		,dsMoeda						varchar(max)
		,dsQuantidade					varchar(max)


		,vrConteudo						numeric(22,6)
		)





	---TEMPORARIA UTILIZADA PARA FACILITAR O FILTRO, AFIM DE EVITAR O EXECUTE NA PROC
	--Crio uma Tabela Temporária para o Agente
	create table #Agente (cdPessoaSEQ		bigint)

	--Populo a Tabela Temporária do Agente, de acordo com o Parâmetro de Entrada
	if @cdAgenteComercialCooperativaCompromissoCompra is null or @cdAgenteComercialCooperativaCompromissoCompra = 0
	begin
		insert into
			#Agente
		select
			cdPessoaSEQ
		from
			dbo.Pessoa	AGE
		where
			AGE.cdIndicadorTipoPerfilPessoa = 3 --Agente Comercial
		and	AGE.cdIndicadorStatusPessoa		= 1
		and	AGE.cdPessoaSEQ	in (
								select
									COM.cdAgenteComercialCooperativaCompromissoCompra
								from
									dbo.CompromissoCompra	COM
								where
									COM.cdCronogramaSafraSEQ			= @cdCronogramaSafraSEQ
								)
	end
	else
	begin
		insert into
			#Agente
		select
			cdPessoaSEQ
		from
			dbo.Pessoa	AGE
		where
			AGE.cdIndicadorTipoPerfilPessoa = 3 --Agente Comercial
		and	AGE.cdIndicadorStatusPessoa		= 1
		and AGE.cdPessoaSEQ					= @cdAgenteComercialCooperativaCompromissoCompra
		and	AGE.cdPessoaSEQ	in (
								select
									COM.cdAgenteComercialCooperativaCompromissoCompra
								from
									dbo.CompromissoCompra	COM
								where
									COM.cdCronogramaSafraSEQ			= @cdCronogramaSafraSEQ
								)
	end
	-----------------------------------------------------------------------------


	--Rodo os Agentes
	declare cs_Agente CURSOR FOR
		select
			 cdPessoaSEQ
			,isnull(nmPessoa, '') + isnull(cdPessoaERP, '')				as cdAgrupamentoAgente
			,isnull(nmPessoa, '') + ' - ' + isnull(cdPessoaERP, '')		as dsAgrupamentoAgente

		from
			dbo.Pessoa	AGE
		where
			AGE.cdPessoaSEQ	in (
								select
									cdPessoaSEQ
								from
									#Agente
								)
	
	OPEN cs_Agente
	FETCH NEXT from cs_Agente
	INTO	
		 @cdPessoaSEQ				
		,@cdAgrupamentoAgente		
		,@dsAgrupamentoAgente		

	SET @Fetch_Agente = @@FETCH_STATUS
	
	WHILE @Fetch_Agente = 0
	BEGIN

		------------
		--Rodo os Produtos dos Compromissos daquela Safra

		declare cs_Produto CURSOR FOR
			select
				 cdProdutoSEQ
				,dsProduto
				,qtEmbalagemProduto
			from
				dbo.Produto
			where
				cdProdutoSEQ in (
									select
										cdProdutoSEQ
									from
										dbo.CompromissoCompraItem
									where
										cdCronogramaSafraSEQ		= @cdCronogramaSafraSEQ
								)
		
		OPEN cs_Produto
		FETCH NEXT from cs_Produto
		INTO	
			 @cdProdutoSEQ				
			,@dsProduto	
			,@qtEmbalagemProduto				
                
						
		SET @Fetch_Produto = @@FETCH_STATUS
		
		WHILE @Fetch_Produto = 0
		BEGIN

			------------
			--Rodo as Origens de Faturamento
			declare cs_OrigemFaturamento CURSOR FOR
				select
					 cdPessoaSEQ
					,nmPessoa
				from
					dbo.Pessoa
				where
					cdIndicadorTipoPerfilPessoa	= 2 --Empresa CCAB
	
			
			OPEN cs_OrigemFaturamento
			FETCH NEXT from cs_OrigemFaturamento
			INTO	
				 @cdPessoaSEQ_OrigemFaturamento		
				,@nmPessoa_OrigemFaturamento		
              
							
			SET @Fetch_OrigemFaturamento = @@FETCH_STATUS
			
			WHILE @Fetch_OrigemFaturamento = 0
			BEGIN

				------------

				--Rodo as Moeadas Disponíveis
				declare cs_Moeda CURSOR FOR
					select
						 vrDominioCodigoReferenciado
						,wkDominioCodigoReferenciado
					from
						dbo.CodigoReferenciado
					where
						dsDominioCodigoReferenciado = 'DMESPINDICADORMOEDA'
				
				OPEN cs_Moeda
				FETCH NEXT from cs_Moeda
				INTO	
					 @cdMoeda
					,@dsMoeda              
								
				SET @Fetch_Moeda = @@FETCH_STATUS
				
				WHILE @Fetch_Moeda = 0
				BEGIN

					------------
					--Obtenho os Conteúdos
					select
						 @qtCompromissoCompraItem							= isnull(sum(ITE.qtCompromissoCompraItem), 0)
						,@vrTotalMoedaCompromissoCompraItem					= isnull(sum(ITE.vrTotalMoedaCompromissoCompraItem), 0)
					from
						dbo.CompromissoCompraItem		ITE
					inner join
						dbo.CompromissoCompra			COM
					on	COM.cdCompromissoCompraSEQ							= ITE.cdCompromissoCompraSEQ
					where
						COM.cdAgenteComercialCooperativaCompromissoCompra	= @cdPessoaSEQ
					and	ITE.cdProdutoSEQ									= @cdProdutoSEQ
					and COM.cdPessoaOrigemFaturamento						= @cdPessoaSEQ_OrigemFaturamento
					and COM.cdIndicadorMoedaCompromissoCompra				= @cdMoeda
					and COM.cdCronogramaSafraSEQ							= @cdCronogramaSafraSEQ
					and ITE.cdCronogramaSafraSEQ							= @cdCronogramaSafraSEQ


					if @qtCompromissoCompraItem <> 0  and @vrTotalMoedaCompromissoCompraItem <> 0
					begin
						select
							@vrUnitarioMoedaCompromissoCompraItem = @vrTotalMoedaCompromissoCompraItem / @qtCompromissoCompraItem
					end
					else
					begin
						select
							@vrUnitarioMoedaCompromissoCompraItem = 0
					end


					-- Inserção dos Dados na Temporária (Quantidade)
					insert into #Retorno 
						(
						 cdAgrupamentoAgente			
						,dsAgrupamentoAgente	
						,cdProdutoSEQ
						,dsProduto
						,qtEmbalagemProduto
						,dsOrigemFaturamento
						,dsMoeda
						,dsQuantidade
						,vrConteudo
						)		
						values
						(
						 @cdAgrupamentoAgente
						,@dsAgrupamentoAgente
						,@cdProdutoSEQ
						,@dsProduto
						,@qtEmbalagemProduto
						,@nmPessoa_OrigemFaturamento
						,@dsMoeda
						,'Qtde.'
						,@qtCompromissoCompraItem
						)
					

					-- Inserção dos Dados na Temporária (Valor Unitário)
					insert into #Retorno 
						(
						 cdAgrupamentoAgente			
						,dsAgrupamentoAgente	
						,cdProdutoSEQ
						,dsProduto
						,qtEmbalagemProduto
						,dsOrigemFaturamento
						,dsMoeda
						,dsQuantidade
						,vrConteudo
						)		
						values
						(
						 @cdAgrupamentoAgente
						,@dsAgrupamentoAgente
						,@cdProdutoSEQ
						,@dsProduto
						,@qtEmbalagemProduto
						,@nmPessoa_OrigemFaturamento
						,@dsMoeda
						,'Vl. Unit.'
						,@vrUnitarioMoedaCompromissoCompraItem
						)


					-- Inserção dos Dados na Temporária (Valor Total)
					insert into #Retorno 
						(
						 cdAgrupamentoAgente			
						,dsAgrupamentoAgente	
						,cdProdutoSEQ
						,dsProduto
						,qtEmbalagemProduto
						,dsOrigemFaturamento
						,dsMoeda
						,dsQuantidade
						,vrConteudo
						)		
						values
						(
						 @cdAgrupamentoAgente
						,@dsAgrupamentoAgente
						,@cdProdutoSEQ
						,@dsProduto
						,@qtEmbalagemProduto
						,@nmPessoa_OrigemFaturamento
						,@dsMoeda
						,'Vl. Total'
						,@vrTotalMoedaCompromissoCompraItem
						)


					FETCH NEXT from cs_Moeda
					INTO	
						 @cdMoeda
						,@dsMoeda               
								
					SET @Fetch_Moeda = @@FETCH_STATUS
							
				END




				CLOSE cs_Moeda
				DEALLOCATE cs_Moeda











				FETCH NEXT from cs_OrigemFaturamento
				INTO	
					 @cdPessoaSEQ_OrigemFaturamento		
					,@nmPessoa_OrigemFaturamento

               
							
				SET @Fetch_OrigemFaturamento = @@FETCH_STATUS
						
			END




			CLOSE cs_OrigemFaturamento
			DEALLOCATE cs_OrigemFaturamento



			---- GRAVO OS TOTAIS LATERAIS
			--Rodo as Moeadas Disponíveis
			declare cs_Moeda CURSOR FOR
				select
					 vrDominioCodigoReferenciado
					,wkDominioCodigoReferenciado
				from
					dbo.CodigoReferenciado
				where
					dsDominioCodigoReferenciado = 'DMESPINDICADORMOEDA'
			
			OPEN cs_Moeda
			FETCH NEXT from cs_Moeda
			INTO	
				 @cdMoeda
				,@dsMoeda              
							
			SET @Fetch_Moeda = @@FETCH_STATUS
			
			WHILE @Fetch_Moeda = 0
			BEGIN

				------------
				--Obtenho os Conteúdos
				select
					 @qtCompromissoCompraItem							= isnull(sum(ITE.qtCompromissoCompraItem), 0)
					,@vrTotalMoedaCompromissoCompraItem					= isnull(sum(ITE.vrTotalMoedaCompromissoCompraItem), 0)
				from
					dbo.CompromissoCompraItem		ITE
				inner join
					dbo.CompromissoCompra			COM
				on	COM.cdCompromissoCompraSEQ							= ITE.cdCompromissoCompraSEQ
				where
					COM.cdAgenteComercialCooperativaCompromissoCompra	= @cdPessoaSEQ
				and	ITE.cdProdutoSEQ									= @cdProdutoSEQ
				and COM.cdIndicadorMoedaCompromissoCompra				= @cdMoeda
				and COM.cdCronogramaSafraSEQ							= @cdCronogramaSafraSEQ
				and ITE.cdCronogramaSafraSEQ							= @cdCronogramaSafraSEQ


				if @qtCompromissoCompraItem <> 0  and @vrTotalMoedaCompromissoCompraItem <> 0
				begin
					select
						@vrUnitarioMoedaCompromissoCompraItem = @vrTotalMoedaCompromissoCompraItem / @qtCompromissoCompraItem
				end
				else
				begin
					select
						@vrUnitarioMoedaCompromissoCompraItem = 0
				end





				-- Inserção dos Dados na Temporária (Quantidade)
				insert into #Retorno 
					(
					 cdAgrupamentoAgente			
					,dsAgrupamentoAgente	
					,cdProdutoSEQ
					,dsProduto
					,qtEmbalagemProduto
					,dsOrigemFaturamento
					,dsMoeda
					,dsQuantidade
					,vrConteudo
					)		
					values
					(
					 @cdAgrupamentoAgente
					,@dsAgrupamentoAgente
					,@cdProdutoSEQ
					,@dsProduto
					,@qtEmbalagemProduto
					,'TOTAL'
					,@dsMoeda
					,'Qtde.'
					,@qtCompromissoCompraItem
					)
				

				-- Inserção dos Dados na Temporária (Valor Unitário)
				insert into #Retorno 
					(
					 cdAgrupamentoAgente			
					,dsAgrupamentoAgente	
					,cdProdutoSEQ
					,dsProduto
					,qtEmbalagemProduto
					,dsOrigemFaturamento
					,dsMoeda
					,dsQuantidade
					,vrConteudo
					)		
					values
					(
					 @cdAgrupamentoAgente
					,@dsAgrupamentoAgente
					,@cdProdutoSEQ
					,@dsProduto
					,@qtEmbalagemProduto
					,'TOTAL'
					,@dsMoeda
					,'Vl. Unit.'
					,@vrUnitarioMoedaCompromissoCompraItem
					)


				-- Inserção dos Dados na Temporária (Valor Total)
				insert into #Retorno 
					(
					 cdAgrupamentoAgente			
					,dsAgrupamentoAgente	
					,cdProdutoSEQ
					,dsProduto
					,qtEmbalagemProduto
					,dsOrigemFaturamento
					,dsMoeda
					,dsQuantidade
					,vrConteudo
					)		
					values
					(
					 @cdAgrupamentoAgente
					,@dsAgrupamentoAgente
					,@cdProdutoSEQ
					,@dsProduto
					,@qtEmbalagemProduto
					,'TOTAL'
					,@dsMoeda
					,'Vl. Total'
					,@vrTotalMoedaCompromissoCompraItem
					)

				FETCH NEXT from cs_Moeda
				INTO	
					 @cdMoeda
					,@dsMoeda               
							
				SET @Fetch_Moeda = @@FETCH_STATUS
						
			END




			CLOSE cs_Moeda
			DEALLOCATE cs_Moeda



			FETCH NEXT from cs_Produto
			INTO	
				 @cdProdutoSEQ				
				,@dsProduto
				,@qtEmbalagemProduto	               
						
			SET @Fetch_Produto = @@FETCH_STATUS
					
		END




		CLOSE cs_Produto
		DEALLOCATE cs_Produto











		FETCH NEXT from cs_Agente
		INTO	
			 @cdPessoaSEQ				
			,@cdAgrupamentoAgente		
			,@dsAgrupamentoAgente		                  
					
		SET @Fetch_Agente = @@FETCH_STATUS
				
	END




	CLOSE cs_Agente
	DEALLOCATE cs_Agente














		



--	--Testes, apagar isso depois 
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente A001'
--		,'Agente A - 001'
--		,1
--		,'Produto 80'
--		,1.77
--		,'CCAB'
--		,'Euro'
--		,'Qtde.'
--		,1
--		)
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente A001'
--		,'Agente A - 001'
--		,1
--		,'Produto 80'
--		,1.77
--		,'CCAB'
--		,'Euro'
--		,'Vl. Unit.'
--		,3.677
--		)
--
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente A001'
--		,'Agente A - 001'
--		,1
--		,'Produto 80'
--		,1.77
--		,'CCAB'
--		,'Euro'
--		,'Vl. Total.'
--		,3.677
--		)
--
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente A001'
--		,'Agente A - 001'
--		,1
--		,'Produto 1'
--		,1.77
--		,'CCAB'
--		,'Real'
--		,'Qtde.'
--		,1
--		)
--
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente A001'
--		,'Agente A - 001'
--		,1
--		,'Produto 1'
--		,1.77
--		,'CCAB'
--		,'Real'
--		,'Vl. Unit.'
--		,1
--		)
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente A001'
--		,'Agente A - 001'
--		,1
--		,'Produto 1'
--		,1.77
--		,'CCAB'
--		,'Real'
--		,'Vl. Total.'
--		,1
--		)
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente A001'
--		,'Agente A - 001'
--		,1
--		,'Produto 1'
--		,1.77
--		,'Empresa A'
--		,'Real'
--		,'Qtde.'
--		,2
--		)
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente A001'
--		,'Agente A - 001'
--		,1
--		,'Produto 1'
--		,1.77
--		,'Empresa A'
--		,'Real'
--		,'Vl. Unit.'
--		,2
--		)
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente A001'
--		,'Agente A - 001'
--		,1
--		,'Produto 1'
--		,1.77
--		,'Empresa A'
--		,'Real'
--		,'Vl. Total.'
--		,2
--		)
--
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente A001'
--		,'Agente A - 001'
--		,1
--		,'Produto 1'
--		,1.77
--		,'Empresa A'
--		,'Dólar'
--		,'Qtde.'
--		,3
--		)
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente A001'
--		,'Agente A - 001'
--		,1
--		,'Produto 1'
--		,1.77
--		,'Empresa A'
--		,'Dólar'
--		,'Vl. Unit.'
--		,3
--		)
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente A001'
--		,'Agente A - 001'
--		,1
--		,'Produto 1'
--		,1.77
--		,'Empresa A'
--		,'Dólar'
--		,'Vl. Total.'
--		,3
--		)
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente A001'
--		,'Agente A - 001'
--		,2
--		,'Produto 2'
--		,2.00
--		,'CCAB'
--		,'Real'
--		,'Qtde.'
--		,1.56
--		)
--
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente A001'
--		,'Agente A - 001'
--		,2
--		,'Produto 2'
--		,2.00
--		,'CCAB'
--		,'Real'
--		,'Vl. Unit.'
--		,1.56
--		)
--
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente A001'
--		,'Agente A - 001'
--		,2
--		,'Produto 2'
--		,2.00
--		,'CCAB'
--		,'Real'
--		,'Vl. Total.'
--		,1.56
--		)
--
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente A001'
--		,'Agente A - 001'
--		,3
--		,'Produto 3'
--		,5.80
--		,'CCAB'
--		,'Real'
--		,'Qtde.'
--		,2.67
--		)
--
--
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente A001'
--		,'Agente A - 001'
--		,3
--		,'Produto 3'
--		,5.80
--		,'CCAB'
--		,'Real'
--		,'Vl. Unit.'
--		,2.67
--		)
--
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente A001'
--		,'Agente A - 001'
--		,3
--		,'Produto 3'
--		,5.80
--		,'CCAB'
--		,'Real'
--		,'Vl. Total.'
--		,2.67
--		)
--
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente B002'
--		,'Agente B - 002'
--		,5
--		,'Produto 5'
--		,1.00
--		,'CCAB'
--		,'Real'
--		,'Qtde.'
--		,1
--		)
--
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente B002'
--		,'Agente B - 002'
--		,5
--		,'Produto 5'
--		,1.00
--		,'CCAB'
--		,'Real'
--		,'Vl. Unit.'
--		,1
--		)
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente B002'
--		,'Agente B - 002'
--		,5
--		,'Produto 5'
--		,1.00
--		,'CCAB'
--		,'Real'
--		,'Vl. Total.'
--		,1
--		)
--
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente C003'
--		,'Agente C - 003'
--		,6
--		,'Produto 6'
--		,1.00
--		,'CCAB'
--		,'Real'
--		,'Qtde.'
--		,18
--		)
--
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente C003'
--		,'Agente C - 003'
--		,6
--		,'Produto 6'
--		,1.00
--		,'CCAB'
--		,'Real'
--		,'Vl. Unit.'
--		,18
--		)
--
--
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente C003'
--		,'Agente C - 003'
--		,6
--		,'Produto 6'
--		,1.00
--		,'CCAB'
--		,'Real'
--		,'Vl. Total.'
--		,18
--		)
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente C003'
--		,'Agente C - 003'
--		,6
--		,'Produto 6'
--		,1.00
--		,'Empresa J'
--		,'Real'
--		,'Qtde.'
--		,178
--		)
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente C003'
--		,'Agente C - 003'
--		,6
--		,'Produto 6'
--		,1.00
--		,'Empresa J'
--		,'Real'
--		,'Vl. Unit.'
--		,178
--		)
--
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente C003'
--		,'Agente C - 003'
--		,6
--		,'Produto 6'
--		,1.00
--		,'Empresa J'
--		,'Real'
--		,'Vl. Total.'
--		,178
--		)
--
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente C003'
--		,'Agente C - 003'
--		,6
--		,'Produto 6'
--		,1.00
--		,'Empresa J'
--		,'Euro'
--		,'Qtde.'
--		,700
--		)
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente C003'
--		,'Agente C - 003'
--		,6
--		,'Produto 6'
--		,1.00
--		,'Empresa J'
--		,'Euro'
--		,'Vl. Unit.'
--		,700
--		)
--
--	insert into #Retorno 
--		(
--		 cdAgrupamentoAgente			
--		,dsAgrupamentoAgente	
--		,cdProdutoSEQ
--		,dsProduto
--		,qtEmbalagemProduto
--		,dsOrigemFaturamento
--		,dsMoeda
--		,dsQuantidade
--		,vrConteudo
--		)		
--		values
--		(
--		 'Agente C003'
--		,'Agente C - 003'
--		,6
--		,'Produto 6'
--		,1.00
--		,'Empresa J'
--		,'Euro'
--		,'Vl. Total.'
--		,700
--		)

	--Apresento o conteúdo da Tabela Temporária de Retorno
	select
		*
	from
		#Retorno


	--Apago a Tabela Temporária de Agente
	delete #Agente

	--Apago a Tabela Temporária de Retorno
	delete #Retorno

	set nocount off