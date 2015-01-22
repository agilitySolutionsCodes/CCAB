set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_Pessoa_Cliente.sql
**		Name: SP_S_Pessoa_Cliente
**		Desc: Obtem um registro da tabela Pessoa - Cliente
**
**		Auth: Convergence
**		Date: 16/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_Pessoa_Cliente]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_Pessoa_Cliente]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_Pessoa_Cliente]
	 @cdPessoaSEQ	BIGINT
 
 
AS
 
	--seleção
	SELECT 
		 PES.cdPessoaSEQ
		,PES.cdPessoaERP
		,PES.cdIndicadorTipoPerfilPessoa
		,PES.cdIndicadorStatusPessoa
		,PES.cdIndicadorPessoa
		,PES.cdIndicadorTipoAcessoPessoa
		,PES.dsLoginPessoa
		,PES.dsSenhaLoginPessoa
		,PES.cdIndicadorPrimeiroAcessoPessoa
		,PES.cdIndicadorSenhaBloqueadaPessoa
		,PES.nmPessoa
		,PES.nmReduzidoPessoa
		,PES.nmFoneticoPessoa
		,PES.nuCNPJCPFPessoa
		,PES.nuInscricaoEstadualPessoa
		,PES.nuInscricaoMunicipalPessoa
		,PES.nuInscricaoRuralPessoa
		,PES.nuRGCedulaEstrangeiroPessoa
		,PES.cdNacionalidadePessoa
		,PES.dtNascimentoPessoa
		,PES.cdIndicadorSexoPessoa
		,PES.cdIndicadorEstadoCivilPessoa
		,PES.cdPaisEnderecoPrincipalPessoa
		,PES.enLogradouroEnderecoPrincipalPessoa
		,PES.enBairroEnderecoPrincipalPessoa
		,PES.enMunicipioEnderecoPrincipalPessoa
		,PES.cdSiglaEstadoEnderecoPrincipalPessoa
		,PES.nuCEPEnderecoPrincipalPessoa
		,PES.nuCaixaPostalEnderecoPrincipalPessoa
		,PES.enReferenciaEnderecoPrincipalPessoa
		,PES.cdPaisEnderecoCobrancaPessoa
		,PES.enLogradouroEnderecoCobrancaPessoa
		,PES.enComplementoEnderecoCobrancaPessoa
		,PES.enComplementoEnderecoPrincipalPessoa
		,PES.enBairroEnderecoCobrancaPessoa
		,PES.enMunicipioEnderecoCobrancaPessoa
		,PES.cdSiglaEstadoEnderecoCobrancaPessoa
		,PES.nuCEPEnderecoCobrancaPessoa
		,PES.nuCaixaPostalEnderecoCobrancaPessoa
		,PES.enReferenciaEnderecoCobrancaPessoa
		,PES.cdPaisEnderecoEntregaPessoa
		,PES.enLogradouroEnderecoEntregaPessoa
		,PES.enComplementoEnderecoEntregaPessoa
		,PES.enBairroEnderecoEntregaPessoa
		,PES.enMunicipioEnderecoEntregaPessoa
		,PES.cdSiglaEstadoEnderecoEntregaPessoa
		,PES.nuCEPEnderecoEntregaPessoa
		,PES.nuCaixaPostalEnderecoEntregaPessoa
		,PES.enReferenciaEnderecoEntregaPessoa
		,PES.cdPaisTelefonePrincipalPessoa
		,PES.nuDDDTelefonePrincipalPessoa
		,PES.nuTelefonePrincipalPessoa
		,PES.cdPaisTelefoneFAXPessoa
		,PES.nuDDDTelefoneFAXPessoa
		,PES.nuTelefoneFAXPessoa
		,PES.cdPaisTelefoneCelularPessoa
		,PES.nuDDDTelefoneCelularPessoa
		,PES.nuTelefoneCelularPessoa
		,PES.enEmailPrincipalPessoa
		,PES.nmContatoPrincipalPessoa
		,PES.nmContatoCobrancaPessoa
		,PES.cdEmpresaColaboradorPessoa
		,PES.cdAgenteComercialRCPessoa
		,PES.cdAgenteComercialCooperativaPessoa
		,PES.cdAgenteComercialCCABPessoa
		,PES.cdGrupoAcessoSEQ
		,PES.dtUltimaAlteracao
		,PES.cdUsuarioUltimaAlteracao
		,PES.cdIndicadorTipoAgenteComercialPessoa


		,(
			SELECT 
				isnull(nmPessoa, '') + '-' + isnull(cdPessoaERP, '')
			FROM
				dbo.Pessoa	ARC	(nolock)
			WHERE
				ARC.cdPessoaSEQ = PES.cdAgenteComercialRCPessoa
		)	as nmAgenteComercialRCPessoa

		,(
			SELECT 
				isnull(nmPessoa, '') + '-' + isnull(cdPessoaERP, '')
			FROM
				dbo.Pessoa	ACC	(nolock)
			WHERE
				ACC.cdPessoaSEQ = PES.cdAgenteComercialCooperativaPessoa
		)	as nmAgenteComercialCooperativaPessoa

		,(
			SELECT 
				isnull(nmPessoa, '') + '-' + isnull(cdPessoaERP, '')
			FROM
				dbo.Pessoa	ACC	(nolock)
			WHERE
				ACC.cdPessoaSEQ = PES.cdAgenteComercialCCABPessoa
		)	as nmAgenteComercialCCABPessoa

	FROM
		Pessoa	PES	(nolock)
	WHERE 
		PES.cdPessoaSEQ = @cdPessoaSEQ
