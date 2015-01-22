/******************************************************************************
**		File: SP_G_CooperativaPrincipioAtivo.sql
**		Name: SP_G_CooperativaPrincipioAtivo
**		Desc: Listar Registros
**
**		Auth: Ronaldo Mega (Convergence)
**		Date: 06/05/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		13.05.2010		Ronaldo Mega			Inclusão Tipo Produto
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CooperativaPrincipioAtivo]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_G_CooperativaPrincipioAtivo]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_G_CooperativaPrincipioAtivo]
(
	@cdCooperativaPrincipioAtivoSEQ	bigint			= NULL,	
	@cdCronogramaSafraSEQ			bigint			= NULL,	
	@cdCooperativaSEQ				bigint			= NULL,
	@cdFornecedorPrincipioAtivo		bigint			= NULL,
	@cdIndicadorPrincipioAtivo		int				= NULL,	
	@cdIndicadorProdutoAcabado		int				= NULL,	
	@wkCooperativaPrincipioAtivo	varchar(255)	= NULL,	
	@cdUsuarioUltimaAlteracao		bigint			= NULL,
	@cdTipoProduto					int				= NULL
)	
AS

	BEGIN 
		
		SELECT
			A.cdCooperativaPrincipioAtivoSEQ,
			A.cdCronogramaSafraSEQ,				
			A.cdCooperativaSEQ,
			A.cdFornecedorPrincipioAtivo,
			A.wkCooperativaPrincipioAtivo,
			A.dtUltimaAlteracao,	
			A.cdUsuarioUltimaAlteracao,
			A.cdTipoProduto,
			PES.nmPessoa + ' - ' + PES.cdPessoaERP  dsAgente,
			FO.nmPessoa + ' - ' + FO.cdPessoaERP  dsFornecedorPrincipioAtivo,
			
			(SELECT 
				wkDominioCodigoReferenciado 
			FROM  
				dbo.CodigoReferenciado 
			WHERE 
				vrDominioCodigoReferenciado	= A.cdTipoProduto 
				AND	dsDominioCodigoReferenciado	= 'DMESPTIPOPRODUTOPRECO'				
			)as dsTipoProduto			
			
			
		FROM
			CooperativaPrincipioAtivo		A	WITH(NOLOCK)
			INNER JOIN Pessoa				PES WITH(NOLOCK) ON (PES.cdPessoaSEQ = A.cdCooperativaSEQ)			
			INNER JOIN Pessoa				FO WITH(NOLOCK) ON (FO.cdPessoaSEQ = A.cdFornecedorPrincipioAtivo)
		WHERE
			(cdCooperativaPrincipioAtivoSEQ = @cdCooperativaPrincipioAtivoSEQ OR @cdCooperativaPrincipioAtivoSEQ IS NULL)
			AND (cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ OR @cdCronogramaSafraSEQ IS NULL)
			AND (cdCooperativaSEQ = @cdCooperativaSEQ OR @cdCooperativaSEQ IS NULL)
			AND (cdFornecedorPrincipioAtivo = @cdFornecedorPrincipioAtivo OR @cdFornecedorPrincipioAtivo IS NULL)
			AND (wkCooperativaPrincipioAtivo = @wkCooperativaPrincipioAtivo OR @wkCooperativaPrincipioAtivo IS NULL)			
			AND (A.cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao OR @cdUsuarioUltimaAlteracao IS NULL)		
	
	END
	
GO
	
 






