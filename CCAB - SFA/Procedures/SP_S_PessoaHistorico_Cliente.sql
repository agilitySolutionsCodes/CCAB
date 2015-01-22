set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_PessoaHistorico_Cliente.sql
**		Name: SP_S_PessoaHistorico_Cliente
**		Desc: Obtem um de registro da tabela PessoaHistorico
**
**		Auth: Convergence
**		Date: 12/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_PessoaHistorico_Cliente]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_PessoaHistorico_Cliente]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_PessoaHistorico_Cliente]
	 @cdPessoaHistoricoSEQ	BIGINT
 
AS
 
	--seleção
	SELECT
		 HIS.cdPessoaHistoricoSEQ
		,HIS.cdPessoaSEQ
		,HIS.cdPessoaERP
		,HIS.cdIndicadorTipoPerfilPessoa
		,HIS.cdIndicadorStatusPessoa
		,HIS.cdIndicadorPessoa
		,HIS.cdIndicadorTipoAcessoPessoa
		,HIS.dsLoginPessoa
		,HIS.dsSenhaLoginPessoa
		,HIS.cdIndicadorPrimeiroAcessoPessoa
		,HIS.cdIndicadorSenhaBloqueadaPessoa
		,HIS.nmPessoa
		,HIS.nmReduzidoPessoa
		,HIS.nmFoneticoPessoa
		,HIS.nuCNPJCPFPessoa
		,HIS.nuInscricaoEstadualPessoa
		,HIS.nuInscricaoMunicipalPessoa
		,HIS.nuInscricaoRuralPessoa
		,HIS.nuRGCedulaEstrangeiroPessoa
		,HIS.cdNacionalidadePessoa
		,HIS.cdPaisEnderecoPrincipalPessoa
		,HIS.cdPaisEnderecoCobrancaPessoa
		,HIS.cdPaisTelefonePrincipalPessoa
		,HIS.cdPaisTelefoneFAXPessoa
		,HIS.cdPaisTelefoneCelularPessoa
		,HIS.dtNascimentoPessoa
		,HIS.cdIndicadorSexoPessoa
		,HIS.cdIndicadorEstadoCivilPessoa
		,HIS.enLogradouroEnderecoPrincipalPessoa
		,HIS.enBairroEnderecoPrincipalPessoa
		,HIS.enMunicipioEnderecoPrincipalPessoa
		,HIS.cdSiglaEstadoEnderecoPrincipalPessoa
		,HIS.nuCEPEnderecoPrincipalPessoa
		,HIS.nuCaixaPostalEnderecoPrincipalPessoa
		,HIS.enReferenciaEnderecoPrincipalPessoa
		,HIS.enLogradouroEnderecoCobrancaPessoa
		,HIS.enComplementoEnderecoCobrancaPessoa
		,HIS.enComplementoEnderecoPrincipalPessoa
		,HIS.enBairroEnderecoCobrancaPessoa
		,HIS.enMunicipioEnderecoCobrancaPessoa
		,HIS.cdSiglaEstadoEnderecoCobrancaPessoa
		,HIS.nuCEPEnderecoCobrancaPessoa
		,HIS.nuCaixaPostalEnderecoCobrancaPessoa
		,HIS.enReferenciaEnderecoCobrancaPessoa
		,HIS.enLogradouroEnderecoEntregaPessoa
		,HIS.cdPaisEnderecoEntregaPessoa
		,HIS.enComplementoEnderecoEntregaPessoa
		,HIS.enBairroEnderecoEntregaPessoa
		,HIS.enMunicipioEnderecoEntregaPessoa
		,HIS.cdSiglaEstadoEnderecoEntregaPessoa
		,HIS.nuCEPEnderecoEntregaPessoa
		,HIS.nuCaixaPostalEnderecoEntregaPessoa
		,HIS.enReferenciaEnderecoEntregaPessoa
		,HIS.nuDDDTelefonePrincipalPessoa
		,HIS.nuTelefonePrincipalPessoa
		,HIS.nuDDDTelefoneFAXPessoa
		,HIS.nuTelefoneFAXPessoa
		,HIS.nuDDDTelefoneCelularPessoa
		,HIS.nuTelefoneCelularPessoa
		,HIS.enEmailPrincipalPessoa
		,HIS.nmContatoPrincipalPessoa
		,HIS.nmContatoCobrancaPessoa
		,HIS.cdGrupoAcessoSEQ
		,HIS.cdAgenteComercialRCPessoa
		,HIS.cdAgenteComercialCooperativaPessoa
		,HIS.cdAgenteComercialCCABPessoa
		,HIS.cdEmpresaColaboradorPessoa
		,HIS.cdTipoEventoHistorico
		,HIS.dtOcorrenciaHistorico
		,HIS.cdUsuarioOcorrenciaHistorico
		,HIS.cdIndicadorTipoAgenteComercialPessoa

		,(
			CASE cdTipoEventoHistorico 
				WHEN 1 THEN 'Inclusão'
				ELSE 'Alteração'
			END	
		)	as dsTipoEventoHistorico 


		,(
			SELECT 
				USU.dsLoginPessoa
			FROM
				dbo.Pessoa	USU	(nolock)
			WHERE
				USU.cdPessoaSEQ = HIS.cdUsuarioOcorrenciaHistorico
		)	as nmUsuario


	FROM
		PessoaHistorico	HIS		(nolock)	

	WHERE 
		cdPessoaHistoricoSEQ = @cdPessoaHistoricoSEQ
