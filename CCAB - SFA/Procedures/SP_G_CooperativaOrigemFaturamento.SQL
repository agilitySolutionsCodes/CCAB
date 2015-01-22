/******************************************************************************
**		File: SP_G_CooperativaOrigemFaturamento.SQL
**		Name: SP_G_CooperativaOrigemFaturamento
**		Desc: Listar Registros
**
**		Auth: Ronaldo Mega (Convergence)
**		Date: 24/05/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CooperativaOrigemFaturamento]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_G_CooperativaOrigemFaturamento]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_G_CooperativaOrigemFaturamento]
(
	@cdCooperativaOrigemFaturamentoSEQ		bigint			= NULL,	
	@cdCronogramaSafraSEQ					bigint			= NULL,	
	@cdCooperativaSEQ						bigint			= NULL,
	@cdIndicadorSituacaoOrigemFaturamento	int				= NULL,	
	@wkCooperativaOrigemFaturamento			varchar(255)	= NULL,	
	@cdUsuarioUltimaAlteracao				bigint			= NULL,
	@cdOrigemFaturamentoSEQ					bigint			= NULL
)	
AS

	BEGIN 
		
		SELECT
			A.cdCooperativaOrigemFaturamentoSEQ,
			A.cdCronogramaSafraSEQ,				
			A.cdCooperativaSEQ,
			A.wkCooperativaOrigemFaturamento,
			A.cdOrigemFaturamentoSEQ,
			A.dtUltimaAlteracao,	
			A.cdUsuarioUltimaAlteracao,
			A.cdIndicadorSituacaoOrigemFaturamento,
			PES.nmPessoa + ' - ' + PES.cdPessoaERP  dsAgente,			
			PES2.nmPessoa + ' - ' + PES2.cdPessoaERP  dsFaturamento,		
			
			(SELECT 
				wkDominioCodigoReferenciado 
			FROM  
				dbo.CodigoReferenciado 
			WHERE 
				vrDominioCodigoReferenciado	= A.cdIndicadorSituacaoOrigemFaturamento 
				AND	dsDominioCodigoReferenciado	= 'DMESPINDICADORATIVOINATIVO'				
			)as dsIndicadorOrigemFaturamento		
			
			
		FROM
			CooperativaOrigemFaturamento		A	WITH(NOLOCK)
			INNER JOIN Pessoa			PES WITH(NOLOCK) ON (PES.cdPessoaSEQ = A.cdCooperativaSEQ)						
			INNER JOIN Pessoa			PES2 WITH(NOLOCK) ON (PES2.cdPessoaSEQ = A.cdOrigemFaturamentoSEQ)						
		WHERE
			(cdCooperativaOrigemFaturamentoSEQ = @cdCooperativaOrigemFaturamentoSEQ OR @cdCooperativaOrigemFaturamentoSEQ IS NULL)
			AND (cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ OR @cdCronogramaSafraSEQ IS NULL)
			AND (cdCooperativaSEQ = @cdCooperativaSEQ OR @cdCooperativaSEQ IS NULL)
			AND (wkCooperativaOrigemFaturamento = @wkCooperativaOrigemFaturamento OR @wkCooperativaOrigemFaturamento IS NULL)			
			AND (A.cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao OR @cdUsuarioUltimaAlteracao IS NULL)	
			
			
		ORDER BY
			dsAgente
							
	
	END
	
GO
	
 






