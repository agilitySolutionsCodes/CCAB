set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_Pessoa.sql
**		Name: TR_Pessoa
**		Desc: Trigger de históricos da tabela Pessoa
**
**		Auth: Convergence
**		Date: 30/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_Pessoa]'))
BEGIN
	DROP TRIGGER [dbo].[TR_Pessoa]
END
GO
 
CREATE TRIGGER [dbo].[TR_Pessoa] ON dbo.Pessoa
AFTER INSERT, UPDATE
AS
 
declare
	@cdTipoEventoHistorico		int
 
	IF EXISTS (SELECT * FROM deleted)	-- Alteração
	BEGIN
		select
			@cdTipoEventoHistorico	= 2
	END
	ELSE
	BEGIN
		select
			@cdTipoEventoHistorico	= 1
	END
 
	--inserção
	INSERT INTO PessoaHistorico
	(
		 cdPessoaSEQ
		,cdPessoaERP
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
		,cdPaisEnderecoPrincipalPessoa
		,cdPaisEnderecoCobrancaPessoa
		,cdPaisTelefonePrincipalPessoa
		,cdPaisTelefoneFAXPessoa
		,cdPaisTelefoneCelularPessoa
		,dtNascimentoPessoa
		,cdIndicadorSexoPessoa
		,cdIndicadorEstadoCivilPessoa
		,enLogradouroEnderecoPrincipalPessoa
		,enBairroEnderecoPrincipalPessoa
		,enMunicipioEnderecoPrincipalPessoa
		,cdSiglaEstadoEnderecoPrincipalPessoa
		,nuCEPEnderecoPrincipalPessoa
		,nuCaixaPostalEnderecoPrincipalPessoa
		,enReferenciaEnderecoPrincipalPessoa
		,enLogradouroEnderecoCobrancaPessoa
		,enComplementoEnderecoCobrancaPessoa
		,enComplementoEnderecoPrincipalPessoa
		,enBairroEnderecoCobrancaPessoa
		,enMunicipioEnderecoCobrancaPessoa
		,cdSiglaEstadoEnderecoCobrancaPessoa
		,nuCEPEnderecoCobrancaPessoa
		,nuCaixaPostalEnderecoCobrancaPessoa
		,enReferenciaEnderecoCobrancaPessoa
		,enLogradouroEnderecoEntregaPessoa
		,cdPaisEnderecoEntregaPessoa
		,enComplementoEnderecoEntregaPessoa
		,enBairroEnderecoEntregaPessoa
		,enMunicipioEnderecoEntregaPessoa
		,cdSiglaEstadoEnderecoEntregaPessoa
		,nuCEPEnderecoEntregaPessoa
		,nuCaixaPostalEnderecoEntregaPessoa
		,enReferenciaEnderecoEntregaPessoa
		,nuDDDTelefonePrincipalPessoa
		,nuTelefonePrincipalPessoa
		,nuDDDTelefoneFAXPessoa
		,nuTelefoneFAXPessoa
		,nuDDDTelefoneCelularPessoa
		,nuTelefoneCelularPessoa
		,enEmailPrincipalPessoa
		,nmContatoPrincipalPessoa
		,nmContatoCobrancaPessoa
		,cdGrupoAcessoSEQ
		,cdAgenteComercialRCPessoa
		,cdAgenteComercialCooperativaPessoa
		,cdAgenteComercialCCABPessoa
		,cdEmpresaColaboradorPessoa
		,cdTipoEventoHistorico
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
		,cdIndicadorTipoAgenteComercialPessoa
		,cdIndicadorEnvioEmailPrimeiroAcesso
		,cdRecnoMicrosiga
	)
	SELECT
		 cdPessoaSEQ
		,cdPessoaERP
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
		,cdPaisEnderecoPrincipalPessoa
		,cdPaisEnderecoCobrancaPessoa
		,cdPaisTelefonePrincipalPessoa
		,cdPaisTelefoneFAXPessoa
		,cdPaisTelefoneCelularPessoa
		,dtNascimentoPessoa
		,cdIndicadorSexoPessoa
		,cdIndicadorEstadoCivilPessoa
		,enLogradouroEnderecoPrincipalPessoa
		,enBairroEnderecoPrincipalPessoa
		,enMunicipioEnderecoPrincipalPessoa
		,cdSiglaEstadoEnderecoPrincipalPessoa
		,nuCEPEnderecoPrincipalPessoa
		,nuCaixaPostalEnderecoPrincipalPessoa
		,enReferenciaEnderecoPrincipalPessoa
		,enLogradouroEnderecoCobrancaPessoa
		,enComplementoEnderecoCobrancaPessoa
		,enComplementoEnderecoPrincipalPessoa
		,enBairroEnderecoCobrancaPessoa
		,enMunicipioEnderecoCobrancaPessoa
		,cdSiglaEstadoEnderecoCobrancaPessoa
		,nuCEPEnderecoCobrancaPessoa
		,nuCaixaPostalEnderecoCobrancaPessoa
		,enReferenciaEnderecoCobrancaPessoa
		,enLogradouroEnderecoEntregaPessoa
		,cdPaisEnderecoEntregaPessoa
		,enComplementoEnderecoEntregaPessoa
		,enBairroEnderecoEntregaPessoa
		,enMunicipioEnderecoEntregaPessoa
		,cdSiglaEstadoEnderecoEntregaPessoa
		,nuCEPEnderecoEntregaPessoa
		,nuCaixaPostalEnderecoEntregaPessoa
		,enReferenciaEnderecoEntregaPessoa
		,nuDDDTelefonePrincipalPessoa
		,nuTelefonePrincipalPessoa
		,nuDDDTelefoneFAXPessoa
		,nuTelefoneFAXPessoa
		,nuDDDTelefoneCelularPessoa
		,nuTelefoneCelularPessoa
		,enEmailPrincipalPessoa
		,nmContatoPrincipalPessoa
		,nmContatoCobrancaPessoa
		,cdGrupoAcessoSEQ
		,cdAgenteComercialRCPessoa
		,cdAgenteComercialCooperativaPessoa
		,cdAgenteComercialCCABPessoa
		,cdEmpresaColaboradorPessoa
		,@cdTipoEventoHistorico
		,getdate()
		,cdUsuarioUltimaAlteracao
		,cdIndicadorTipoAgenteComercialPessoa
		,cdIndicadorEnvioEmailPrimeiroAcesso
		,cdRecnoMicrosiga

	FROM
		inserted
