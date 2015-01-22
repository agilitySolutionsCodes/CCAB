SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_J_AtualizaDadosClienteMicrosiga]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_J_AtualizaDadosClienteMicrosiga]
END
GO

CREATE PROCEDURE SP_J_AtualizaDadosClienteMicrosiga
	
AS

	BEGIN

		--Variaveis MICROSIGA												-- (SA1010)					
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
		DECLARE @cdAgenteComercialCCABPessoaERP				varchar(30)
		DECLARE @cdAgenteComercialCooperativaPessoaERP		varchar(30)
		DECLARE @cdAgenteComercialRCPessoaERP				varchar(30)
		DECLARE @cdRecnoMicrosigaERP						bigint
		DECLARE @cdCodigoLojaERP							varchar(30)
		
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
		DECLARE @cdAgenteComercialCCABPessoaSEQERP			varchar(30)
		DECLARE @cdAgenteComercialCooperativaPessoaSEQERP	varchar(30)
		DECLARE @cdAgenteComercialRCPessoaSEQERP			varchar(30)
		DECLARE	@nmFoneticoPessoa							varchar(8000)
		DECLARE @cdRecnoMicrosiga							bigint

		DECLARE	@cdAgenteComercialRCPessoaOriginal			bigint		
		DECLARE	@cdAgenteComercialCooperativaPessoaOriginal	bigint
		DECLARE	@cdAgenteComercialCCABPessoaOriginal		bigint

		
		-- Variaveis SFA
		DECLARE @Fetch_Cliente						int
		DECLARE @cdAgenteComercialCCABPessoa		bigint
		DECLARE @cdAgenteComercialCooperativaPessoa	bigint
		DECLARE @cdAgenteComercialRCPessoa			bigint

		-- Defini Cursor para Atualização com base no Microsiga (Inclusao e Alteracao)
		DECLARE CS_Cliente CURSOR FOR
		SELECT  LTRIM(RTRIM(A1_COD))	+
					STUFF('00', CASE LEN(LTRIM(RTRIM(A1_LOJA))) 
									WHEN 2 THEN 1 
									WHEN 1 THEN 2 
									ELSE 1 
								END, 
						  LEN(LTRIM(RTRIM(A1_LOJA))), LTRIM(RTRIM(A1_LOJA)))	
															as cdPessoaERP,								-- Código do Cliente
				CASE LTRIM(RTRIM(A1_MSBLQL)) 
					WHEN 2 THEN 1 
					WHEN 1 THEN 2 
					ELSE 1 
				END											as cdIndicadorStatusPessoaERP,				-- Situação do Cliente (1-Ativo,2-Inativo)
				CASE LTRIM(RTRIM(A1_PESSOA)) 
					WHEN 'F' THEN 1 
					WHEN 'J' THEN 2 
					ELSE		  2 
				END											as cdIndicadorPessoaERP,					-- Tipo de Pessoa (1-Fisica, 2-Juridica) 
				LTRIM(RTRIM(A1_NOME))						as nmPessoaERP,								-- Nome do Cliente
				LTRIM(RTRIM(A1_NREDUZ))						as nmReduzidoPessoaERP,						-- Nome Reduzido do Cliente
				LTRIM(RTRIM(A1_CGC))						as nuCNPJCPFPessoaERP,						-- CNPJ e/ou CPF do Cliente
				LTRIM(RTRIM(A1_INSCR))						as nuInscricaoEstadualPessoaERP,			-- Numero da Inscrição Estadual do Cliente
				LTRIM(RTRIM(A1_INSCRM))						as nuInscricaoMunicipalPessoaERP,  			-- Numero da Inscrição Municipal do Cliente
				LTRIM(RTRIM(A1_INSCRUR))					as nuInscricaoRuralPessoaERP,				-- Numero da Inscrição Rural do Cliente
				LTRIM(RTRIM(A1_PFISICA))					as nuRGCedulaEstrangeiroPessoaERP,			-- Numero do RG e/ou Cedula de Estrangeiro do Cliente
				1											as cdNacionalidadePessoaERP,				-- Nacionalidade do Cliente (1-Brasil/Brasileira) => Achei o campo A1_PAIS, no entanto, não está sendo utilizado. - estou assumindo como 1-Brasil.
				CASE RTRIM(LTRIM(A1_DTNASC)) 
					WHEN '' THEN NULL
					ELSE
						CONVERT(DATETIME,SUBSTRING(A1_DTNASC,7,2) 
						+ '/' 
						+ SUBSTRING(A1_DTNASC,5,2) 
						+ '/' 
						+ SUBSTRING(A1_DTNASC,1,4),103)
				END											as dtNascimentoPessoaERP,					-- Data de Nascimento do Cliente
				CASE LTRIM(RTRIM(A1_XSEXO))
					WHEN 'M' THEN 1
					WHEN 'J' THEN 2
					ELSE          NULL
				END											as cdIndicadorSexoPessoaERP,				-- Sexo do Cliente (1-Masculino, 2-Feminino) 
				CASE LTRIM(RTRIM(A1_XESTCIV))
					WHEN 'S' THEN 1 -- Solteiro
					WHEN 'C' THEN 2 -- Casado
					WHEN 'D' THEN 4 -- Separado e/ou Divorciado
					WHEN 'M' THEN 5 -- Amasiado
					WHEN 'Q' THEN 6 -- Outros
					WHEN 'V' THEN 3 -- Viuvo
					ELSE	      NULL
				END											as cdIndicadorEstadoCivilPessoaERP,			-- Estado Civil do Cliente
				1											as cdPaisEnderecoPrincipalPessoaERP,		-- Pais do Endereco Principal do Cliente (1-Brasil) => Achei o campo A1_PAIS, no entanto, o mesmo nao está sendo utilizado - Estou assumindo 1-Brasil
				LTRIM(RTRIM(A1_END))						as enLogradouroEnderecoPrincipalPessoaERP,	-- Logradouro do Endereco Principal do Cliente
				LTRIM(RTRIM(A1_XCOMPLE))					as enComplementoEnderecoPrincipalPessoaERP,	-- Complemento do endereco principal do Cliente
				LTRIM(RTRIM(A1_BAIRRO))						as enBairroEnderecoPrincipalPessoaERP,		-- Bairro do Endereco Principal do Cliente
				LTRIM(RTRIM(A1_MUN))						as enMunicipioEnderecoPrincipalPessoaERP,	-- Municipio do endereco principal do Cliente
				LTRIM(RTRIM(A1_EST))						as cdSiglaEstadoEnderecoPrincipalPessoaERP,	-- Sigla do Estado do endereco principal do Cliente
				LTRIM(RTRIM(A1_CEP))						as nuCEPEnderecoPrincipalPessoaERP,			-- CEP do endereco principal do Cliente
				LTRIM(RTRIM(A1_CXPOSTA))					as nuCaixaPostalEnderecoPrincipalPessoaERP,	-- numero da caixa postal do endereco principal do Cliente
				LTRIM(RTRIM(A1_XREF1))						as enReferenciaEnderecoPrincipalPessoaERP,	-- Referencia do endereco principal do CLIENTE
				1											as cdPaisEnderecoCobrancaPessoaERP,			-- Pais do endereco de Cobranca do Cliente (1-Brasil) => Não achei o campo no Microsiga - estou assumindo 1-Brasil.
				LTRIM(RTRIM(A1_ENDCOB))						as enLogradouroEnderecoCobrancaPessoaERP,	-- Logradouro do endereco de cobranca do Cliente
				LTRIM(RTRIM(A1_XCOMPLC))					as enComplementoEnderecoCobrancaPessoaERP,	-- Complemento do Endereco de cobranca do Cliente
				LTRIM(RTRIM(A1_BAIRROC))					as enBairroEnderecoCobrancaPessoaERP,		-- Bairro do Endereco de cobranca do Cliente
				LTRIM(RTRIM(A1_MUNC))						as enMunicipioEnderecoCobrancaPessoaERP,	-- Municipio do Endereco de cobranca do Cliente
				LTRIM(RTRIM(A1_ESTC))						as cdSiglaEstadoEnderecoCobrancaPessoaERP,	-- Sigla do Estado do endereco de cobranca do Cliente
				LTRIM(RTRIM(A1_CEPC))						as nuCEPEnderecoCobrancaPessoaERP,		    -- Numero do CEP do endereco de cobranca do Cliente
				LTRIM(RTRIM(A1_XCXPC))						as nuCaixaPostalEnderecoCobrancaPessoaERP,	-- Numero da caixa postal do endereco de cobranca do Cliente
				LTRIM(RTRIM(A1_XREF2))						as enReferenciaEnderecoCobrancaPessoaERP,	-- Referencia do endereco de cobranca do Cliente
				1											as cdPaisEnderecoEntregaPessoaERP,			-- Pais do endereco de Entrega do Cliente (1-Brasil) => Não achei o campo no Microsiga - estou assumindo 1-Brasil.
				LTRIM(RTRIM(A1_ENDENT))						as enLogradouroEnderecoEntregaPessoaERP,	-- Logradouro do endereco de entrega do Cliente
				LTRIM(RTRIM(A1_XCOMPLI))					as enComplementoEnderecoEntregaPessoaERP,	-- Complemento do Endereco de entrega do Cliente
				LTRIM(RTRIM(A1_BAIRROE))					as enBairroEnderecoEntregaPessoaERP,		-- Bairro do Endereco de entrega do Cliente
				LTRIM(RTRIM(A1_MUNE))						as enMunicipioEnderecoEntregaPessoaERP, 	-- Municipio do Endereco de entrega do Cliente
				LTRIM(RTRIM(A1_ESTE))						as cdSiglaEstadoEnderecoEntregaPessoaERP,	-- Sigla do Estado do endereco de entrega do Cliente
				LTRIM(RTRIM(A1_CEPE))						as nuCEPEnderecoEntregaPessoaERP,		    -- Numero do CEP do endereco de entrega do Cliente
				LTRIM(RTRIM(A1_XCXPE))						as nuCaixaPostalEnderecoEntregaPessoaERP,	-- Numero da caixa postal do entrega de cobranca do Cliente
				NULL										as enReferenciaEnderecoEntregaPessoaERP,	-- Referencia do endereco de entrega do Cliente - não achei campo no microsiga
				1											as cdPaisTelefonePrincipalPessoaERP,		-- DDI do telefone principal do Cliente (1-Brasil/55) => Não achei campo no Microsiga - Estou assumindo como 1-Brasil 
				LTRIM(RTRIM(A1_DDD))						as nuDDDTelefonePrincipalPessoaERP,			-- DDD do telefone principal do Cliente
				LTRIM(RTRIM(A1_TEL))						as nuTelefonePrincipalPessoaERP,			-- numero do telefone principal do Cliente
				1											as cdPaisTelefoneFAXPessoaERP,				-- DDI do telefone de FAX do Cliente (1-Brasil/55) => não achei campo no microsiga - Estou assumindo como 1-Brasil
				NULL										as nuDDDTelefoneFAXPessoaERP,				-- DDD do telefone de FAX do Cliente => não achei campo no Microsiga
				LTRIM(RTRIM(A1_FAX))						as nuTelefoneFAXPessoaERP,					-- numero do telefone de FAX do Cliente
				1											as cdPaisTelefoneCelularPessoaERP,			-- DDI do telefone celular do Cliente (1-Brasil/55) => Não achei campo no Microsiga - Estou assumindo 1-Brasil
				NULL										as nuDDDTelefoneCelularPessoaERP,			-- DDD do telefone celular do Cliente => nao achei campo no Microsiga
				LTRIM(RTRIM(A1_XTELCEL))					as nuTelefoneCelularPessoaERP,				-- numero do telefone celular do Cliente
				LTRIM(RTRIM(A1_EMAIL))						as enEmailPrincipalPessoaERP,				-- Email do Cliente
				LTRIM(RTRIM(A1_CONTATO))					as nmContatoPrincipalPessoaERP,				-- Nome do contato principal do Cliente
				LTRIM(RTRIM(A1_XCONTAT))					as nmContatoCobrancaPessoaERP,				-- Nome do contato de cobranca do Cliente
				LTRIM(RTRIM(A1_VEND))						as cdAgenteComercialCCABPessoaERP,			-- Codigo do Agente Comercial CCAB responsável pelo Cliente				
				LTRIM(RTRIM(A1_XVEND2))						as cdAgenteComercialCooperativaPessoaERP,	-- Codigo do Agente Comercial Cooperativa responsável pelo Cliente
				LTRIM(RTRIM(A1_XVEND3))						as cdAgenteComercialRCPessoaERP,			-- Codigo do Agente Comercial RC responsável pelo Cliente
				LTRIM(RTRIM(A1_LOJA))						as cdCodigoLojaERP,							-- Codigo da Loja do Microsiga
				R_E_C_N_O_									as cdRecnoMicrosigaERP						-- Recno Microsiga
				
		-- FROM	DADOSAP8..SA1010 
		FROM BDTSWK301.DADOSAP8.dbo.SA1010
		WHERE	D_E_L_E_T_ = ''			-- Trazer os registros Ativos do sistema
				
		OPEN CS_Cliente
		FETCH NEXT FROM CS_Cliente
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
		        @cdAgenteComercialCCABPessoaERP,
		        @cdAgenteComercialCooperativaPessoaERP,
		        @cdAgenteComercialRCPessoaERP,
		        @cdCodigoLojaERP,
		        @cdRecnoMicrosigaERP
		        							
		SET @Fetch_Cliente = @@FETCH_STATUS
		
		WHILE @Fetch_Cliente = 0
		BEGIN

			--// CONSISTÊNCIAS

			-- Verifica se o Codigo do Cliente foi informado
			IF isnull(@cdPessoaERP,'') = '' 
			BEGIN
				PRINT 'Codigo do Cliente do ERP não Informado'
				PRINT @nmPessoaERP
				CLOSE CS_Cliente
				DEALLOCATE CS_Cliente
				RAISERROR ('Codigo do Cliente do ERP não Informado',16,1)
				RETURN
			END
			
			-- Verifica se o Status do Cliente foi informado
			IF isnull(@cdIndicadorStatusPessoaERP,0) = 0 
			BEGIN
				PRINT 'Status do Cliente do ERP não Informado'
				PRINT @nmPessoaERP
				CLOSE CS_Cliente
				DEALLOCATE CS_Cliente
				RAISERROR ('Status do Cliente do ERP não Informado',16,1)
				RETURN
			END

			-- Verifica se o Indicador do Cliente foi informado
			IF isnull(@cdIndicadorPessoaERP,0) = 0 
			BEGIN
				PRINT 'Indicador do Cliente do ERP não Informado'
				PRINT @nmPessoaERP
				CLOSE CS_Cliente
				DEALLOCATE CS_Cliente
				RAISERROR ('Indicador do Cliente do ERP não Informado',16,1)
				RETURN
			END

			-- Verifica se o Nome do Cliente foi informado
			IF isnull(@nmPessoaERP,'') = ''
			BEGIN
				PRINT 'Nome do Cliente não Informado'
				PRINT @cdPessoaERP
				CLOSE CS_Cliente
				DEALLOCATE CS_Cliente
				RAISERROR ('Nome do Cliente não Informado',16,1)
				RETURN			
			END

			-- Verifica se o Agente Comercial Cooperativa está cadastrado no SFA
			SET @cdAgentecomercialCooperativaPessoa = NULL
			IF isnull(@cdAgenteComercialCooperativaPessoaERP,'') <> ''
			BEGIN
				IF NOT EXISTS (	SELECT	1 FROM Pessoa
								WHERE	cdPessoaERP = @cdAgenteComercialCooperativaPessoaERP
								AND     cdIndicadorTipoPerfilPessoa = 3)
				BEGIN
					PRINT 'Codigo do Agente Comercial Cooperativa não cadastrado no SFA'
					PRINT @cdAgenteComercialCooperativaPessoaERP
					CLOSE CS_Cliente
					DEALLOCATE CS_Cliente
					RAISERROR ('Codigo do Agente Comercial Cooperativa não cadastrado no SFA',16,1)
					RETURN		
				END
				
				-- Busca codigo do Agente Comercial Cooperativa no SFA
				SET @cdAgenteComercialCooperativaPessoa = 0
				SELECT	@cdAgenteComercialCooperativaPessoa = cdPessoaSEQ
				FROM	Pessoa
				WHERE	cdPessoaERP = @cdAgenteComercialCooperativaPessoaERP
				AND     cdIndicadorTipoPerfilPessoa = 3
				
				IF @cdAgenteComercialCooperativaPessoa = 0
				BEGIN
					PRINT 'Codigo do Agente Comercial Cooperativa não cadastrado no SFA'
					PRINT @cdAgenteComercialCooperativaPessoaERP
					CLOSE CS_Cliente
					DEALLOCATE CS_Cliente
					RAISERROR ('Codigo do Agente Comercial Cooperativa não cadastrado no SFA',16,1)
					RETURN	
				END	

			END
			
			-- Verifica se o Agente Comercial RC está cadastrado no SFA
			SET @cdAgentecomercialRCPessoa = NULL
			IF ISNULL(@cdAgenteComercialRCPessoaERP,'') <> ''
			BEGIN
				IF NOT EXISTS (	SELECT	1 FROM Pessoa
								WHERE	cdPessoaERP = @cdAgenteComercialRCPessoaERP
								AND     cdIndicadorTipoPerfilPessoa = 3)
				BEGIN
					PRINT 'Codigo do Agente Comercial RC não cadastrado no SFA'
					PRINT @cdAgenteComercialRCPessoaERP
					CLOSE CS_Cliente
					DEALLOCATE CS_Cliente
					RAISERROR ('Codigo do Agente Comercial RC não cadastrado no SFA',16,1)
					RETURN		
				END
				
				-- Busca codigo do Agente Comercial RC no SFA
				SET @cdAgenteComercialRCPessoa = 0
				SELECT	@cdAgenteComercialRCPessoa = cdPessoaSEQ
				FROM	Pessoa
				WHERE	cdPessoaERP = @cdAgenteComercialRCPessoaERP
				AND     cdIndicadorTipoPerfilPessoa = 3
				
				IF @cdAgenteComercialRCPessoa = 0
				BEGIN
					PRINT 'Codigo do Agente Comercial RC não cadastrado no SFA'
					PRINT @cdAgenteComercialRCPessoaERP
					CLOSE CS_Cliente
					DEALLOCATE CS_Cliente
					RAISERROR ('Codigo do Agente Comercial RC não cadastrado no SFA',16,1)
					RETURN		
				END
				
			END

			-- Verifica se o Agente Comercial CCAB está cadastrado no SFA
			SET @cdAgentecomercialCCABPessoa = NULL
			IF ISNULL(@cdAgenteComercialCCABPessoaERP,'') <> ''
			BEGIN
				IF NOT EXISTS (	SELECT	1 FROM Pessoa
								WHERE	cdPessoaERP = @cdAgenteComercialCCABPessoaERP
								AND     cdIndicadorTipoPerfilPessoa = 3)
				BEGIN
					PRINT 'Codigo do Agente Comercial CCAB não cadastrado no SFA'
					PRINT @cdAgenteComercialCCABPessoaERP
					CLOSE CS_Cliente
					DEALLOCATE CS_Cliente
					RAISERROR ('Codigo do Agente Comercial CCAB não cadastrado no SFA',16,1)
					RETURN		
				END
				
				-- Busca codigo do Agente Comercial CCAB no SFA
				SET @cdAgenteComercialCCABPessoa = 0
				SELECT	@cdAgenteComercialCCABPessoa = cdPessoaSEQ
				FROM	Pessoa
				WHERE	cdPessoaERP = @cdAgenteComercialCCABPessoaERP
				AND     cdIndicadorTipoPerfilPessoa = 3
				
				IF @cdAgenteComercialCCABPessoa = 0
				BEGIN
					PRINT 'Codigo do Agente Comercial CCAB não cadastrado no SFA'
					PRINT @cdAgenteComercialCCABPessoaERP
					CLOSE CS_Cliente
					DEALLOCATE CS_Cliente
					RAISERROR ('Codigo do Agente Comercial CCAB não cadastrado no SFA',16,1)
					RETURN		
				END
				
			END

			-- Verifica se o registro existe no SFA
			IF EXISTS (	SELECT 1 FROM Pessoa 
						WHERE cdPessoaERP = @cdPessoaERP
						AND   cdIndicadorTipoPerfilPessoa = 1)  -- Cliente	--
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
					,@enComplementoEnderecoPrincipalPessoa	= enComplementoEnderecoPrincipalPessoa					
					,@enBairroEnderecoPrincipalPessoa		= enBairroEnderecoPrincipalPessoa
					,@enMunicipioEnderecoPrincipalPessoa	= enMunicipioEnderecoPrincipalPessoa
					,@cdSiglaEstadoEnderecoPrincipalPessoa	= cdSiglaEstadoEnderecoPrincipalPessoa
					,@nuCEPEnderecoPrincipalPessoa			= nuCEPEnderecoPrincipalPessoa
					,@nuCaixaPostalEnderecoPrincipalPessoa	= nuCaixaPostalEnderecoPrincipalPessoa
					,@enReferenciaEnderecoPrincipalPessoa	= enReferenciaEnderecoPrincipalPessoa

					,@cdPaisEnderecoCobrancaPessoa			= cdPaisEnderecoCobrancaPessoa
					,@enLogradouroEnderecoCobrancaPessoa	= enLogradouroEnderecoCobrancaPessoa
					,@enComplementoEnderecoCobrancaPessoa	= enComplementoEnderecoCobrancaPessoa
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

					,@cdAgenteComercialRCPessoaOriginal				= cdAgenteComercialRCPessoa	
					,@cdAgenteComercialCooperativaPessoaOriginal	= cdAgenteComercialCooperativaPessoa
					,@cdAgenteComercialCCABPessoaOriginal			= cdAgenteComercialCCABPessoa
					
					,@cdRecnoMicrosiga						= cdRecnoMicrosiga

				FROM	
					Pessoa
				WHERE	
					cdPessoaERP					= @cdPessoaERP
				and	cdIndicadorTipoPerfilPessoa	= 1 --Cliente


				-- Verifica se os Valores estao Diferentes do Microsiga
				IF	 
					rtrim(ltrim(isnull(@cdIndicadorStatusPessoa,0)))				<> rtrim(ltrim(isnull(@cdIndicadorStatusPessoaERP,0)))		OR
					rtrim(ltrim(isnull(@cdIndicadorPessoa,0)))						<> rtrim(ltrim(isnull(@cdIndicadorPessoaERP,0)))			OR
					rtrim(ltrim(isnull(@nmPessoa,'')))								<> rtrim(ltrim(isnull(@nmPessoaERP,'')))					OR
					rtrim(ltrim(isnull(@nmReduzidoPessoa,'')))						<> rtrim(ltrim(isnull(@nmReduzidoPessoaERP,'')))			OR
					rtrim(ltrim(isnull(@nuCNPJCPFPessoa,'')))						<> rtrim(ltrim(isnull(@nuCNPJCPFPessoaERP,'')))				OR
					rtrim(ltrim(isnull(@nuInscricaoEstadualPessoa,'')))				<> rtrim(ltrim(isnull(@nuInscricaoEstadualPessoaERP,'')))	OR
					rtrim(ltrim(isnull(@nuInscricaoMunicipalPessoa,'')))			<> rtrim(ltrim(isnull(@nuInscricaoMunicipalPessoaERP,'')))	OR
					rtrim(ltrim(isnull(@nuInscricaoRuralPessoa,'')))				<> rtrim(ltrim(isnull(@nuInscricaoRuralPessoaERP,'')))		OR
					rtrim(ltrim(isnull(@nuRGCedulaEstrangeiroPessoa,'')))			<> rtrim(ltrim(isnull(@nuRGCedulaEstrangeiroPessoaERP,'')))	OR
					rtrim(ltrim(isnull(@cdNacionalidadePessoa,0)))					<> rtrim(ltrim(isnull(@cdNacionalidadePessoaERP,0)))		OR
					rtrim(ltrim(isnull(@dtNascimentoPessoa,'')))					<> rtrim(ltrim(isnull(@dtNascimentoPessoaERP,'')))			OR
					rtrim(ltrim(isnull(@cdIndicadorSexoPessoa,0)))					<> rtrim(ltrim(isnull(@cdIndicadorSexoPessoaERP,0)))		OR
					rtrim(ltrim(isnull(@cdIndicadorEstadoCivilPessoa,0)))			<> rtrim(ltrim(isnull(@cdIndicadorEstadoCivilPessoaERP,0)))	OR
					
					rtrim(ltrim(isnull(@cdPaisEnderecoPrincipalPessoa,0)))			<> rtrim(ltrim(isnull(@cdPaisEnderecoPrincipalPessoaERP,0)))			OR
					rtrim(ltrim(isnull(@enLogradouroEnderecoPrincipalPessoa,'')))	<> rtrim(ltrim(isnull(@enLogradouroEnderecoPrincipalPessoaERP,'')))		OR
					rtrim(ltrim(isnull(@enComplementoEnderecoPrincipalPessoa,'')))	<> rtrim(ltrim(isnull(@enComplementoEnderecoPrincipalPessoaERP,'')))	OR					
					rtrim(ltrim(isnull(@enBairroEnderecoPrincipalPessoa,'')))		<> rtrim(ltrim(isnull(@enBairroEnderecoPrincipalPessoaERP,'')))			OR
					rtrim(ltrim(isnull(@enMunicipioEnderecoPrincipalPessoa,'')))	<> rtrim(ltrim(isnull(@enMunicipioEnderecoPrincipalPessoaERP,'')))		OR
					rtrim(ltrim(isnull(@cdSiglaEstadoEnderecoPrincipalPessoa,'')))	<> rtrim(ltrim(isnull(@cdSiglaEstadoEnderecoPrincipalPessoaERP,'')))	OR
					rtrim(ltrim(isnull(@nuCEPEnderecoPrincipalPessoa,'')))			<> rtrim(ltrim(isnull(@nuCEPEnderecoPrincipalPessoaERP,'')))			OR
					rtrim(ltrim(isnull(@nuCaixaPostalEnderecoPrincipalPessoa,'')))	<> rtrim(ltrim(isnull(@nuCaixaPostalEnderecoPrincipalPessoaERP,'')))	OR
					rtrim(ltrim(isnull(@enReferenciaEnderecoPrincipalPessoa,'')))	<> rtrim(ltrim(isnull(@enReferenciaEnderecoPrincipalPessoaERP,'')))		OR

					rtrim(ltrim(isnull(@cdPaisEnderecoCobrancaPessoa,0)))			<> rtrim(ltrim(isnull(@cdPaisEnderecoCobrancaPessoaERP,0)))				OR
					rtrim(ltrim(isnull(@enLogradouroEnderecoCobrancaPessoa,'')))	<> rtrim(ltrim(isnull(@enLogradouroEnderecoCobrancaPessoaERP,'')))		OR
					rtrim(ltrim(isnull(@enComplementoEnderecoCobrancaPessoa,'')))	<> rtrim(ltrim(isnull(@enComplementoEnderecoCobrancaPessoaERP,'')))		OR
					rtrim(ltrim(isnull(@enBairroEnderecoCobrancaPessoa,'')))		<> rtrim(ltrim(isnull(@enBairroEnderecoCobrancaPessoaERP,'')))			OR
					rtrim(ltrim(isnull(@enMunicipioEnderecoCobrancaPessoa,'')))		<> rtrim(ltrim(isnull(@enMunicipioEnderecoCobrancaPessoaERP,'')))		OR
					rtrim(ltrim(isnull(@cdSiglaEstadoEnderecoCobrancaPessoa,'')))	<> rtrim(ltrim(isnull(@cdSiglaEstadoEnderecoCobrancaPessoaERP,'')))		OR
					rtrim(ltrim(isnull(@nuCEPEnderecoCobrancaPessoa,'')))			<> rtrim(ltrim(isnull(@nuCEPEnderecoCobrancaPessoaERP,'')))				OR
					rtrim(ltrim(isnull(@nuCaixaPostalEnderecoCobrancaPessoa,'')))	<> rtrim(ltrim(isnull(@nuCaixaPostalEnderecoCobrancaPessoaERP,'')))		OR
					rtrim(ltrim(isnull(@enReferenciaEnderecoCobrancaPessoa,'')))	<> rtrim(ltrim(isnull(@enReferenciaEnderecoCobrancaPessoaERP,'')))		OR

					rtrim(ltrim(isnull(@cdPaisEnderecoEntregaPessoa,0)))			<> rtrim(ltrim(isnull(@cdPaisEnderecoEntregaPessoaERP,0)))				OR
					rtrim(ltrim(isnull(@enLogradouroEnderecoEntregaPessoa,'')))		<> rtrim(ltrim(isnull(@enLogradouroEnderecoEntregaPessoaERP,'')))		OR
					rtrim(ltrim(isnull(@enComplementoEnderecoEntregaPessoa,'')))	<> rtrim(ltrim(isnull(@enComplementoEnderecoEntregaPessoaERP,'')))		OR
					rtrim(ltrim(isnull(@enBairroEnderecoEntregaPessoa,'')))			<> rtrim(ltrim(isnull(@enBairroEnderecoEntregaPessoaERP,'')))			OR
					rtrim(ltrim(isnull(@enMunicipioEnderecoEntregaPessoa,'')))		<> rtrim(ltrim(isnull(@enMunicipioEnderecoEntregaPessoaERP,'')))		OR
					rtrim(ltrim(isnull(@cdSiglaEstadoEnderecoEntregaPessoa,'')))	<> rtrim(ltrim(isnull(@cdSiglaEstadoEnderecoEntregaPessoaERP,'')))		OR
					rtrim(ltrim(isnull(@nuCEPEnderecoEntregaPessoa,'')))			<> rtrim(ltrim(isnull(@nuCEPEnderecoEntregaPessoaERP,'')))				OR
					rtrim(ltrim(isnull(@nuCaixaPostalEnderecoEntregaPessoa,'')))	<> rtrim(ltrim(isnull(@nuCaixaPostalEnderecoEntregaPessoaERP,'')))		OR
					rtrim(ltrim(isnull(@enReferenciaEnderecoEntregaPessoa,'')))		<> rtrim(ltrim(isnull(@enReferenciaEnderecoEntregaPessoaERP,'')))		OR

					rtrim(ltrim(isnull(@cdPaisTelefonePrincipalPessoa,0)))			<> rtrim(ltrim(isnull(@cdPaisTelefonePrincipalPessoaERP,0)))			OR
					rtrim(ltrim(isnull(@nuDDDTelefonePrincipalPessoa,'')))			<> rtrim(ltrim(isnull(@nuDDDTelefonePrincipalPessoaERP,'')))			OR
					rtrim(ltrim(isnull(@nuTelefonePrincipalPessoa,'')))				<> rtrim(ltrim(isnull(@nuTelefonePrincipalPessoaERP,'')))				OR

					rtrim(ltrim(isnull(@cdPaisTelefoneFAXPessoa,0)))				<> rtrim(ltrim(isnull(@cdPaisTelefoneFAXPessoaERP,0)))				OR
					rtrim(ltrim(isnull(@nuDDDTelefoneFAXPessoa,'')))				<> rtrim(ltrim(isnull(@nuDDDTelefoneFAXPessoaERP,'')))				OR
					rtrim(ltrim(isnull(@nuTelefoneFAXPessoa,'')))					<> rtrim(ltrim(isnull(@nuTelefoneFAXPessoaERP,'')))					OR

					rtrim(ltrim(isnull(@cdPaisTelefoneCelularPessoa,0)))			<> rtrim(ltrim(isnull(@cdPaisTelefoneCelularPessoaERP,0)))			OR
					rtrim(ltrim(isnull(@nuDDDTelefoneCelularPessoa,'')))			<> rtrim(ltrim(isnull(@nuDDDTelefoneCelularPessoaERP,'')))			OR
					rtrim(ltrim(isnull(@nuTelefoneCelularPessoa,'')))				<> rtrim(ltrim(isnull(@nuTelefoneCelularPessoaERP,'')))				OR

					rtrim(ltrim(isnull(@enEmailPrincipalPessoa,'')))				<> rtrim(ltrim(isnull(@enEmailPrincipalPessoaERP,'')))				OR
					rtrim(ltrim(isnull(@nmContatoPrincipalPessoa,'')))				<> rtrim(ltrim(isnull(@nmContatoPrincipalPessoaERP,'')))			OR
					rtrim(ltrim(isnull(@nmContatoCobrancaPessoa,'')))				<> rtrim(ltrim(isnull(@nmContatoCobrancaPessoaERP,'')))				OR	

					rtrim(ltrim(isnull(@cdAgenteComercialRCPessoaOriginal,0)))			<> rtrim(ltrim(isnull(@cdAgenteComercialRCPessoa,0)))				OR
					rtrim(ltrim(isnull(@cdAgenteComercialCooperativaPessoaOriginal,0)))	<> rtrim(ltrim(isnull(@cdAgenteComercialCooperativaPessoa,0)))		OR	
					rtrim(ltrim(isnull(@cdAgenteComercialCCABPessoaOriginal,0)))		<> rtrim(ltrim(isnull(@cdAgenteComercialCCABPessoa,0)))				OR
					
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

						,enEmailPrincipalPessoa					= @enEmailPrincipalPessoaERP					
						,nmContatoPrincipalPessoa				= @nmContatoPrincipalPessoaERP				
						,nmContatoCobrancaPessoa				= @nmContatoCobrancaPessoaERP				

						,cdAgenteComercialRCPessoa				= @cdAgenteComercialRCPessoa				
						,cdAgenteComercialCooperativaPessoa		= @cdAgenteComercialCooperativaPessoa	
						,cdAgenteComercialCCABPessoa			= @cdAgenteComercialCCABPessoa	
						
						,cdRecnoMicrosiga						= @cdRecnoMicrosigaERP	

						,dtUltimaAlteracao						= getdate()
						,cdUsuarioUltimaAlteracao				= 9999 -- Codigo Microsiga
						
					WHERE 
						cdPessoaSEQ							= @cdPessoaSEQ
					and	cdIndicadorTipoPerfilPessoa			= 1 --Cliente 	
				
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
					
					-- Verifica se o Cliente foi desligado (status inativo no Microsiga)
					if isnull(@cdIndicadorStatusPessoaERP,0) = 2 -- Inativo 
					begin
					
						UPDATE Pessoa
						SET	cdIndicadorSenhaBloqueadaPessoa = 1	-- Bloqueada
						   ,dtUltimaAlteracao = getdate()
						   ,cdUsuarioUltimaAlteracao = 9999 -- Codigo Microsiga
						WHERE cdPessoaSEQ = @cdPessoaSEQ 
						AND   cdIndicadorTipoPerfilPessoa = 1	-- Cliente
					
						-- Verifica Erro no Update
						IF @@ERROR <> 0  OR @@ROWCOUNT = 0
						BEGIN
							PRINT 'Erro no Update do Cliente - bloqueio senha'
							PRINT @cdPessoaERP + ' - ' + @nmPessoaERP
							CLOSE CS_Cliente
							DEALLOCATE CS_Cliente
							RAISERROR ('Erro no Update do Cliente - bloqueio senha',16,1)
							RETURN
						END
					
						PRINT 'UPDATE BLOQUEIO - ' + @cdPessoaERP + ' - ' + @nmPessoaERP					
					
					end
					

					PRINT 'UPDATE - ' + @cdPessoaERP + ' - ' + @nmPessoaERP 
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
						,cdRecnoMicrosiga
					)
				VALUES
					(
						@cdPessoaERP
						,1 -- Cliente
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
						,@cdAgenteComercialRCPessoa
						,@cdAgenteComercialCooperativaPessoa
						,@cdAgenteComercialCCABPessoa
						,21 -- @cdGrupoAcessoSEQ - grupo de Cliente
						,getdate()
						,9999 -- sera assumido 9999 para o Microsiga
						,@cdRecnoMicrosigaERP
					)
						
				IF @@ERROR <> 0
				BEGIN
					PRINT 'Erro na Inclusao do Cliente na Base do SFA'
					PRINT @cdPessoaERP
					CLOSE CS_Cliente
					DEALLOCATE CS_Cliente
					RAISERROR ('Erro na Inclusao do Cliente na Base do SFA',16,1)
					RETURN
				END

				PRINT 'INSERT - ' + @cdPessoaERP + ' - ' + @nmPessoaERP
				
			END
			
			FETCH NEXT FROM CS_Cliente
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
					@cdAgenteComercialCCABPessoaERP,
					@cdAgenteComercialCooperativaPessoaERP,
					@cdAgenteComercialRCPessoaERP,
					@cdCodigoLojaERP,
					@cdRecnoMicrosigaERP
						
			SET @Fetch_Cliente = @@FETCH_STATUS
			
		END
		
		CLOSE CS_Cliente
		DEALLOCATE CS_Cliente
		
		--- Verifica Exclusao do Cliente
		--- (mudanca de status da Situação e Bloqueio de Senha)
		
		-- Define Cursor para Verificar registros Excluidos no Microsiga
		DECLARE CS_ClienteExclusao CURSOR FOR
		SELECT	cdPessoaSEQ
		FROM	Pessoa a
		-- WHERE	NOT EXISTS (	SELECT 1 FROM DADOSAP8..SA1010 b
		WHERE NOT EXISTS ( SELECT 1 FROM BDTSWK301.DADOSAP8.dbo.SA1010 b
								WHERE  (	LTRIM(RTRIM(b.A1_COD))	+
											STUFF('00', CASE LEN(LTRIM(RTRIM(b.A1_LOJA))) 
												WHEN 2 THEN 1 
												WHEN 1 THEN 2 
												ELSE 1 
											END, 
											LEN(LTRIM(RTRIM(b.A1_LOJA))), LTRIM(RTRIM(b.A1_LOJA)))) = a.cdPessoaERP collate SQL_Latin1_General_CP1_CI_AS  
								AND    D_E_L_E_T_ = '')
		and		a.cdIndicadorTipoPerfilPessoa = 1		-- Cliente
		AND		a.cdIndicadorStatusPessoa = 1			-- ATivo
		AND     a.cdIndicadorSenhaBloqueadaPessoa = 2	-- Não esta bloqueada
		
		OPEN CS_ClienteExclusao
		FETCH NEXT FROM CS_ClienteExclusao
		INTO	@cdPessoaSEQ           
						
		SET @Fetch_Cliente = @@FETCH_STATUS
		
		WHILE @Fetch_Cliente = 0
		BEGIN
	
			-- Atualiza Registro no SFA		
			UPDATE Pessoa
			SET	cdIndicadorStatusPessoa = 2
			   ,cdIndicadorSenhaBloqueadaPessoa = 1	-- Bloqueada
			   ,dtUltimaAlteracao = getdate()
			   ,cdUsuarioUltimaAlteracao = 9999 -- Codigo Microsiga
			WHERE cdPessoaSEQ	= @cdPessoaSEQ
			AND   cdIndicadorTipoPerfilPessoa = 1	-- Cliente
				
			-- Verifica Erro no Update
			IF @@ERROR <> 0  OR @@ROWCOUNT = 0
			BEGIN
				PRINT 'Erro no Update do Cliente - Exclusão'
				PRINT @cdPessoaERP 
				CLOSE CS_ClienteExclusao
				DEALLOCATE CS_ClienteExclusao
				RAISERROR ('Erro no Update do Cliente - Exclusão',16,1)
				RETURN
			END

			PRINT 'EXCLUSAO - ' + str(@cdPessoaSEQ)

			FETCH NEXT FROM CS_ClienteExclusao
			INTO	@cdPessoaSEQ           
						
			SET @Fetch_Cliente = @@FETCH_STATUS
						
		END	
		
		CLOSE CS_ClienteExclusao
		DEALLOCATE CS_ClienteExclusao		
		
		RETURN
		
	END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


