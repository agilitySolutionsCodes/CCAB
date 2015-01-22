/******************************************************************************
**		File: SP_G_CooperativaSafraVencimento.SQL
**		Name: SP_G_CooperativaSafraVencimento
**		Desc: Listar Registros
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CooperativaSafraVencimento]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_G_CooperativaSafraVencimento]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_G_CooperativaSafraVencimento]
(
 	@cdCronogramaSafraVencimentoSEQ			bigint = null
	
)	
AS

	BEGIN 
		
		SELECT
			 A.cdCronogramaSafraVencimentoCoopSEQ		
 			,A.cdCronogramaSafraVencimentoSEQ			
			,A.cdCooperativaSEQ
			,A.pcCorrecaoPreco
			,A.pcDescontoPontualidade
			,A.wkCronogramaSafraVencimentoCooperativa
			,A.cdUsuarioUltimaAlteracao
			,PES.nmPessoa as nmCooperativa
			,VCT.dtCronogramaSafraVencimento 
			,(SELECT wkDominioCodigoReferenciado
	 		  FROM
	 			dbo.CodigoReferenciado
	 		  WHERE
	 				vrDominioCodigoReferenciado = VCT.cdTipoCronogramaSafraVencimento
	 		  AND	dsDominioCodigoReferenciado = 'DMESPINDICADORTIPOVENCIMENTO'
			 )	as dsTipoCronogramaSafraVencimento		
			,CRO.dsCronogramaSafra	
		FROM
			CronogramaSafraVencimentoCooperativa A WITH(NOLOCK)
			INNER JOIN Pessoa PES WITH(NOLOCK) ON (PES.cdPessoaSEQ = A.cdCooperativaSEQ)	
			INNER JOIN CronogramaSafraVencimento VCT with(nolock) on (VCT.cdCronogramaSafraVencimentoSEQ = A.cdCronogramaSafraVencimentoSEQ)
			INNER JOIN CronogramaSafra CRO with (nolock) on (VCT.cdCronogramaSafraSEQ = CRO.cdCronogramaSafraSEQ)
			
								
		WHERE
			(A.cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ OR @cdCronogramaSafraVencimentoSEQ IS NULL)
	
	END
	
GO
	
 







