SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_J_AtualizaDadosAgenteComercialMicrosiga]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_J_AtualizaDadosAgenteComercialMicrosiga]
END
GO


CREATE PROCEDURE SP_J_AtualizaDadosAgenteComercialMicrosiga
	
AS

	BEGIN

		--Variaveis MICROSIGA												-- (SA3010)					
		DECLARE @cdPessoaERP								varchar(30)		-- A3_COD
		DECLARE @cdIndicadorStatusPessoaERP					int				-- 
		DECLARE @cdIndicadorPessoaERP						int				--
		DECLARE @nmPessoaERP								varchar(70)		-- A3_NOME
		DECLARE @nmReduzidoPessoaERP						varchar(30)		-- A3_NREDUZ
		DECLARE @nuCNPJCPFPessoaERP							varchar(30)		-- A3_CGC
		DECLARE @nuInscricaoEstadualPessoaERP				varchar(30)		-- A3_INSCR
		DECLARE @nuInscricaoMunicipalPessoaERP				varchar(30)		-- A3_INSCRM
		DECLARE @nuInscricaoRuralPessoaERP					varchar(30)		--	
		DECLARE @nuRGCedulaEstrangeiroPessoaERP				varchar(30)		-- 
		DECLARE @cdNacionalidadePessoaERP					int				--
		DECLARE @dtNascimentoPessoaERP						datetime		-- 
		DECLARE @cdIndicadorSexoPessoaERP					int				--
		DECLARE @cdIndicadorEstadoCivilPessoaERP			int				--
		DECLARE @cdPaisEnderecoPrincipalPessoaERP			int				--
		DECLARE @enLogradouroEnderecoPrincipalPessoaERP		varchar(100)	-- A3_END
		DECLARE @enComplementoEnderecoPrincipalPessoaERP	varchar(30)		--
		DECLARE @enBairroEnderecoPrincipalPessoaERP			varchar(70)		-- A3_BAIRRO
		DECLARE @enMunicipioEnderecoPrincipalPessoaERP		varchar(70)		-- A3_MUN
		DECLARE @cdSiglaEstadoEnderecoPrincipalPessoaERP	varchar(05)		-- A3_EST
		DECLARE @nuCEPEnderecoPrincipalPessoaERP			varchar(08)		-- A3_CEP
		DECLARE @nuCaixaPostalEnderecoPrincipalPessoaERP	varchar(30)		-- 
		DECLARE @enReferenciaEnderecoPrincipalPessoaERP		varchar(30)		--
		DECLARE @cdPaisEnderecoCobrancaPessoaERP			int				--
		DECLARE @enLogradouroEnderecoCobrancaPessoaERP		varchar(100)	--       
		DECLARE @enComplementoEnderecoCobrancaPessoaERP		varchar(30)		--		
		DECLARE @enBairroEnderecoCobrancaPessoaERP			varchar(70)		--          
		DECLARE @enMunicipioEnderecoCobrancaPessoaERP		varchar(70)		--       
		DECLARE @cdSiglaEstadoEnderecoCobrancaPessoaERP		varchar(05)		--       
		DECLARE @nuCEPEnderecoCobrancaPessoaERP				varchar(08)		--       
		DECLARE @nuCaixaPostalEnderecoCobrancaPessoaERP		varchar(30)		-- 
		DECLARE @enReferenciaEnderecoCobrancaPessoaERP		varchar(30)		--
		DECLARE @cdPaisEnderecoEntregaPessoaERP				int				--
		DECLARE @enLogradouroEnderecoEntregaPessoaERP		varchar(100)	--       
		DECLARE @enComplementoEnderecoEntregaPessoaERP		varchar(30)		--				
		DECLARE @enBairroEnderecoEntregaPessoaERP			varchar(70)		--          
		DECLARE @enMunicipioEnderecoEntregaPessoaERP		varchar(70)		--       
		DECLARE @cdSiglaEstadoEnderecoEntregaPessoaERP		varchar(05)		--       
		DECLARE @nuCEPEnderecoEntregaPessoaERP				varchar(08)		--       
		DECLARE @nuCaixaPostalEnderecoEntregaPessoaERP		varchar(30)		-- 
		DECLARE @enReferenciaEnderecoEntregaPessoaERP		varchar(30)		--
		DECLARE @cdPaisTelefonePrincipalPessoaERP			int				-- 
		DECLARE @nuDDDTelefonePrincipalPessoaERP			varchar(05)		-- A3_DDDTEL
		DECLARE @nuTelefonePrincipalPessoaERP				varchar(30)		-- A3_TEL
		DECLARE @cdPaisTelefoneFAXPessoaERP					int				-- 
		DECLARE @nuDDDTelefoneFAXPessoaERP					varchar(05)		--          
		DECLARE @nuTelefoneFAXPessoaERP						varchar(30)		-- A3_FAX
		DECLARE @cdPaisTelefoneCelularPessoaERP				int				-- 
		DECLARE @nuDDDTelefoneCelularPessoaERP				varchar(05)		--          
		DECLARE @nuTelefoneCelularPessoaERP					varchar(30)		-- 
		DECLARE @enEmailPrincipalPessoaERP					varchar(70)		-- A3_EMAIL
		DECLARE @nmContatoPrincipalPessoaERP				varchar(30)		-- 
		DECLARE @nmContatoCobrancaPessoaERP					varchar(30)		-- 
		DECLARE @cdIndicadorTipoAgenteComercialPessoaERP	int				-- A3_TIPVEND
		DECLARE @cdRecnoMicrosigaERP						bigint			-- Recno Microsiga
		
		-- Variaveis de Comparação
		DECLARE @cdPessoaSEQ								bigint
		DECLARE @cdIndicadorStatusPessoa   					int				   
		DECLARE @cdIndicadorPessoa   						int				  
		DECLARE @nmPessoa   								varchar(70)		          
		DECLARE @nmReduzidoPessoa   						varchar(30)		            
		DECLARE @nuCNPJCPFPessoa   							varchar(30)		         
		DECLARE @nuInscricaoEstadualPessoa   				varchar(30)		           
		DECLARE @nuInscricaoMunicipalPessoa   				varchar(30)		            
		DECLARE @nuInscricaoRuralPessoa   					varchar(30)		  	
		DECLARE @nuRGCedulaEstrangeiroPessoa   				varchar(30)		   
		DECLARE @cdNacionalidadePessoa   					varchar(30)		  
		DECLARE @dtNascimentoPessoa   						datetime		   
		DECLARE @cdIndicadorSexoPessoa   					int				  
		DECLARE @cdIndicadorEstadoCivilPessoa   			int				  
		DECLARE @cdPaisEnderecoPrincipalPessoa   			int				  
		DECLARE @enLogradouroEnderecoPrincipalPessoa   		varchar(100)	         
		DECLARE @enComplementoEnderecoPrincipalPessoa   	varchar(30)		  
		DECLARE @enBairroEnderecoPrincipalPessoa   			varchar(70)		            
		DECLARE @enMunicipioEnderecoPrincipalPessoa   		varchar(70)		         
		DECLARE @cdSiglaEstadoEnderecoPrincipalPessoa   	varchar(05)		         
		DECLARE @nuCEPEnderecoPrincipalPessoa   			varchar(08)		         
		DECLARE @nuCaixaPostalEnderecoPrincipalPessoa   	varchar(30)		   
		DECLARE @enReferenciaEnderecoPrincipalPessoa   		varchar(30)		  
		DECLARE @cdPaisEnderecoCobrancaPessoa   			int				  
		DECLARE @enLogradouroEnderecoCobrancaPessoa   		varchar(100)	         
		DECLARE @enComplementoEnderecoCobrancaPessoa   		varchar(30)		  		
		DECLARE @enBairroEnderecoCobrancaPessoa   			varchar(70)		            
		DECLARE @enMunicipioEnderecoCobrancaPessoa   		varchar(70)		         
		DECLARE @cdSiglaEstadoEnderecoCobrancaPessoa   		varchar(05)		         
		DECLARE @nuCEPEnderecoCobrancaPessoa   				varchar(08)		         
		DECLARE @nuCaixaPostalEnderecoCobrancaPessoa   		varchar(30)		   
		DECLARE @enReferenciaEnderecoCobrancaPessoa   		varchar(30)		  
		DECLARE @cdPaisEnderecoEntregaPessoa   				int				  
		DECLARE @enLogradouroEnderecoEntregaPessoa   		varchar(100)	         
		DECLARE @enComplementoEnderecoEntregaPessoa   		varchar(30)		  				
		DECLARE @enBairroEnderecoEntregaPessoa   			varchar(70)		            
		DECLARE @enMunicipioEnderecoEntregaPessoa   		varchar(70)		         
		DECLARE @cdSiglaEstadoEnderecoEntregaPessoa   		varchar(05)		         
		DECLARE @nuCEPEnderecoEntregaPessoa   				varchar(08)		         
		DECLARE @nuCaixaPostalEnderecoEntregaPessoa   		varchar(30)		   
		DECLARE @enReferenciaEnderecoEntregaPessoa   		varchar(30)		  
		DECLARE @cdPaisTelefonePrincipalPessoa   			int				   
		DECLARE @nuDDDTelefonePrincipalPessoa   			varchar(05)		            
		DECLARE @nuTelefonePrincipalPessoa   				varchar(30)		         
		DECLARE @cdPaisTelefoneFAXPessoa   					int				   
		DECLARE @nuDDDTelefoneFAXPessoa   					varchar(05)		            
		DECLARE @nuTelefoneFAXPessoa   						varchar(30)		         
		DECLARE @cdPaisTelefoneCelularPessoa   				int				   
		DECLARE @nuDDDTelefoneCelularPessoa   				varchar(05)		            
		DECLARE @nuTelefoneCelularPessoa   					varchar(30)		   
		DECLARE @enEmailPrincipalPessoa   					varchar(70)		           
		DECLARE @nmContatoPrincipalPessoa   				varchar(30)		   
		DECLARE @nmContatoCobrancaPessoa   					varchar(30)		
		DECLARE @cdIndicadorTipoAgenteComercialPessoa		int   
		DECLARE @cdRecnoMicrosiga							bigint

		DECLARE	@nmFoneticoPessoa							varchar(8000)
		
		-- Variaveis SFA
		DECLARE @Fetch_AgenteComercial				int

		-- Defini Cursor para Atualização com base no Microsiga (Inclusao e Alteracao)
		DECLARE CS_AgenteComercial CURSOR FOR
		SELECT  LTRIM(RTRIM(A3_COD))						as cdPessoaERP,								-- Código do Agente Comercial
		        CASE LTRIM(RTRIM(A3_XBLOQUE))
					WHEN 'S' THEN 2
					ELSE          1
				END											as cdIndicadorStatusPessoaERP,				-- Situação do Agente Comercial (1 - Ativo, 2 - Inativo) 
				CASE LEN(LTRIM(RTRIM(A3_CGC))) 
					WHEN '14' THEN	2 
					WHEN '11' THEN	1 
					ELSE			1 
				END											as cdIndicadorPessoaERP,					-- Tipo de Pessoa (1-Fisica, 2-Juridica) => Não achei o campo no Microsiga
				LTRIM(RTRIM(A3_NOME))						as nmPessoaERP,								-- Nome do Agente Comercial
				LTRIM(RTRIM(A3_NREDUZ))						as nmReduzidoPessoaERP,						-- Nome Reduzido do Agente Comercial
				LTRIM(RTRIM(A3_CGC))						as nuCNPJCPFPessoaERP,						-- CNPJ e/ou CPF do Agente Comercial
				LTRIM(RTRIM(A3_INSCR))						as nuInscricaoEstadualPessoaERP,				-- Numero da Inscrição Estadual do Agente Comercial
				LTRIM(RTRIM(A3_INSCRM))						as nuInscricaoMunicipalPessoaERP,  			-- Numero da Inscrição Municipal do Agente Comercial
				NULL										as nuInscricaoRuralPessoaERP,				-- Numero da Inscrição Rural do Agente Comercial => Não achei o campo no Microsiga	
				NULL										as nuRGCedulaEstrangeiroPessoaERP,			-- Numero do RG e/ou Cedula de Estrangeiro do Agente Comercial => Não achei o campo no Microsiga
				1											as cdNacionalidadePessoaERP,				-- Nacionalidade do Agente Comercial (1-Brasil/Brasileira) => Não achei o campo no Microsiga - Estou assumindo Brasil
				NULL										as dtNascimentoPessoaERP,					-- Data de Nascimento do Agente Comercial => Não achei o campo no Microsiga
				NULL										as cdIndicadorSexoPessoaERP,				-- Sexo do Agente Comercial (1-Masculino, 2-Feminino) => Não achei o campo no Microsiga
				NULL										as cdIndicadorEstadoCivilPessoaERP,			-- Estado Civil do Agente Comercial => Não achei o campo no Microsiga
				1											as cdPaisEnderecoPrincipalPessoaERP,		-- Pais do Endereco Principal do Agente Comercial (1-Brasil) => Não achei o campo no Microsiga - Estou assumindo Brasil
				LTRIM(RTRIM(A3_END))						as enLogradouroEnderecoPrincipalPessoaERP,	-- Logradouro do Endereco Principal do Agente Comercial
				NULL										as enComplementoEnderecoPrincipalPessoaERP,	-- Complemento do endereco principal do agente comercial => Não achei o campo no Microsiga
				LTRIM(RTRIM(A3_BAIRRO))						as enBairroEnderecoPrincipalPessoaERP,		-- Bairro do Endereco Principal do Agente Comercial
				LTRIM(RTRIM(A3_MUN))						as enMunicipioEnderecoPrincipalPessoaERP,	-- Municipio do endereco principal do agente comercial
				LTRIM(RTRIM(A3_EST))						as cdSiglaEstadoEnderecoPrincipalPessoaERP,	-- Sigla do Estado do endereco principal do agente comercial
				LTRIM(RTRIM(A3_CEP))						as nuCEPEnderecoPrincipalPessoaERP,			-- CEP do endereco principal do agente comercial
				NULL										as nuCaixaPostalEnderecoPrincipalPessoaERP,	-- numero da caixa postal do endereco principal do agente comercial => Nao achei o campo no Microsiga
				NULL										as enReferenciaEnderecoPrincipalPessoaERP,	-- Referencia do endereco principal do agente comercial => nao achei campo no Microsiga
				NULL										as cdPaisEnderecoCobrancaPessoaERP,			-- Pais do endereco de Cobranca do agente comercial - não achei campo no Microsiga
				NULL										as enLogradouroEnderecoCobrancaPessoaERP,	-- Logradouro do endereco de cobranca do agente comercial - não achei campo no Microsiga
				NULL										as enComplementoEnderecoCobrancaPessoaERP,	-- Complemento do Endereco de cobranca do agente comercial - não achei campo no Microsiga
				NULL										as enBairroEnderecoCobrancaPessoaERP,		-- Bairro do Endereco de cobranca do agente comercial - não achei campo no Microsiga
				NULL										as enMunicipioEnderecoCobrancaPessoaERP,	-- Municipio do Endereco de cobranca do agente comercial - não achei campo no Microsiga
				NULL										as cdSiglaEstadoEnderecoCobrancaPessoaERP,	-- Sigla do Estado do endereco de cobranca do agente comercial -Nao achei campo no Microsiga
				NULL										as nuCEPEnderecoCobrancaPessoaERP,		    -- Numero do CEP do endereco de cobranca do agente comercial - não achei campo no microsiga
				NULL										as nuCaixaPostalEnderecoCobrancaPessoaERP,	-- Numero da caixa postal do endereco de cobranca do agente comercial - não achei campo no Microsiga
				NULL										as enReferenciaEnderecoCobrancaPessoaERP,	-- Referencia do endereco de cobranca do agente comercial - não achei campo no microsiga
				NULL										as cdPaisEnderecoEntregaPessoaERP,			-- Pais do endereco de Entrega do agente comercial - não achei campo no Microsiga
				NULL										as enLogradouroEnderecoEntregaPessoaERP,	-- Logradouro do endereco de entrega do agente comercial - não achei campo no Microsiga
				NULL										as enComplementoEnderecoEntregaPessoaERP,	-- Complemento do Endereco de entrega do agente comercial - não achei campo no Microsiga
				NULL										as enBairroEnderecoEntregaPessoaERP,		-- Bairro do Endereco de entrega do agente comercial - não achei campo no Microsiga
				NULL										as enMunicipioEnderecoEntregaPessoaERP, 	-- Municipio do Endereco de entrega do agente comercial - não achei campo no Microsiga
				NULL										as cdSiglaEstadoEnderecoEntregaPessoaERP,	-- Sigla do Estado do endereco de entrega do agente comercial -Nao achei campo no Microsiga
				NULL										as nuCEPEnderecoEntregaPessoaERP,		    -- Numero do CEP do endereco de entrega do agente comercial - não achei campo no microsiga
				NULL										as nuCaixaPostalEnderecoEntregaPessoaERP,	-- Numero da caixa postal do entrega de cobranca do agente comercial - não achei campo no Microsiga
				NULL										as enReferenciaEnderecoEntregaPessoaERP,	-- Referencia do endereco de entrega do agente comercial - não achei campo no microsiga
				1											as cdPaisTelefonePrincipalPessoaERP,		-- DDI do telefone principal do agente comercial (1-Brasil/55) => Não achei campo no Microsiga - Estou assumindo como 1-Brasil 
				LTRIM(RTRIM(A3_DDDTEL))						as nuDDDTelefonePrincipalPessoaERP,			-- DDD do telefone principal do agente comercial
				LTRIM(RTRIM(A3_TEL))						as nuTelefonePrincipalPessoaERP,			-- numero do telefone principal do agente comercial
				NULL										as cdPaisTelefoneFAXPessoaERP,				-- DDI do telefone de FAX do agente comercial (1-Brasil/55) => não achei campo no microsiga
				NULL										as nuDDDTelefoneFAXPessoaERP,				-- DDD do telefone de FAX do Agente comercial => não achei campo no Microsiga
				LTRIM(RTRIM(A3_FAX))						as nuTelefoneFAXPessoaERP,					-- numero do telefone de FAX do Agente Comercial 
				NULL										as cdPaisTelefoneCelularPessoaERP,			-- DDI do telefone celular do agente comercial => nao achei campo no Microsiga
				NULL										as nuDDDTelefoneCelularPessoaERP,			-- DDD do telefone celular do agente comercial => nao achei campo no Microsiga
				NULL										as nuTelefoneCelularPessoaERP,				-- numero do telefone celular do agente comercial => nao achei campo no Microsiga
				LTRIM(RTRIM(A3_EMAIL))						as enEmailPrincipalPessoaERP,				-- Email do Agente Comercial
				NULL										as nmContatoPrincipalPessoaERP,				-- Nome do contato principal do agente comercial => nao achei campo no Microsiga
				NULL										as nmContatoCobrancaPessoaERP,				-- Nome do contato de cobranca do agente comercial => nao achei campo no Microsiga
				CASE LTRIM(RTRIM(A3_TIPVEND))
					WHEN '1' THEN 1
					WHEN '2' THEN 2
					WHEN '3' THEN 2
					ELSE          2
				END 										as cdIndicadorTipoAgenteComercialPessoaERP,	-- Tipo de Agente Comercial (1 - Cooperativa, 2 - Colaborador)
				R_E_C_N_O_									as cdRecnoMicrosiga							-- Recno Microsiga
				
		-- FROM	DADOSAP8..SA3010 
		FROM BDTSWK301.DADOSAP8.dbo.SA3010
		WHERE	D_E_L_E_T_ = ''			-- Trazer os registros Ativos do sistema
		
		OPEN CS_AgenteComercial
		FETCH NEXT FROM CS_AgenteComercial
		INTO	@cdPessoaERP,						
		        @cdIndicadorStatusPessoaERP,		
		        @cdIndicadorPessoaERP,				
		        @nmPessoaERP,						
		        @nmReduzidoPessoaERP,				
		        @nuCNPJCPFPessoaERP,				
		        @nuInscricaoEstadualPessoaERP,		
		        @nuInscricaoMunicipalPessoaERP,		
		        @nuInscricaoRuralPessoaERP,			
		        @nuRGCedulaEstrangeiroPessoaERP,	
		        @cdNacionalidadePessoaERP,		
		        @dtNascimentoPessoaERP,			
		        @cdIndicadorSexoPessoaERP,			
		        @cdIndicadorEstadoCivilPessoaERP,	
		        @cdPaisEnderecoPrincipalPessoaERP,	
		        @enLogradouroEnderecoPrincipalPessoaERP,
		        @enComplementoEnderecoPrincipalPessoaERP,
		        @enBairroEnderecoPrincipalPessoaERP,	
		        @enMunicipioEnderecoPrincipalPessoaERP,	
		        @cdSiglaEstadoEnderecoPrincipalPessoaERP,
		        @nuCEPEnderecoPrincipalPessoaERP,		
		        @nuCaixaPostalEnderecoPrincipalPessoaERP,
		        @enReferenciaEnderecoPrincipalPessoaERP,
		        @cdPaisEnderecoCobrancaPessoaERP,		
		        @enLogradouroEnderecoCobrancaPessoaERP,	
		        @enComplementoEnderecoCobrancaPessoaERP,
		        @enBairroEnderecoCobrancaPessoaERP,		
		        @enMunicipioEnderecoCobrancaPessoaERP,	
		        @cdSiglaEstadoEnderecoCobrancaPessoaERP,
		        @nuCEPEnderecoCobrancaPessoaERP,		
		        @nuCaixaPostalEnderecoCobrancaPessoaERP,
		        @enReferenciaEnderecoCobrancaPessoaERP,	
		        @cdPaisEnderecoEntregaPessoaERP,		
		        @enLogradouroEnderecoEntregaPessoaERP,	
		        @enComplementoEnderecoEntregaPessoaERP,	
		        @enBairroEnderecoEntregaPessoaERP,		
		        @enMunicipioEnderecoEntregaPessoaERP,	
		        @cdSiglaEstadoEnderecoEntregaPessoaERP,	
		        @nuCEPEnderecoEntregaPessoaERP,			
		        @nuCaixaPostalEnderecoEntregaPessoaERP,	
		        @enReferenciaEnderecoEntregaPessoaERP,	
		        @cdPaisTelefonePrincipalPessoaERP,		
		        @nuDDDTelefonePrincipalPessoaERP,		
		        @nuTelefonePrincipalPessoaERP,			
		        @cdPaisTelefoneFAXPessoaERP,			
		        @nuDDDTelefoneFAXPessoaERP,				
		        @nuTelefoneFAXPessoaERP,				
		        @cdPaisTelefoneCelularPessoaERP,		
		        @nuDDDTelefoneCelularPessoaERP,			
		        @nuTelefoneCelularPessoaERP,			
		        @enEmailPrincipalPessoaERP,				
		        @nmContatoPrincipalPessoaERP,			
		        @nmContatoCobrancaPessoaERP,
		        @cdIndicadorTipoAgenteComercialPessoaERP,
		        @cdRecnoMicrosigaERP
						
		SET @Fetch_AgenteComercial = @@FETCH_STATUS
		
		WHILE @Fetch_AgenteComercial = 0
		BEGIN

			-- //Consistências
			-- Verifica se o Codigo do Agente Comercial foi informado
			IF isnull(@cdPessoaERP,'') = '' 
			BEGIN
				PRINT 'Codigo do Agente Comercial do ERP não Informado'
				PRINT @nmPessoaERP
				CLOSE CS_AgenteComercial
				DEALLOCATE CS_AgenteComercial
				RAISERROR ('Codigo do Agente Comercial do ERP não Informado',16,1)
				RETURN
			END

	
			-- Verifica se o Status do Agente Comercial foi informado
			IF isnull(@cdIndicadorStatusPessoaERP,0) = 0 
			BEGIN
				PRINT 'Status do Agente Comercial do ERP não Informado'
				PRINT @nmPessoaERP
				CLOSE CS_Cliente
				DEALLOCATE CS_Cliente
				RAISERROR ('Status do Agente Comercial do ERP não Informado',16,1)
				RETURN
			END

			-- Verifica se o Indicador do Agente Comercial foi informado
			IF isnull(@cdIndicadorPessoaERP,0) = 0
			BEGIN
				PRINT 'Indicador do Agente Comercial do ERP não Informado'
				PRINT @nmPessoaERP
				CLOSE CS_Cliente
				DEALLOCATE CS_Cliente
				RAISERROR ('Indicador do Agente Comercial do ERP não Informado',16,1)
				RETURN
			END

			-- Verifica se o Nome do Agente Comercial foi informado
			IF isnull(@nmPessoaERP,'') = ''
			BEGIN
				PRINT 'Nome do Agente Comercial não Informado'
				PRINT @cdPessoaERP
				CLOSE CS_AgenteComercial
				DEALLOCATE CS_AgenteComercial
				RAISERROR ('Nome do Agente Comercial não Informado',16,1)
				RETURN			
			END
					
			-- Verifica se o registro existe no SFA
			IF EXISTS (	SELECT 1 FROM Pessoa 
						WHERE cdPessoaERP = @cdPessoaERP
						AND   cdIndicadorTipoPerfilPessoa = 3)  -- Agente comercial
			BEGIN


				-- Busca Valores do SFA para Comparação
				SELECT	
					 @cdPessoaSEQ							= cdPessoaSEQ
					,@cdIndicadorStatusPessoa				= cdIndicadorStatusPessoa
					,@cdIndicadorPessoa						= cdIndicadorPessoa
					,@nmPessoa								= nmPessoa
					,@nmReduzidoPessoa						= nmReduzidoPessoa
					,@nmFoneticoPessoa						= dbo.fn_obterfonetica(@nmPessoaERP + ' ' + @nmReduzidoPessoaERP + ' ' + @cdPessoaERP)
					,@nuCNPJCPFPessoa						= nuCNPJCPFPessoa
					,@nuInscricaoEstadualPessoa				= nuInscricaoEstadualPessoa
					,@nuInscricaoMunicipalPessoa			= nuInscricaoMunicipalPessoa
					,@nuInscricaoRuralPessoa				= nuInscricaoRuralPessoa
					,@nuRGCedulaEstrangeiroPessoa			= nuRGCedulaEstrangeiroPessoa
					,@cdNacionalidadePessoa					= cdNacionalidadePessoa
					,@dtNascimentoPessoa					= dtNascimentoPessoa
					,@cdIndicadorSexoPessoa					= cdIndicadorSexoPessoa
					,@cdIndicadorEstadoCivilPessoa			= cdIndicadorEstadoCivilPessoa
					
					,@cdPaisEnderecoPrincipalPessoa			= cdPaisEnderecoPrincipalPessoa
					,@enLogradouroEnderecoPrincipalPessoa	= enLogradouroEnderecoPrincipalPessoa
					,@enBairroEnderecoPrincipalPessoa		= enBairroEnderecoPrincipalPessoa
					,@enMunicipioEnderecoPrincipalPessoa	= enMunicipioEnderecoPrincipalPessoa
					,@cdSiglaEstadoEnderecoPrincipalPessoa	= cdSiglaEstadoEnderecoPrincipalPessoa
					,@nuCEPEnderecoPrincipalPessoa			= nuCEPEnderecoPrincipalPessoa
					,@nuCaixaPostalEnderecoPrincipalPessoa	= nuCaixaPostalEnderecoPrincipalPessoa
					,@enReferenciaEnderecoPrincipalPessoa	= enReferenciaEnderecoPrincipalPessoa

					,@cdPaisEnderecoCobrancaPessoa			= cdPaisEnderecoCobrancaPessoa
					,@enLogradouroEnderecoCobrancaPessoa	= enLogradouroEnderecoCobrancaPessoa
					,@enComplementoEnderecoCobrancaPessoa	= enComplementoEnderecoCobrancaPessoa
					,@enComplementoEnderecoPrincipalPessoa	= enComplementoEnderecoPrincipalPessoa
					,@enBairroEnderecoCobrancaPessoa		= enBairroEnderecoCobrancaPessoa
					,@enMunicipioEnderecoCobrancaPessoa		= enMunicipioEnderecoCobrancaPessoa
					,@cdSiglaEstadoEnderecoCobrancaPessoa	= cdSiglaEstadoEnderecoCobrancaPessoa
					,@nuCEPEnderecoCobrancaPessoa			= nuCEPEnderecoCobrancaPessoa
					,@nuCaixaPostalEnderecoCobrancaPessoa	= nuCaixaPostalEnderecoCobrancaPessoa
					,@enReferenciaEnderecoCobrancaPessoa	= enReferenciaEnderecoCobrancaPessoa

					,@cdPaisEnderecoEntregaPessoa			= cdPaisEnderecoEntregaPessoa
					,@enLogradouroEnderecoEntregaPessoa		= enLogradouroEnderecoEntregaPessoa
					,@enComplementoEnderecoEntregaPessoa	= enComplementoEnderecoEntregaPessoa
					,@enBairroEnderecoEntregaPessoa			= enBairroEnderecoEntregaPessoa
					,@enMunicipioEnderecoEntregaPessoa		= enMunicipioEnderecoEntregaPessoa
					,@cdSiglaEstadoEnderecoEntregaPessoa	= cdSiglaEstadoEnderecoEntregaPessoa
					,@nuCEPEnderecoEntregaPessoa			= nuCEPEnderecoEntregaPessoa
					,@nuCaixaPostalEnderecoEntregaPessoa	= nuCaixaPostalEnderecoEntregaPessoa
					,@enReferenciaEnderecoEntregaPessoa		= enReferenciaEnderecoEntregaPessoa

					,@cdPaisTelefonePrincipalPessoa			= cdPaisTelefonePrincipalPessoa
					,@nuDDDTelefonePrincipalPessoa			= nuDDDTelefonePrincipalPessoa
					,@nuTelefonePrincipalPessoa				= nuTelefonePrincipalPessoa

					,@cdPaisTelefoneFAXPessoa				= cdPaisTelefoneFAXPessoa
					,@nuDDDTelefoneFAXPessoa				= nuDDDTelefoneFAXPessoa
					,@nuTelefoneFAXPessoa					= nuTelefoneFAXPessoa

					,@cdPaisTelefoneCelularPessoa			= cdPaisTelefoneCelularPessoa
					,@nuDDDTelefoneCelularPessoa			= nuDDDTelefoneCelularPessoa
					,@nuTelefoneCelularPessoa				= nuTelefoneCelularPessoa

					,@enEmailPrincipalPessoa				= enEmailPrincipalPessoa
					,@nmContatoPrincipalPessoa				= nmContatoPrincipalPessoa
					,@nmContatoCobrancaPessoa				= nmContatoCobrancaPessoa
					,@cdIndicadorTipoAgenteComercialPessoa  = cdIndicadorTipoAgenteComercialPessoa
					,@cdRecnoMicrosiga						= cdRecnoMicrosiga
				FROM	
					Pessoa
				WHERE	
					cdPessoaERP					= @cdPessoaERP
				and	cdIndicadorTipoPerfilPessoa	= 3 --Agente Comercial
			
				
				-- Verifica se os Valores estao Diferentes do Microsiga
				IF	 
					rtrim(ltrim(isnull(@cdIndicadorStatusPessoa,0)))				<> rtrim(ltrim(isnull(@cdIndicadorStatusPessoaERP,0)))				OR
					rtrim(ltrim(isnull(@cdIndicadorPessoa,0)))						<> rtrim(ltrim(isnull(@cdIndicadorPessoaERP,0)))					OR
					rtrim(ltrim(isnull(@nmPessoa,'')))								<> rtrim(ltrim(isnull(@nmPessoaERP,'')))							OR
					rtrim(ltrim(isnull(@nmReduzidoPessoa,'')))						<> rtrim(ltrim(isnull(@nmReduzidoPessoaERP,'')))					OR
					rtrim(ltrim(isnull(@nuCNPJCPFPessoa,'')))						<> rtrim(ltrim(isnull(@nuCNPJCPFPessoaERP,'')))						OR
					rtrim(ltrim(isnull(@nuInscricaoEstadualPessoa,'')))				<> rtrim(ltrim(isnull(@nuInscricaoEstadualPessoaERP,'')))			OR
					rtrim(ltrim(isnull(@nuInscricaoMunicipalPessoa,'')))			<> rtrim(ltrim(isnull(@nuInscricaoMunicipalPessoaERP,'')))			OR
					rtrim(ltrim(isnull(@nuInscricaoRuralPessoa,'')))				<> rtrim(ltrim(isnull(@nuInscricaoRuralPessoaERP,'')))				OR
					rtrim(ltrim(isnull(@nuRGCedulaEstrangeiroPessoa,'')))			<> rtrim(ltrim(isnull(@nuRGCedulaEstrangeiroPessoaERP,'')))			OR
					rtrim(ltrim(isnull(@cdNacionalidadePessoa,0)))					<> rtrim(ltrim(isnull(@cdNacionalidadePessoaERP,0)))				OR
					rtrim(ltrim(isnull(@dtNascimentoPessoa,'')))					<> rtrim(ltrim(isnull(@dtNascimentoPessoaERP,'')))					OR
					rtrim(ltrim(isnull(@cdIndicadorSexoPessoa,0)))					<> rtrim(ltrim(isnull(@cdIndicadorSexoPessoaERP,0)))				OR
					rtrim(ltrim(isnull(@cdIndicadorEstadoCivilPessoa,0)))			<> rtrim(ltrim(isnull(@cdIndicadorEstadoCivilPessoaERP,0)))			OR
					
					rtrim(ltrim(isnull(@cdPaisEnderecoPrincipalPessoa,0)))			<> rtrim(ltrim(isnull(@cdPaisEnderecoPrincipalPessoaERP,0)))		OR
					rtrim(ltrim(isnull(@enLogradouroEnderecoPrincipalPessoa,'')))	<> rtrim(ltrim(isnull(@enLogradouroEnderecoPrincipalPessoaERP,'')))	OR
					rtrim(ltrim(isnull(@enComplementoEnderecoPrincipalPessoa,'')))	<> rtrim(ltrim(isnull(@enComplementoEnderecoPrincipalPessoaERP,''))) OR
					rtrim(ltrim(isnull(@enBairroEnderecoPrincipalPessoa,'')))		<> rtrim(ltrim(isnull(@enBairroEnderecoPrincipalPessoaERP,'')))		OR
					rtrim(ltrim(isnull(@enMunicipioEnderecoPrincipalPessoa,'')))	<> rtrim(ltrim(isnull(@enMunicipioEnderecoPrincipalPessoaERP,'')))	OR
					rtrim(ltrim(isnull(@cdSiglaEstadoEnderecoPrincipalPessoa,'')))	<> rtrim(ltrim(isnull(@cdSiglaEstadoEnderecoPrincipalPessoaERP,''))) OR
					rtrim(ltrim(isnull(@nuCEPEnderecoPrincipalPessoa,'')))			<> rtrim(ltrim(isnull(@nuCEPEnderecoPrincipalPessoaERP,'')))		OR
					rtrim(ltrim(isnull(@nuCaixaPostalEnderecoPrincipalPessoa,'')))	<> rtrim(ltrim(isnull(@nuCaixaPostalEnderecoPrincipalPessoaERP,''))) OR
					rtrim(ltrim(isnull(@enReferenciaEnderecoPrincipalPessoa,'')))	<> rtrim(ltrim(isnull(@enReferenciaEnderecoPrincipalPessoaERP,'')))	OR

					rtrim(ltrim(isnull(@cdPaisEnderecoCobrancaPessoa,0)))			<> rtrim(ltrim(isnull(@cdPaisEnderecoCobrancaPessoaERP,0)))			OR
					rtrim(ltrim(isnull(@enLogradouroEnderecoCobrancaPessoa,'')))	<> rtrim(ltrim(isnull(@enLogradouroEnderecoCobrancaPessoaERP,'')))	OR
					rtrim(ltrim(isnull(@enComplementoEnderecoCobrancaPessoa,'')))	<> rtrim(ltrim(isnull(@enComplementoEnderecoCobrancaPessoaERP,'')))	OR
					rtrim(ltrim(isnull(@enBairroEnderecoCobrancaPessoa,'')))		<> rtrim(ltrim(isnull(@enBairroEnderecoCobrancaPessoaERP,'')))		OR
					rtrim(ltrim(isnull(@enMunicipioEnderecoCobrancaPessoa,'')))		<> rtrim(ltrim(isnull(@enMunicipioEnderecoCobrancaPessoaERP,'')))	OR
					rtrim(ltrim(isnull(@cdSiglaEstadoEnderecoCobrancaPessoa,'')))	<> rtrim(ltrim(isnull(@cdSiglaEstadoEnderecoCobrancaPessoaERP,'')))	OR
					rtrim(ltrim(isnull(@nuCEPEnderecoCobrancaPessoa,'')))			<> rtrim(ltrim(isnull(@nuCEPEnderecoCobrancaPessoaERP,'')))			OR
					rtrim(ltrim(isnull(@nuCaixaPostalEnderecoCobrancaPessoa,'')))	<> rtrim(ltrim(isnull(@nuCaixaPostalEnderecoCobrancaPessoaERP,'')))	OR
					rtrim(ltrim(isnull(@enReferenciaEnderecoCobrancaPessoa,'')))	<> rtrim(ltrim(isnull(@enReferenciaEnderecoCobrancaPessoaERP,'')))	OR

					rtrim(ltrim(isnull(@cdPaisEnderecoEntregaPessoa,0)))			<> rtrim(ltrim(isnull(@cdPaisEnderecoEntregaPessoaERP,0)))			OR
					rtrim(ltrim(isnull(@enLogradouroEnderecoEntregaPessoa,'')))		<> rtrim(ltrim(isnull(@enLogradouroEnderecoEntregaPessoaERP,'')))	OR
					rtrim(ltrim(isnull(@enComplementoEnderecoEntregaPessoa,'')))	<> rtrim(ltrim(isnull(@enComplementoEnderecoEntregaPessoaERP,'')))	OR
					rtrim(ltrim(isnull(@enBairroEnderecoEntregaPessoa,'')))			<> rtrim(ltrim(isnull(@enBairroEnderecoEntregaPessoaERP,'')))		OR
					rtrim(ltrim(isnull(@enMunicipioEnderecoEntregaPessoa,'')))		<> rtrim(ltrim(isnull(@enMunicipioEnderecoEntregaPessoaERP,'')))	OR
					rtrim(ltrim(isnull(@cdSiglaEstadoEnderecoEntregaPessoa,'')))	<> rtrim(ltrim(isnull(@cdSiglaEstadoEnderecoEntregaPessoaERP,'')))	OR
					rtrim(ltrim(isnull(@nuCEPEnderecoEntregaPessoa,'')))			<> rtrim(ltrim(isnull(@nuCEPEnderecoEntregaPessoaERP,'')))			OR
					rtrim(ltrim(isnull(@nuCaixaPostalEnderecoEntregaPessoa,'')))	<> rtrim(ltrim(isnull(@nuCaixaPostalEnderecoEntregaPessoaERP,'')))	OR
					rtrim(ltrim(isnull(@enReferenciaEnderecoEntregaPessoa,'')))		<> rtrim(ltrim(isnull(@enReferenciaEnderecoEntregaPessoaERP,'')))	OR

					rtrim(ltrim(isnull(@cdPaisTelefonePrincipalPessoa,0)))			<> rtrim(ltrim(isnull(@cdPaisTelefonePrincipalPessoaERP,0)))		OR
					rtrim(ltrim(isnull(@nuDDDTelefonePrincipalPessoa,'')))			<> rtrim(ltrim(isnull(@nuDDDTelefonePrincipalPessoaERP,'')))		OR
					rtrim(ltrim(isnull(@nuTelefonePrincipalPessoa,'')))				<> rtrim(ltrim(isnull(@nuTelefonePrincipalPessoaERP,'')))			OR

					rtrim(ltrim(isnull(@cdPaisTelefoneFAXPessoa,0)))				<> rtrim(ltrim(isnull(@cdPaisTelefoneFAXPessoaERP,0)))				OR
					rtrim(ltrim(isnull(@nuDDDTelefoneFAXPessoa,'')))				<> rtrim(ltrim(isnull(@nuDDDTelefoneFAXPessoaERP,'')))				OR
					rtrim(ltrim(isnull(@nuTelefoneFAXPessoa,'')))					<> rtrim(ltrim(isnull(@nuTelefoneFAXPessoaERP,'')))					OR

					rtrim(ltrim(isnull(@cdPaisTelefoneCelularPessoa,0)))			<> rtrim(ltrim(isnull(@cdPaisTelefoneCelularPessoaERP,0)))			OR
					rtrim(ltrim(isnull(@nuDDDTelefoneCelularPessoa,'')))			<> rtrim(ltrim(isnull(@nuDDDTelefoneCelularPessoaERP,'')))			OR
					rtrim(ltrim(isnull(@nuTelefoneCelularPessoa,'')))				<> rtrim(ltrim(isnull(@nuTelefoneCelularPessoaERP,'')))				OR
					
					/* -- Email não será modificado com base no Microsiga, conforme orientação da Marisa
					rtrim(ltrim(isnull(@enEmailPrincipalPessoa,'')))				<> rtrim(ltrim(isnull(@enEmailPrincipalPessoaERP,'')))				OR
					*/
					rtrim(ltrim(isnull(@nmContatoPrincipalPessoa,'')))				<> rtrim(ltrim(isnull(@nmContatoPrincipalPessoaERP,'')))			OR
					rtrim(ltrim(isnull(@nmContatoCobrancaPessoa,'')))				<> rtrim(ltrim(isnull(@nmContatoCobrancaPessoaERP,'')))				OR
					rtrim(ltrim(isnull(@cdIndicadorTipoAgenteComercialPessoa,0)))	<> rtrim(ltrim(isnull(@cdIndicadorTipoAgenteComercialPessoaERP,0)))	OR
					rtrim(ltrim(isnull(@cdRecnoMicrosiga,0)))						<> rtrim(ltrim(isnull(@cdRecnoMicrosigaERP,0)))
				BEGIN
				
		
					-- Atualiza Registro no SFA		
					UPDATE Pessoa
					SET	
						 cdIndicadorStatusPessoa				= @cdIndicadorStatusPessoaERP				
						,cdIndicadorPessoa						= @cdIndicadorPessoaERP						
						,nmPessoa								= @nmPessoaERP								
						,nmReduzidoPessoa						= @nmReduzidoPessoaERP	
						,nmFoneticoPessoa						= dbo.fn_obterfonetica(@nmPessoaERP + ' ' + @nmReduzidoPessoaERP + ' ' + @cdPessoaERP)
						,nuCNPJCPFPessoa						= @nuCNPJCPFPessoaERP						
						,nuInscricaoEstadualPessoa				= @nuInscricaoEstadualPessoaERP				
						,nuInscricaoMunicipalPessoa				= @nuInscricaoMunicipalPessoaERP				
						,nuInscricaoRuralPessoa					= @nuInscricaoRuralPessoaERP					
						,nuRGCedulaEstrangeiroPessoa			= @nuRGCedulaEstrangeiroPessoaERP			
						,cdNacionalidadePessoa					= @cdNacionalidadePessoaERP					
						,dtNascimentoPessoa						= @dtNascimentoPessoaERP						
						,cdIndicadorSexoPessoa					= @cdIndicadorSexoPessoaERP				
						,cdIndicadorEstadoCivilPessoa			= @cdIndicadorEstadoCivilPessoaERP			
						
						,cdPaisEnderecoPrincipalPessoa			= @cdPaisEnderecoPrincipalPessoaERP			
						,enLogradouroEnderecoPrincipalPessoa	= @enLogradouroEnderecoPrincipalPessoaERP	
						,enComplementoEnderecoPrincipalPessoa	= @enComplementoEnderecoPrincipalPessoaERP							
						,enBairroEnderecoPrincipalPessoa		= @enBairroEnderecoPrincipalPessoaERP		
						,enMunicipioEnderecoPrincipalPessoa		= @enMunicipioEnderecoPrincipalPessoaERP		
						,cdSiglaEstadoEnderecoPrincipalPessoa	= @cdSiglaEstadoEnderecoPrincipalPessoaERP	
						,nuCEPEnderecoPrincipalPessoa			= @nuCEPEnderecoPrincipalPessoaERP			
						,nuCaixaPostalEnderecoPrincipalPessoa	= @nuCaixaPostalEnderecoPrincipalPessoaERP	
						,enReferenciaEnderecoPrincipalPessoa	= @enReferenciaEnderecoPrincipalPessoaERP	

						,cdPaisEnderecoCobrancaPessoa			= @cdPaisEnderecoCobrancaPessoaERP			
						,enLogradouroEnderecoCobrancaPessoa		= @enLogradouroEnderecoCobrancaPessoaERP		
						,enComplementoEnderecoCobrancaPessoa	= @enComplementoEnderecoCobrancaPessoaERP	
						,enBairroEnderecoCobrancaPessoa			= @enBairroEnderecoCobrancaPessoaERP			
						,enMunicipioEnderecoCobrancaPessoa		= @enMunicipioEnderecoCobrancaPessoaERP		
						,cdSiglaEstadoEnderecoCobrancaPessoa	= @cdSiglaEstadoEnderecoCobrancaPessoaERP	
						,nuCEPEnderecoCobrancaPessoa			= @nuCEPEnderecoCobrancaPessoaERP			
						,nuCaixaPostalEnderecoCobrancaPessoa	= @nuCaixaPostalEnderecoCobrancaPessoaERP	
						,enReferenciaEnderecoCobrancaPessoa		= @enReferenciaEnderecoCobrancaPessoaERP		

						,cdPaisEnderecoEntregaPessoa			= @cdPaisEnderecoEntregaPessoaERP			
						,enLogradouroEnderecoEntregaPessoa		= @enLogradouroEnderecoEntregaPessoaERP		
						,enComplementoEnderecoEntregaPessoa		= @enComplementoEnderecoEntregaPessoaERP		
						,enBairroEnderecoEntregaPessoa			= @enBairroEnderecoEntregaPessoaERP			
						,enMunicipioEnderecoEntregaPessoa		= @enMunicipioEnderecoEntregaPessoaERP		
						,cdSiglaEstadoEnderecoEntregaPessoa		= @cdSiglaEstadoEnderecoEntregaPessoaERP		
						,nuCEPEnderecoEntregaPessoa				= @nuCEPEnderecoEntregaPessoaERP				
						,nuCaixaPostalEnderecoEntregaPessoa		= @nuCaixaPostalEnderecoEntregaPessoaERP		
						,enReferenciaEnderecoEntregaPessoa		= @enReferenciaEnderecoEntregaPessoaERP		

						,cdPaisTelefonePrincipalPessoa			= @cdPaisTelefonePrincipalPessoaERP			
						,nuDDDTelefonePrincipalPessoa			= @nuDDDTelefonePrincipalPessoaERP			
						,nuTelefonePrincipalPessoa				= @nuTelefonePrincipalPessoaERP				

						,cdPaisTelefoneFAXPessoa				= @cdPaisTelefoneFAXPessoaERP				
						,nuDDDTelefoneFAXPessoa					= @nuDDDTelefoneFAXPessoaERP					
						,nuTelefoneFAXPessoa					= @nuTelefoneFAXPessoaERP					

						,cdPaisTelefoneCelularPessoa			= @cdPaisTelefoneCelularPessoaERP			
						,nuDDDTelefoneCelularPessoa				= @nuDDDTelefoneCelularPessoaERP				
						,nuTelefoneCelularPessoa				= @nuTelefoneCelularPessoaERP				

						/* -- O Email não será atualizado do Microsiga, conforme definição da Marisa
						,enEmailPrincipalPessoa					= @enEmailPrincipalPessoaERP					
						*/
						,nmContatoPrincipalPessoa				= @nmContatoPrincipalPessoaERP				
						,nmContatoCobrancaPessoa				= @nmContatoCobrancaPessoaERP
						,cdIndicadorTipoAgenteComercialPessoa   = @cdIndicadortipoAgenteComercialPessoaERP
						
						,dtUltimaAlteracao						= getdate()
						,cdUsuarioUltimaAlteracao				= 9999 -- codigo utilizado para o Microsiga		
						,cdRecnoMicrosiga						= @cdRecnoMicrosigaERP		

					WHERE 
						cdPessoaSEQ							= @cdPessoaSEQ
						AND   cdIndicadorTipoPerfilPessoa = 3  -- Agente comercial
				
					-- Verifica Erro no Update
					IF @@ERROR <> 0  OR @@ROWCOUNT = 0
					BEGIN
						PRINT 'Erro no Update do Agente Comercial'
						PRINT @cdPessoaERP + ' - ' + @nmPessoaERP
						CLOSE CS_Cliente
						DEALLOCATE CS_Cliente
						RAISERROR ('Erro no Update do Agente Comercial',16,1)
						RETURN
					END
					
					PRINT 'UPDATE - ' + @cdPessoaERP + ' - ' + @nmPessoaERP
					
					-- Verifica se o Agente Comercial foi desligado (status inativo no Microsiga)
					if isnull(@cdIndicadorStatusPessoaERP,0) = 2 -- Inativo
					begin
					
						UPDATE Pessoa
						SET	cdIndicadorSenhaBloqueadaPessoa = 1	-- Bloqueada
						   ,dtUltimaAlteracao = getdate()
						   ,cdUsuarioUltimaAlteracao = 9999 -- Codigo Microsiga
						WHERE cdPessoaSEQ = @cdPessoaSEQ 
						AND   cdIndicadorTipoPerfilPessoa = 3	-- Agente Comercial
					
						-- Verifica Erro no Update
						IF @@ERROR <> 0  OR @@ROWCOUNT = 0
						BEGIN
							PRINT 'Erro no Update do Agente Comercial - bloqueio senha'
							PRINT @cdPessoaERP + ' - ' + @nmPessoaERP
							CLOSE CS_Cliente
							DEALLOCATE CS_Cliente
							RAISERROR ('Erro no Update do Agente Comercial - bloqueio senha',16,1)
							RETURN
						END
					
						PRINT 'UPDATE BLOQUEIO - ' + @cdPessoaERP + ' - ' + @nmPessoaERP					
					
					end
										
				END
				

				
			END
			ELSE
			BEGIN --//Inclusao
			
							
				-- Efetua a Inclusao
				INSERT INTO pessoa
					(
						cdPessoaERP
						,cdIndicadorTipoPerfilPessoa
						,cdIndicadorStatusPessoa
						,cdIndicadorPessoa
						,cdIndicadorTipoAcessoPessoa
						,dsLoginPessoa
						,dsSenhaLoginPessoa
						,cdIndicadorPrimeiroAcessoPessoa
						,cdIndicadorSenhaBloqueadaPessoa
						,nmPessoa
						,nmReduzidoPessoa
						,nmFoneticoPessoa
						,nuCNPJCPFPessoa
						,nuInscricaoEstadualPessoa
						,nuInscricaoMunicipalPessoa
						,nuInscricaoRuralPessoa
						,nuRGCedulaEstrangeiroPessoa
						,cdNacionalidadePessoa
						,dtNascimentoPessoa
						,cdIndicadorSexoPessoa
						,cdIndicadorEstadoCivilPessoa
						,cdPaisEnderecoPrincipalPessoa
						,enLogradouroEnderecoPrincipalPessoa
						,enBairroEnderecoPrincipalPessoa
						,enMunicipioEnderecoPrincipalPessoa
						,cdSiglaEstadoEnderecoPrincipalPessoa
						,nuCEPEnderecoPrincipalPessoa
						,nuCaixaPostalEnderecoPrincipalPessoa
						,enReferenciaEnderecoPrincipalPessoa
						,cdPaisEnderecoCobrancaPessoa
						,enLogradouroEnderecoCobrancaPessoa
						,enComplementoEnderecoCobrancaPessoa
						,enComplementoEnderecoPrincipalPessoa
						,enBairroEnderecoCobrancaPessoa
						,enMunicipioEnderecoCobrancaPessoa
						,cdSiglaEstadoEnderecoCobrancaPessoa
						,nuCEPEnderecoCobrancaPessoa
						,nuCaixaPostalEnderecoCobrancaPessoa
						,enReferenciaEnderecoCobrancaPessoa
						,cdPaisEnderecoEntregaPessoa
						,enLogradouroEnderecoEntregaPessoa
						,enComplementoEnderecoEntregaPessoa
						,enBairroEnderecoEntregaPessoa
						,enMunicipioEnderecoEntregaPessoa
						,cdSiglaEstadoEnderecoEntregaPessoa
						,nuCEPEnderecoEntregaPessoa
						,nuCaixaPostalEnderecoEntregaPessoa
						,enReferenciaEnderecoEntregaPessoa
						,cdPaisTelefonePrincipalPessoa
						,nuDDDTelefonePrincipalPessoa
						,nuTelefonePrincipalPessoa
						,cdPaisTelefoneFAXPessoa
						,nuDDDTelefoneFAXPessoa
						,nuTelefoneFAXPessoa
						,cdPaisTelefoneCelularPessoa
						,nuDDDTelefoneCelularPessoa
						,nuTelefoneCelularPessoa
						,enEmailPrincipalPessoa
						,nmContatoPrincipalPessoa
						,nmContatoCobrancaPessoa
						,cdEmpresaColaboradorPessoa
						,cdAgenteComercialRCPessoa
						,cdAgenteComercialCooperativaPessoa
						,cdAgenteComercialCCABPessoa
						,cdGrupoAcessoSEQ
						,dtUltimaAlteracao
						,cdUsuarioUltimaAlteracao
						,cdIndicadorTipoAgenteComercialPessoa
						,cdRecnoMicrosiga
					)
				VALUES
					(
						@cdPessoaERP
						,3 -- Agente Comercial
						,@cdIndicadorStatusPessoaERP
						,@cdIndicadorPessoaERP
						,2 -- Usuário Comum
						,@cdPessoaERP -- Login Pessoa
						,dbo.fn_criptografarsenha(@cdPessoaERP)
						,1 -- Primeiro Acesso (1-Sim)
						,1 -- Senha Bloqueada (1-Sim)
						,@nmPessoaERP
						,@nmReduzidoPessoaERP
						,dbo.fn_obterfonetica(@nmPessoaERP + ' ' + @nmReduzidoPessoaERP + ' ' + @cdPessoaERP)
						,@nuCNPJCPFPessoaERP
						,@nuInscricaoEstadualPessoaERP
						,@nuInscricaoMunicipalPessoaERP
						,@nuInscricaoRuralPessoaERP
						,@nuRGCedulaEstrangeiroPessoaERP
						,@cdNacionalidadePessoaERP
						,@dtNascimentoPessoaERP
						,@cdIndicadorSexoPessoaERP
						,@cdIndicadorEstadoCivilPessoaERP
						,@cdPaisEnderecoPrincipalPessoaERP
						,@enLogradouroEnderecoPrincipalPessoaERP
						,@enBairroEnderecoPrincipalPessoaERP
						,@enMunicipioEnderecoPrincipalPessoaERP
						,@cdSiglaEstadoEnderecoPrincipalPessoaERP
						,@nuCEPEnderecoPrincipalPessoaERP
						,@nuCaixaPostalEnderecoPrincipalPessoaERP
						,@enReferenciaEnderecoPrincipalPessoaERP
						,@cdPaisEnderecoCobrancaPessoaERP
						,@enLogradouroEnderecoCobrancaPessoaERP
						,@enComplementoEnderecoCobrancaPessoaERP
						,@enComplementoEnderecoPrincipalPessoaERP
						,@enBairroEnderecoCobrancaPessoaERP
						,@enMunicipioEnderecoCobrancaPessoaERP
						,@cdSiglaEstadoEnderecoCobrancaPessoaERP
						,@nuCEPEnderecoCobrancaPessoaERP
						,@nuCaixaPostalEnderecoCobrancaPessoaERP
						,@enReferenciaEnderecoCobrancaPessoaERP
						,@cdPaisEnderecoEntregaPessoaERP
						,@enLogradouroEnderecoEntregaPessoaERP
						,@enComplementoEnderecoEntregaPessoaERP
						,@enBairroEnderecoEntregaPessoaERP
						,@enMunicipioEnderecoEntregaPessoaERP
						,@cdSiglaEstadoEnderecoEntregaPessoaERP
						,@nuCEPEnderecoEntregaPessoaERP
						,@nuCaixaPostalEnderecoEntregaPessoaERP
						,@enReferenciaEnderecoEntregaPessoaERP
						,@cdPaisTelefonePrincipalPessoaERP
						,@nuDDDTelefonePrincipalPessoaERP
						,@nuTelefonePrincipalPessoaERP
						,@cdPaisTelefoneFAXPessoaERP
						,@nuDDDTelefoneFAXPessoaERP
						,@nuTelefoneFAXPessoaERP
						,@cdPaisTelefoneCelularPessoaERP
						,@nuDDDTelefoneCelularPessoaERP
						,@nuTelefoneCelularPessoaERP
						,@enEmailPrincipalPessoaERP
						,@nmContatoPrincipalPessoaERP
						,@nmContatoCobrancaPessoaERP
						,NULL -- @cdEmpresaColaboradorPessoaERP
						,NULL -- @cdAgenteComercialRCPessoaERP
						,NULL -- @cdAgenteComercialCooperativaPessoaERP
						,NULL -- @cdAgenteComercialCCABPessoa
						,20 -- @cdGrupoAcessoSEQ - grupo de agente comercial
						,getdate()
						,9999 -- sera assumido 9999 para o Microsiga
						,@cdIndicadorTipoAgenteComercialPessoaERP
						,@cdRecnoMicrosigaERP
					)
						
				IF @@ERROR <> 0
				BEGIN
					PRINT 'Erro na Inclusao do Agente Comercial na Base do SFA'
					PRINT @cdPessoaERP
					CLOSE CS_AgenteComercial
					DEALLOCATE CS_AgenteComercial
					RAISERROR ('Erro na Inclusao do Agente Comercial na Base do SFA',16,1)
					RETURN
				END

				PRINT 'INSERT - ' + @cdPessoaERP + ' - ' + @nmPessoaERP
				
			END
			
			FETCH NEXT FROM CS_AgenteComercial
			INTO	@cdPessoaERP,						
			        @cdIndicadorStatusPessoaERP,		
			        @cdIndicadorPessoaERP,				
			        @nmPessoaERP,						
			        @nmReduzidoPessoaERP,				
			        @nuCNPJCPFPessoaERP,				
			        @nuInscricaoEstadualPessoaERP,		
			        @nuInscricaoMunicipalPessoaERP,		
			        @nuInscricaoRuralPessoaERP,			
			        @nuRGCedulaEstrangeiroPessoaERP,	
			        @cdNacionalidadePessoaERP,		
			        @dtNascimentoPessoaERP,			
			        @cdIndicadorSexoPessoaERP,			
			        @cdIndicadorEstadoCivilPessoaERP,	
			        @cdPaisEnderecoPrincipalPessoaERP,	
			        @enLogradouroEnderecoPrincipalPessoaERP,
			        @enComplementoEnderecoPrincipalPessoaERP,
			        @enBairroEnderecoPrincipalPessoaERP,	
			        @enMunicipioEnderecoPrincipalPessoaERP,	
			        @cdSiglaEstadoEnderecoPrincipalPessoaERP,
			        @nuCEPEnderecoPrincipalPessoaERP,		
			        @nuCaixaPostalEnderecoPrincipalPessoaERP,
			        @enReferenciaEnderecoPrincipalPessoaERP,
			        @cdPaisEnderecoCobrancaPessoaERP,		
			        @enLogradouroEnderecoCobrancaPessoaERP,	
			        @enComplementoEnderecoCobrancaPessoaERP,
			        @enBairroEnderecoCobrancaPessoaERP,		
			        @enMunicipioEnderecoCobrancaPessoaERP,	
			        @cdSiglaEstadoEnderecoCobrancaPessoaERP,
			        @nuCEPEnderecoCobrancaPessoaERP,		
			        @nuCaixaPostalEnderecoCobrancaPessoaERP,
			        @enReferenciaEnderecoCobrancaPessoaERP,	
			        @cdPaisEnderecoEntregaPessoaERP,		
			        @enLogradouroEnderecoEntregaPessoaERP,	
			        @enComplementoEnderecoEntregaPessoaERP,	
			        @enBairroEnderecoEntregaPessoaERP,		
			        @enMunicipioEnderecoEntregaPessoaERP,	
			        @cdSiglaEstadoEnderecoEntregaPessoaERP,	
			        @nuCEPEnderecoEntregaPessoaERP,			
			        @nuCaixaPostalEnderecoEntregaPessoaERP,	
			        @enReferenciaEnderecoEntregaPessoaERP,	
			        @cdPaisTelefonePrincipalPessoaERP,		
			        @nuDDDTelefonePrincipalPessoaERP,		
			        @nuTelefonePrincipalPessoaERP,			
			        @cdPaisTelefoneFAXPessoaERP,			
			        @nuDDDTelefoneFAXPessoaERP,				
			        @nuTelefoneFAXPessoaERP,				
			        @cdPaisTelefoneCelularPessoaERP,		
			        @nuDDDTelefoneCelularPessoaERP,			
			        @nuTelefoneCelularPessoaERP,			
			        @enEmailPrincipalPessoaERP,				
			        @nmContatoPrincipalPessoaERP,			
			        @nmContatoCobrancaPessoaERP,
			        @cdIndicadorTipoAgenteComercialPessoaERP,
			        @cdRecnoMicrosigaERP
						
			SET @Fetch_AgenteComercial = @@FETCH_STATUS
			
		END
		
		CLOSE CS_AgenteComercial
		DEALLOCATE CS_AgenteComercial
		
		--- Verifica Exclusao do Agente Comercial
		--- (mudanca de status da Situação e Bloqueio de Senha)
		
		-- Defini Cursor para Verificar registros Excluidos no Microsiga
		DECLARE CS_AgenteComercialExclusao CURSOR FOR
		SELECT	cdPessoaSEQ
		FROM	Pessoa a
		-- WHERE	NOT EXISTS (	SELECT 1 FROM DADOSAP8..SA3010 b
		WHERE NOT EXISTS (		SELECT 1 FROM BDTSWK301.DADOSAP8.dbo.SA3010 b
								WHERE  D_E_L_E_T_ = ''
								AND a.cdPessoaERP = LTRIM(RTRIM(b.A3_COD)) collate SQL_Latin1_General_CP1_CI_AS)
		AND		cdIndicadorStatusPessoa = 1			-- ATivo
		AND     cdIndicadorTipoPerfilPessoa = 3		-- Agente Comercial
		AND     cdIndicadorSenhaBloqueadaPessoa = 2 -- Não esta bloqueada
		
		OPEN CS_AgenteComercialExclusao
		FETCH NEXT FROM CS_AgenteComercialExclusao
		INTO	@cdPessoaSEQ
						
		SET @Fetch_AgenteComercial = @@FETCH_STATUS
		
		WHILE @Fetch_AgenteComercial = 0
		BEGIN
	
			-- Atualiza Registro no SFA		
			UPDATE Pessoa
			SET	cdIndicadorStatusPessoa = 2			-- Inativo
			   ,cdIndicadorSenhaBloqueadaPessoa = 1	-- Bloqueada
			   ,dtUltimaAlteracao = getdate()
			   ,cdUsuarioUltimaAlteracao = 9999 -- Codigo Microsiga
			WHERE cdPessoaSEQ = @cdPessoaSEQ 
			AND   cdIndicadorTipoPerfilPessoa = 3	-- Agente Comercial
				
			-- Verifica Erro no Update
			IF @@ERROR <> 0  OR @@ROWCOUNT = 0
			BEGIN
				PRINT 'Erro no Update do Produto - Exclusão'
				PRINT @cdPessoaSEQ
				CLOSE CS_AgenteComercialExclusao
				DEALLOCATE CS_AgenteComercialExclusao
				RAISERROR ('Erro no Update do Produto - Exclusão',16,1)
				RETURN
			END

			PRINT 'EXCLUSAO - ' + str(@cdPessoaSEQ) 

			FETCH NEXT FROM CS_AgenteComercialExclusao
			INTO	@cdPessoaSEQ			           
						
			SET @Fetch_AgenteComercial = @@FETCH_STATUS
						
		END	
		
		CLOSE CS_AgenteComercialExclusao
		DEALLOCATE CS_AgenteComercialExclusao
		
		RETURN
		
	END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

