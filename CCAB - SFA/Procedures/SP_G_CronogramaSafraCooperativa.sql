/******************************************************************************
**		File: SP_G_CronogramaSafraCooperativa.SQL
**		Name: SP_G_CronogramaSafraCooperativa
**		Desc: Listar Registros
**
**		Auth: Roberto (Convergence)
**		Date: 06/05/2000
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CronogramaSafraCooperativa]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_G_CronogramaSafraCooperativa]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_G_CronogramaSafraCooperativa]
(
	@cdCronogramaSafraCooperativaSEQ		bigint			= NULL,	
	@cdCronogramaSafraSEQ			bigint			= NULL,	
	@cdPessoaSEQ				bigint			= NULL,
	@cdIndicadorSituacaoCooperativa			int				= NULL,	
	@wkCronogramaSafraCooperativa		varchar(255)	= NULL,	
	@cdUsuarioUltimaAlteracao		bigint			= NULL
)	
AS

	BEGIN 
		
		SELECT
			A.cdCronogramaSafraCooperativaSEQ,
			A.cdCronogramaSafraSEQ,				
			A.cdPessoaSEQ,
			A.wkCronogramaSafraCooperativa,
			A.dtUltimaAlteracao,	
			A.cdUsuarioUltimaAlteracao,
			A.cdIndicadorSituacaoCooperativa,
			PES.nmPessoa + ' - ' + PES.cdPessoaERP  dsAgente,			
			
			(SELECT 
				wkDominioCodigoReferenciado 
			FROM  
				dbo.CodigoReferenciado 
			WHERE 
				vrDominioCodigoReferenciado	= A.cdIndicadorSituacaoCooperativa 
				AND	dsDominioCodigoReferenciado	= 'DMESPINDICADORATIVOINATIVO'				
			)as dsIndicadorSituacaoCooperativa		
			
			
		FROM
			CronogramaSafraCooperativa		A	WITH(NOLOCK)
			INNER JOIN Pessoa			PES WITH(NOLOCK) ON (PES.cdPessoaSEQ = A.cdPessoaSEQ)						
		WHERE
			(cdCronogramaSafraCooperativaSEQ = @cdCronogramaSafraCooperativaSEQ OR @cdCronogramaSafraCooperativaSEQ IS NULL)
			AND (cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ OR @cdCronogramaSafraSEQ IS NULL)
			AND (A.cdPessoaSEQ = @cdPessoaSEQ OR @cdPessoaSEQ IS NULL)
			AND (wkCronogramaSafraCooperativa = @wkCronogramaSafraCooperativa OR @wkCronogramaSafraCooperativa IS NULL)			
			AND (A.cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao OR @cdUsuarioUltimaAlteracao IS NULL)		
	
	END
	
GO
	
 






