set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_G_CronogramaSafra.sql
**		Name: SP_G_CronogramaSafra
**		Desc: Obtem registros da tabela CronogramaSafra
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CronogramaSafra]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_CronogramaSafra]
END
GO
 
CREATE PROCEDURE [dbo].[SP_G_CronogramaSafra]
	 @dsCronogramaSafra						varchar(30) = null
	,@cdIndicadorStatusCronogramaSafra		int			= null
	,@Ano									VARCHAR(4)	= NULL
	,@cdPessoaSEQ							BIGINT		= NULL
	,@cdIndicadorSituacaoCooperativa		INT			= NULL

AS

	IF (@Ano = '')
	BEGIN
		SELECT
			@Ano = NULL
	END



	DECLARE
		@lsComando		varchar(max)


	select
		 @lsComando = 'SELECT ' 

		,@lsComando = @lsComando + '		 cdCronogramaSafraSEQ'
		,@lsComando = @lsComando + '		,dsCronogramaSafra'
		,@lsComando = @lsComando + '		,dtInicioCronogramaSafra'
		,@lsComando = @lsComando + '		,dtFimCronogramaSafra'
		,@lsComando = @lsComando + '		,dtLimiteLiberacaoCCCronogramaSafra'
		,@lsComando = @lsComando + '		,dtLimiteAprovacaoCCCronogramaSafra'
		,@lsComando = @lsComando + '		,dtLimiteLiberacaoPVCronogramaSafra'
		,@lsComando = @lsComando + '		,dtLimiteAprovacaoPVRCCronogramaSafra'
		,@lsComando = @lsComando + '		,dtLimiteAprovacaoPVACCronogramaSafra'
		,@lsComando = @lsComando + '		,wkCronogramaSafra'
		,@lsComando = @lsComando + '		,dtUltimaAlteracao'
		,@lsComando = @lsComando + '		,cdUsuarioUltimaAlteracao'

		,@lsComando = @lsComando + '	  	,cdIndicadorSituacaoCronogramaSafra'
		,@lsComando = @lsComando + '	  	,('
		,@lsComando = @lsComando + '	  		SELECT'
		,@lsComando = @lsComando + '	  			wkDominioCodigoReferenciado'
		,@lsComando = @lsComando + '	  		FROM'
		,@lsComando = @lsComando + '	  			dbo.CodigoReferenciado			(nolock)'
		,@lsComando = @lsComando + '	  		WHERE'
		,@lsComando = @lsComando + '	  			vrDominioCodigoReferenciado		= cdIndicadorSituacaoCronogramaSafra'
		,@lsComando = @lsComando + '	  		AND	dsDominioCodigoReferenciado		= ''DMESPINDICADORATIVOINATIVO'' '
		,@lsComando = @lsComando + '	  	)	as dsIndicadorStatusCronogramaSafra'

		,@lsComando = @lsComando + '	FROM'
		,@lsComando = @lsComando + '		CronogramaSafra (nolock)'
		,@lsComando = @lsComando + '		WHERE '
		,@lsComando = @lsComando + '			cdCronogramaSafraSEQ > 0 ' 


		IF NOT @Ano is null
		BEGIN
		
			-- Ano da Safra
			select
				 @lsComando = @lsComando + 'AND	 YEAR(dtInicioCronogramaSafra) = '''
				,@lsComando = @lsComando + @Ano
				,@lsComando = @lsComando + '''' 
				
				
		END



		IF NOT @dsCronogramaSafra is null
		BEGIN
		
			-- Descrição Cronograma Safra
			select
				 @lsComando = @lsComando + 'AND	 upper(ltrim(rtrim(dsCronogramaSafra))) like ''' + '%'
				,@lsComando = @lsComando + upper(ltrim(rtrim(@dsCronogramaSafra)))
				,@lsComando = @lsComando + '%' + '''' 
				
				
		END

		IF NOT @cdIndicadorStatusCronogramaSafra is null
		BEGIN

			-- Status Safra		
			select
				 @lsComando = @lsComando + 'AND	 cdIndicadorSituacaoCronogramaSafra = ' + convert(varchar, @cdIndicadorStatusCronogramaSafra) + ' '
				 
			-- Data Final da Safra
			select
				@lsComando = @lsComando + 'AND dtFimCronogramaSafra >= getdate() '	
		END


		IF NOT @cdPessoaSEQ is null
		BEGIN
			select
				 @lsComando = @lsComando + 'AND	 cdCronogramaSafraSEQ IN (SELECT DISTINCT cdCronogramaSafraSEQ FROM CronogramaSafraCooperativa (nolock) WHERE cdPessoaSEQ = ' + convert(varchar, @cdPessoaSEQ)
				 
			IF NOT @cdIndicadorSituacaoCooperativa is null
			BEGIN
				select
					 @lsComando = @lsComando + ' AND cdIndicadorSituacaoCooperativa = ' + convert(varchar, @cdIndicadorSituacaoCooperativa)
			
			END	 

			select
				 @lsComando = @lsComando + ') '
							 
		END





		
		select
			 @lsComando = @lsComando + 'order by'
			,@lsComando = @lsComando + '	dsCronogramaSafra'


		exec(@lsComando)

