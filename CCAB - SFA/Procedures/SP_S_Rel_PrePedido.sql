set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_Rel_PrePedido.sql
**		Name: SP_S_Rel_PrePedido
**		Desc: Disponibiliza dados para o Relatório de Pré-Pedido
**
**		Auth: Roberto Carlos
**		Date: 18/06/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_Rel_PrePedido]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_Rel_PrePedido]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_Rel_PrePedido]
	 @TipoRelatorio								varchar(1)

	,@cdPedidoVendaSEQ							bigint
	,@cdPedidoVendaERPSEQ						bigint

	,@cdAgenteComercialCooperativaPedidoVenda	bigint	
	,@cdCronogramaSafraSEQ						bigint  
	,@cdClienteFaturamentoPedidoVenda			bigint	
	,@cdClienteEntregaPedidoVenda				bigint	
	,@cdIndicadorMoedaPedidoVenda				int		
	,@cdIndicadorStatusPedidoVenda				int		
	,@cdPessoaOrigemFaturamento					bigint  
  
AS
	

	set nocount on 

	declare
		 @Fetch_PrePedido							int
		,@Fetch_Produto								int

	declare
		 @enLogradouroEnderecoCCABPessoa			varchar(100)
		,@enComplementoEnderecoCCABPessoa			varchar(30)
		,@enBairroEnderecoCCABPessoa				varchar(70)
		,@nuCEPEnderecoCCABPessoa					varchar(8)
		,@enMunicipioEnderecoCCABPessoa				varchar(70)
		,@cdSiglaEstadoEnderecoCCABPessoa			varchar(5)

		,@enLogradouroEnderecoPrincipalPessoa		varchar(100)
		,@enComplementoEnderecoPrincipalPessoa		varchar(30)
		,@enBairroEnderecoPrincipalPessoa			varchar(70)
		,@nuCEPEnderecoPrincipalPessoa				varchar(8)
		,@enMunicipioEnderecoPrincipalPessoa		varchar(70)
		,@cdSiglaEstadoEnderecoPrincipalPessoa		varchar(5)

		,@dtEmissaoPedidoVenda						datetime
		,@cdPedidoVendaERPUsuario					varchar(30)
		,@cdPedidoVendaERP							varchar(30)

		,@nmPessoaCooperativa						varchar(70)

		,@cdPessoaERPCliente						varchar(30)
		,@nmPessoaCliente							varchar(70)
		,@nuCNPJCPFPessoaCliente					varchar(30)
		,@nuInscricaoEstadualPessoa					varchar(30)

		,@enLogradouroEnderecoCobrancaPessoa		varchar(100)
		,@enComplementoEnderecoCobrancaPessoa		varchar(30)
		,@enBairroEnderecoCobrancaPessoa			varchar(70)
		,@nuCEPEnderecoCobrancaPessoa				varchar(8)
		,@enMunicipioEnderecoCobrancaPessoa			varchar(70)
		,@cdSiglaEstadoEnderecoCobrancaPessoa		varchar(5)

		,@enLogradouroEnderecoEntregaPessoa			varchar(100)
		,@enComplementoEnderecoEntregaPessoa		varchar(30)
		,@enBairroEnderecoEntregaPessoa				varchar(70)
		,@nuCEPEnderecoEntregaPessoa				varchar(8)
		,@enMunicipioEnderecoEntregaPessoa			varchar(70)
		,@cdSiglaEstadoEnderecoEntregaPessoa		varchar(5)

		,@dsVenctoPedidoVendaERP					varchar(10)
		,@dsIndicadorMoedaPedidoVenda				varchar(100)

		,@cdProdutoERP								varchar(30)
		,@qtEmbalagemProduto						numeric(22,6)
		,@dsProduto									varchar(70)
		,@dtAnoMesPedidoVendaItemEntrega			datetime
		,@vrUnitarioMoedaPedidoVendaERPItem			numeric(22,4)
		,@qtPedidoVendaERPItem						numeric(22,4)
		,@vrTotalMoedaPedidoVendaERPItem			numeric(22,4)




	--Tabela Temporária Principal
	create table #PrePedido
		(
		 cdPedidoVendaERPSEQ					bigint

		,enLogradouroEnderecoCCABPessoa			varchar(100)
		,enComplementoEnderecoCCABPessoa		varchar(30)
		,enBairroEnderecoCCABPessoa				varchar(70)
		,nuCEPEnderecoCCABPessoa				varchar(8)
		,enMunicipioEnderecoCCABPessoa			varchar(70)
		,cdSiglaEstadoEnderecoCCABPessoa		varchar(5)

		,enLogradouroEnderecoPrincipalPessoa	varchar(100)
		,enComplementoEnderecoPrincipalPessoa	varchar(30)
		,enBairroEnderecoPrincipalPessoa		varchar(70)
		,nuCEPEnderecoPrincipalPessoa			varchar(8)
		,enMunicipioEnderecoPrincipalPessoa		varchar(70)
		,cdSiglaEstadoEnderecoPrincipalPessoa	varchar(5)

		,dtEmissaoPedidoVenda					datetime
		,cdPedidoVendaERPUsuario				varchar(30)
		,cdPedidoVendaERP						varchar(30)

		,nmPessoaCooperativa					varchar(70)

		,cdPessoaERPCliente						varchar(30)
		,nmPessoaCliente						varchar(70)
		,nuCNPJCPFPessoaCliente					varchar(30)
		,nuInscricaoEstadualPessoa				varchar(30)

		,enLogradouroEnderecoCobrancaPessoa		varchar(100)
		,enComplementoEnderecoCobrancaPessoa	varchar(30)
		,enBairroEnderecoCobrancaPessoa			varchar(70)
		,nuCEPEnderecoCobrancaPessoa			varchar(8)
		,enMunicipioEnderecoCobrancaPessoa		varchar(70)
		,cdSiglaEstadoEnderecoCobrancaPessoa	varchar(5)

		,enLogradouroEnderecoEntregaPessoa		varchar(100)
		,enComplementoEnderecoEntregaPessoa		varchar(30)
		,enBairroEnderecoEntregaPessoa			varchar(70)
		,nuCEPEnderecoEntregaPessoa				varchar(8)
		,enMunicipioEnderecoEntregaPessoa		varchar(70)
		,cdSiglaEstadoEnderecoEntregaPessoa		varchar(5)

		,dsVenctoPedidoVendaERP					varchar(10)
		,dsIndicadorMoedaPedidoVenda			varchar(100)

		,cdProdutoERP							varchar(30)
		,qtEmbalagemProduto						numeric(22,6)
		,dsProduto								varchar(70)
		,dtAnoMesPedidoVendaItemEntrega			datetime
		,vrUnitarioMoedaPedidoVendaERPItem		numeric(22,4)
		,qtPedidoVendaERPItem					numeric(22,4)
		,vrTotalMoedaPedidoVendaERPItem			numeric(22,4)

		)


		
	--Tabela Temporária do Filtro
	create table #PedidoVendaERP
		(cdPedidoVendaERPSEQ			bigint)
		



	--@TipoRelatorio
		-- T = Todos
		-- S = Selecionado
		-- F = Filtro da Tela Principal


	if @TipoRelatorio = 'T'
	begin
		insert into #PedidoVendaERP
			(cdPedidoVendaERPSEQ)
		select
			cdPedidoVendaERPSEQ
		from
			dbo.PedidoVendaERP
		where
			cdPedidoVendaSEQ	= @cdPedidoVendaSEQ
	end

	if @TipoRelatorio = 'S'
	begin
		insert into #PedidoVendaERP
			(cdPedidoVendaERPSEQ)
		select
			cdPedidoVendaERPSEQ
		from
			dbo.PedidoVendaERP
		where
			cdPedidoVendaERPSEQ	= @cdPedidoVendaERPSEQ
	end


	if @TipoRelatorio = 'F'
	begin

		insert into #PedidoVendaERP
			(cdPedidoVendaERPSEQ)
		exec SP_G_PedidoVenda_PrePedido
			 @cdAgenteComercialCooperativaPedidoVenda	= @cdAgenteComercialCooperativaPedidoVenda
			,@cdCronogramaSafraSEQ						= @cdCronogramaSafraSEQ
			,@cdClienteFaturamentoPedidoVenda			= @cdClienteFaturamentoPedidoVenda
			,@cdClienteEntregaPedidoVenda				= @cdClienteEntregaPedidoVenda
			,@cdIndicadorMoedaPedidoVenda				= @cdIndicadorMoedaPedidoVenda	
			,@cdIndicadorStatusPedidoVenda				= @cdIndicadorStatusPedidoVenda		
			,@cdPessoaOrigemFaturamento					= @cdPessoaOrigemFaturamento
			,@cdPedidoVendaSEQ							= @cdPedidoVendaSEQ

	end



	--RODO O CURSOR PARA POPULAR A TEMPORÁRIA PRINCIPAL
	DECLARE CS_PrePedido CURSOR FOR
		select
			 ERP.cdPedidoVendaERPSEQ
			,ERP.cdPedidoVendaSEQ
			,PED.cdClienteFaturamentoPedidoVenda
			,PED.cdClienteEntregaPedidoVenda
			,PED.dtEmissaoPedidoVenda
			,ERP.cdPedidoVendaERPUsuario
			,ERP.cdPedidoVendaERP
			,PED.cdIndicadorMoedaPedidoVenda
			,PED.cdAgenteComercialCooperativaPedidoVenda
			,isnull(convert(varchar, ERP.dtVenctoPedidoVendaERP, 103), 'À Vista')	as dsVenctoPedidoVendaERP
		from
			dbo.PedidoVendaERP	ERP
		inner join
			dbo.PedidoVenda		PED
		on 
			ERP.cdPedidoVendaSEQ	= PED.cdPedidoVendaSEQ


		where
			ERP.cdPedidoVendaERPSEQ	in (
									select
										cdPedidoVendaERPSEQ
									from
										#PedidoVendaERP
									)

	OPEN CS_PrePedido
	FETCH NEXT FROM CS_PrePedido
	INTO	
		 @cdPedidoVendaERPSEQ
		,@cdPedidoVendaSEQ
		,@cdClienteFaturamentoPedidoVenda
		,@cdClienteEntregaPedidoVenda
		,@dtEmissaoPedidoVenda
		,@cdPedidoVendaERPUsuario
		,@cdPedidoVendaERP
		,@cdIndicadorMoedaPedidoVenda
		,@cdAgenteComercialCooperativaPedidoVenda
		,@dsVenctoPedidoVendaERP
					
	SET @Fetch_PrePedido = @@FETCH_STATUS
	
	WHILE @Fetch_PrePedido = 0
	BEGIN

		--Obtenho os dados Principais
		select
			 @nmPessoaCliente							= nmPessoa		
			,@cdPessoaERPCliente						= cdPessoaERP			
			,@nuCNPJCPFPessoaCliente					= nuCNPJCPFPessoa				
			,@nuInscricaoEstadualPessoa					= nuInscricaoEstadualPessoa

			,@enLogradouroEnderecoPrincipalPessoa		= enLogradouroEnderecoPrincipalPessoa
			,@enComplementoEnderecoPrincipalPessoa		= enComplementoEnderecoPrincipalPessoa
			,@enBairroEnderecoPrincipalPessoa			= enBairroEnderecoPrincipalPessoa
			,@nuCEPEnderecoPrincipalPessoa				= nuCEPEnderecoPrincipalPessoa		
			,@enMunicipioEnderecoPrincipalPessoa		= enMunicipioEnderecoPrincipalPessoa	
			,@cdSiglaEstadoEnderecoPrincipalPessoa		= cdSiglaEstadoEnderecoPrincipalPessoa

			,@enLogradouroEnderecoCobrancaPessoa		= enLogradouroEnderecoCobrancaPessoa
			,@enComplementoEnderecoCobrancaPessoa		= enComplementoEnderecoCobrancaPessoa
			,@enBairroEnderecoCobrancaPessoa			= enBairroEnderecoCobrancaPessoa
			,@nuCEPEnderecoCobrancaPessoa				= nuCEPEnderecoCobrancaPessoa
			,@enMunicipioEnderecoCobrancaPessoa			= enMunicipioEnderecoCobrancaPessoa
			,@cdSiglaEstadoEnderecoCobrancaPessoa		= cdSiglaEstadoEnderecoCobrancaPessoa

		from
			dbo.Pessoa	
		where
			cdPessoaSEQ		=  @cdClienteFaturamentoPedidoVenda
			

		--Obtenho os dados da Cooperativa (Vendedor)
		select
			@nmPessoaCooperativa	= nmPessoa
		from
			dbo.Pessoa
		where
			cdPessoaSEQ				= @cdAgenteComercialCooperativaPedidoVenda



		--Obtenho os dados de Entrega
		select
			 @enLogradouroEnderecoEntregaPessoa			= enLogradouroEnderecoEntregaPessoa
			,@enComplementoEnderecoEntregaPessoa		= enComplementoEnderecoEntregaPessoa
			,@enBairroEnderecoEntregaPessoa				= enBairroEnderecoEntregaPessoa
			,@nuCEPEnderecoEntregaPessoa				= nuCEPEnderecoEntregaPessoa
			,@enMunicipioEnderecoEntregaPessoa			= enMunicipioEnderecoEntregaPessoa
			,@cdSiglaEstadoEnderecoEntregaPessoa		= cdSiglaEstadoEnderecoEntregaPessoa

		from
			dbo.Pessoa	
		where
			cdPessoaSEQ		=  @cdClienteEntregaPedidoVenda
	


		--Obtenho a Moeda do Pedido
		select
			@dsIndicadorMoedaPedidoVenda = wkDominioCodigoReferenciado
		from
			dbo.CodigoReferenciado
		where
			dsDominioCodigoReferenciado = 'DMESPINDICADORMOEDA'
		and	vrDominioCodigoReferenciado = @cdIndicadorMoedaPedidoVenda


		--RODO O CURSOR DE PRODUTOS
		DECLARE CS_Produto CURSOR FOR
			select
				 ERP.dtAnoMesPedidoVendaItemEntrega
				,PRO.cdProdutoERP
				,PRO.qtEmbalagemProduto                      
				,PRO.dsProduto                                                              
				,ERP.vrUnitarioMoedaPedidoVendaERPItem
				,ERP.qtPedidoVendaERPItem
				,ERP.vrTotalMoedaPedidoVendaERPItem

			from
				dbo.PedidoVendaERPItem	ERP
			inner join
				dbo.Produto				PRO
			on 
				ERP.cdProdutoSEQ	= PRO.cdProdutoSEQ
			where
				ERP.cdPedidoVendaERPSEQ		= @cdPedidoVendaERPSEQ

		OPEN CS_Produto
		FETCH NEXT FROM CS_Produto
		INTO	
			 @dtAnoMesPedidoVendaItemEntrega
			,@cdProdutoERP
			,@qtEmbalagemProduto                      
			,@dsProduto                                                              
			,@vrUnitarioMoedaPedidoVendaERPItem
			,@qtPedidoVendaERPItem
			,@vrTotalMoedaPedidoVendaERPItem
						
		SET @Fetch_Produto = @@FETCH_STATUS
		
		WHILE @Fetch_Produto = 0
		BEGIN


			--Inserção da Temporária
			insert into #PrePedido 
				(
				 cdPedidoVendaERPSEQ					

				,enLogradouroEnderecoCCABPessoa	
				,enComplementoEnderecoCCABPessoa	
				,enBairroEnderecoCCABPessoa		
				,nuCEPEnderecoCCABPessoa			
				,enMunicipioEnderecoCCABPessoa		
				,cdSiglaEstadoEnderecoCCABPessoa	

				,enLogradouroEnderecoPrincipalPessoa	
				,enComplementoEnderecoPrincipalPessoa	
				,enBairroEnderecoPrincipalPessoa		
				,nuCEPEnderecoPrincipalPessoa			
				,enMunicipioEnderecoPrincipalPessoa		
				,cdSiglaEstadoEnderecoPrincipalPessoa	

				,dtEmissaoPedidoVenda					
				,cdPedidoVendaERPUsuario				
				,cdPedidoVendaERP						

				,nmPessoaCooperativa					

				,cdPessoaERPCliente						
				,nmPessoaCliente						
				,nuCNPJCPFPessoaCliente					
				,nuInscricaoEstadualPessoa				

				,enLogradouroEnderecoCobrancaPessoa		
				,enComplementoEnderecoCobrancaPessoa	
				,enBairroEnderecoCobrancaPessoa			
				,nuCEPEnderecoCobrancaPessoa			
				,enMunicipioEnderecoCobrancaPessoa		
				,cdSiglaEstadoEnderecoCobrancaPessoa	

				,enLogradouroEnderecoEntregaPessoa		
				,enComplementoEnderecoEntregaPessoa		
				,enBairroEnderecoEntregaPessoa			
				,nuCEPEnderecoEntregaPessoa				
				,enMunicipioEnderecoEntregaPessoa		
				,cdSiglaEstadoEnderecoEntregaPessoa		

				,dsVenctoPedidoVendaERP
				,dsIndicadorMoedaPedidoVenda			

				,cdProdutoERP							
				,qtEmbalagemProduto						
				,dsProduto								
				,dtAnoMesPedidoVendaItemEntrega			
				,vrUnitarioMoedaPedidoVendaERPItem	
				,qtPedidoVendaERPItem
				,vrTotalMoedaPedidoVendaERPItem
				)
			values
				(
				 @cdPedidoVendaERPSEQ	
					
				,'ROD BR 163 KM 119.5, 0' --@enLogradouroEnderecoCCABPessoa	
				,'SALA 2' --@enComplementoEnderecoCCABPessoa	
				,'DIST.IND.VETORASSO' --@enBairroEnderecoCCABPessoa		
				,'78740275' --@nuCEPEnderecoCCABPessoa			
				,'RONDONÓPOLIS' --@enMunicipioEnderecoCCABPessoa		
				,'MT' --@cdSiglaEstadoEnderecoCCABPessoa	

				,@enLogradouroEnderecoPrincipalPessoa	
				,@enComplementoEnderecoPrincipalPessoa	
				,@enBairroEnderecoPrincipalPessoa		
				,@nuCEPEnderecoPrincipalPessoa			
				,@enMunicipioEnderecoPrincipalPessoa		
				,@cdSiglaEstadoEnderecoPrincipalPessoa	

				,@dtEmissaoPedidoVenda					
				,@cdPedidoVendaERPUsuario				
				,@cdPedidoVendaERP						

				,@nmPessoaCooperativa					

				,@cdPessoaERPCliente						
				,@nmPessoaCliente						
				,@nuCNPJCPFPessoaCliente					
				,@nuInscricaoEstadualPessoa				

				,@enLogradouroEnderecoCobrancaPessoa		
				,@enComplementoEnderecoCobrancaPessoa	
				,@enBairroEnderecoCobrancaPessoa			
				,@nuCEPEnderecoCobrancaPessoa			
				,@enMunicipioEnderecoCobrancaPessoa		
				,@cdSiglaEstadoEnderecoCobrancaPessoa	

				,@enLogradouroEnderecoEntregaPessoa		
				,@enComplementoEnderecoEntregaPessoa		
				,@enBairroEnderecoEntregaPessoa			
				,@nuCEPEnderecoEntregaPessoa				
				,@enMunicipioEnderecoEntregaPessoa		
				,@cdSiglaEstadoEnderecoEntregaPessoa		

				,@dsVenctoPedidoVendaERP
				,@dsIndicadorMoedaPedidoVenda			

				,@cdProdutoERP							
				,@qtEmbalagemProduto						
				,@dsProduto								
				,@dtAnoMesPedidoVendaItemEntrega			
				,@vrUnitarioMoedaPedidoVendaERPItem	
				,@qtPedidoVendaERPItem
				,@vrTotalMoedaPedidoVendaERPItem
				)





			FETCH NEXT FROM CS_Produto
			INTO	
				 @dtAnoMesPedidoVendaItemEntrega
				,@cdProdutoERP
				,@qtEmbalagemProduto                      
				,@dsProduto                                                              
				,@vrUnitarioMoedaPedidoVendaERPItem
				,@qtPedidoVendaERPItem
				,@vrTotalMoedaPedidoVendaERPItem
				

						
			SET @Fetch_Produto = @@FETCH_STATUS
						
		END	
		
		CLOSE CS_Produto
		DEALLOCATE CS_Produto		





		FETCH NEXT FROM CS_PrePedido
		INTO	
			 @cdPedidoVendaERPSEQ
			,@cdPedidoVendaSEQ
			,@cdClienteFaturamentoPedidoVenda
			,@cdClienteEntregaPedidoVenda
			,@dtEmissaoPedidoVenda
			,@cdPedidoVendaERPUsuario
			,@cdPedidoVendaERP
			,@cdIndicadorMoedaPedidoVenda
			,@cdAgenteComercialCooperativaPedidoVenda
			,@dsVenctoPedidoVendaERP
					
		SET @Fetch_PrePedido = @@FETCH_STATUS
					
	END	
	
	CLOSE CS_PrePedido
	DEALLOCATE CS_PrePedido		

	
	-- RETIRADO A PEDIDO DE MARISA 
	----Insiro uma linha em branco em cada cdPedidoVendaERPSEQ para resolver o problema do relatório
	--insert into	#PrePedido
	--	(cdPedidoVendaERPSEQ
	--	,enLogradouroEnderecoCCABPessoa                                                                       
	--	,enComplementoEnderecoCCABPessoa 
	--	,enBairroEnderecoCCABPessoa                                             
	--	,nuCEPEnderecoCCABPessoa 
	--	,enMunicipioEnderecoCCABPessoa                                          
	--	,cdSiglaEstadoEnderecoCCABPessoa 
	--	,enLogradouroEnderecoPrincipalPessoa                                                                  
	--	,enComplementoEnderecoPrincipalPessoa 
	--	,enBairroEnderecoPrincipalPessoa                                        
	--	,nuCEPEnderecoPrincipalPessoa 
	--	,enMunicipioEnderecoPrincipalPessoa                                     
	--	,cdSiglaEstadoEnderecoPrincipalPessoa 
	--	,dtEmissaoPedidoVenda    
	--	,cdPedidoVendaERPUsuario        
	--	,cdPedidoVendaERP               
	--	,nmPessoaCooperativa                                                    
	--	,cdPessoaERPCliente             
	--	,nmPessoaCliente                                                        
	--	,nuCNPJCPFPessoaCliente         
	--	,nuInscricaoEstadualPessoa      
	--	,enLogradouroEnderecoCobrancaPessoa                                                                   
	--	,enComplementoEnderecoCobrancaPessoa 
	--	,enBairroEnderecoCobrancaPessoa                                         
	--	,nuCEPEnderecoCobrancaPessoa 
	--	,enMunicipioEnderecoCobrancaPessoa                                      
	--	,cdSiglaEstadoEnderecoCobrancaPessoa 
	--	,enLogradouroEnderecoEntregaPessoa                                                                    
	--	,enComplementoEnderecoEntregaPessoa 
	--	,enBairroEnderecoEntregaPessoa                                          
	--	,nuCEPEnderecoEntregaPessoa 
	--	,enMunicipioEnderecoEntregaPessoa                                       
	--	,cdSiglaEstadoEnderecoEntregaPessoa 
	--	,dsVenctoPedidoVendaERP
	--	,dsIndicadorMoedaPedidoVenda
	--	,cdProdutoERP
	--	,qtEmbalagemProduto
	--	,dsProduto
	--	,dtAnoMesPedidoVendaItemEntrega
	--	,vrUnitarioMoedaPedidoVendaERPItem       
	--	,qtPedidoVendaERPItem                    
	--	,vrTotalMoedaPedidoVendaERPItem

	--	)


	--select
	--	 cdPedidoVendaERPSEQ
	--	,max(enLogradouroEnderecoCCABPessoa)                                                                       
	--	,max(enComplementoEnderecoCCABPessoa) 
	--	,max(enBairroEnderecoCCABPessoa)                                             
	--	,max(nuCEPEnderecoCCABPessoa) 
	--	,max(enMunicipioEnderecoCCABPessoa)                                          
	--	,max(cdSiglaEstadoEnderecoCCABPessoa) 
	--	,max(enLogradouroEnderecoPrincipalPessoa)                                                                  
	--	,max(enComplementoEnderecoPrincipalPessoa) 
	--	,max(enBairroEnderecoPrincipalPessoa)                                        
	--	,max(nuCEPEnderecoPrincipalPessoa) 
	--	,max(enMunicipioEnderecoPrincipalPessoa)                                     
	--	,max(cdSiglaEstadoEnderecoPrincipalPessoa) 
	--	,max(dtEmissaoPedidoVenda)    
	--	,max(cdPedidoVendaERPUsuario)        
	--	,max(cdPedidoVendaERP)               
	--	,max(nmPessoaCooperativa)                                                    
	--	,max(cdPessoaERPCliente)             
	--	,max(nmPessoaCliente)                                                        
	--	,max(nuCNPJCPFPessoaCliente)         
	--	,max(nuInscricaoEstadualPessoa)      
	--	,max(enLogradouroEnderecoCobrancaPessoa)                                                                   
	--	,max(enComplementoEnderecoCobrancaPessoa) 
	--	,max(enBairroEnderecoCobrancaPessoa)                                         
	--	,max(nuCEPEnderecoCobrancaPessoa) 
	--	,max(enMunicipioEnderecoCobrancaPessoa)                                      
	--	,max(cdSiglaEstadoEnderecoCobrancaPessoa) 
	--	,max(enLogradouroEnderecoEntregaPessoa)                                                                    
	--	,max(enComplementoEnderecoEntregaPessoa) 
	--	,max(enBairroEnderecoEntregaPessoa)                                          
	--	,max(nuCEPEnderecoEntregaPessoa) 
	--	,max(enMunicipioEnderecoEntregaPessoa)                                       
	--	,max(cdSiglaEstadoEnderecoEntregaPessoa) 
	--	,max(dsVenctoPedidoVendaERP) 
	--	,max(dsIndicadorMoedaPedidoVenda)
	--	,null
	--	,null
	--	,null
	--	,null
	--	,null
	--	,null
	--	,null

	--from
	--	#PrePedido
	--group by
	--	cdPedidoVendaERPSEQ



	select
		*
	from
		#PrePedido


	set nocount off