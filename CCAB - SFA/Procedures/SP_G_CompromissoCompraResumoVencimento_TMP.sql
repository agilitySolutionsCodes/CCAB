set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_CompromissoCompraResumoVencimento_TMP
**		Name: SP_G_CompromissoCompraResumoVencimento_TMP
**		Desc: Seleciona o resumo de vencimentos do Compromisso - tabela TMP
**
**		Auth: Roberto Chaparro
**		Date: Mar 11 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CompromissoCompraResumoVencimento_TMP]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_CompromissoCompraResumoVencimento_TMP]
END
GO

CREATE PROCEDURE [dbo].[SP_G_CompromissoCompraResumoVencimento_TMP]
	 @tmpCompromissoCompraSEQ		bigint
	 
AS

	BEGIN
	
		-- Declara a variavel de desconto de pontualidade
		DECLARE @pcDescontoPontualidade numeric(8,4)
		SET @pcDescontoPontualidade = 0
		
		
		CREATE TABLE #TabelaResumoVencimento
	(
		 [cdTipoCronogramaSafraVencimento]					int
		,[dtCronogramaSafraVencimento]						datetime
		,[VALUEVqtCompromissoCompraItem]					varchar(max)
		,[VALUEVqtAbertoCompromissoCompraItem]				varchar(max)
		,[VALUEVvrTotalMoedaCompromissoCompraItem]			varchar(max)
		,[VALUEVvrTotalMoedaAbertoCompromissoCompraItem]	varchar(max)
		,[cdParcela]										int IDENTITY(0,1) NOT NULL
		,[dsVencimento]										varchar(max)
		,[VALUEVpcDescontoPontualidade]                     varchar(max)
		,[cdVencimento]                                     bigint
	)	ON [PRIMARY]
	
	
		-- Insere a Linha do Cabeçalho
		INSERT INTO #TabelaResumoVencimento (	dsVencimento,
												VALUEVvrTotalMoedaCompromissoCompraItem,
												VALUEVvrTotalMoedaAbertoCompromissoCompraItem,
												VALUEVpcDescontoPontualidade
											)
		VALUES (	'Data de Vencimento',
					'Valor Total', 
					'',
					'% Desc. Pontualidade')
					
		-- Insere Detalhe					
		INSERT INTO #TabelaResumoVencimento (	cdTipoCronogramaSafraVencimento,
												dtCronogramaSafraVencimento,
												VALUEVqtCompromissoCompraItem,
												VALUEVqtAbertoCompromissoCompraItem,
												VALUEVvrTotalMoedaCompromissoCompraItem,
												VALUEVvrTotalMoedaAbertoCompromissoCompraItem,
												dsVencimento,
												cdVencimento,
												VALUEVpcDescontoPontualidade
											)
												
		select distinct	b.cdTipoCronogramaSafraVencimento,
						b.dtCronogramaSafraVencimento,
						dbo.FN_FormatarValor(sum(a.qtCompromissoCompraItem),1)					as totalqtCompromissoCompraItem,
						dbo.FN_FormatarValor(sum(a.qtAbertoCompromissoCompraItem),1)			as totalqtAbertoCompromissoCompraItem,
						dbo.FN_FormatarValor(sum(a.vrTotalMoedaCompromissoCompraItem),2)		as totalvrTotalMoedaCompromissoCompraItem,
						dbo.FN_FormatarValor(sum(a.vrTotalMoedaAbertoCompromissoCompraItem),2)	as totalvrTotalMoedaAbertoCompromissoCompraItem,
						case b.cdTipoCronogramaSafraVencimento 
							when 1 THEN 'A Vista' 
							when 2 THEN right(replace(convert(char(10), dtCronogramaSafraVencimento, 126),'-','/'),2) +
										substring(replace(convert(char(10), dtCronogramaSafraVencimento, 126),'-','/'), 5, 4) +
										left(replace(convert(char(10), dtCronogramaSafraVencimento, 126),'-','/'),4)  
							else        right(replace(convert(char(10), dtCronogramaSafraVencimento, 126),'-','/'),2) +
										substring(replace(convert(char(10), dtCronogramaSafraVencimento, 126),'-','/'), 5, 4) +
										left(replace(convert(char(10), dtCronogramaSafraVencimento, 126),'-','/'),4)  
						end											as dsVencimento,
						b.cdCronogramaSafraVencimentoSEQ as cdVencimento,
						dbo.FN_FormatarValor(dbo.FN_BuscaPontualidadeCompromisso(@tmpCompromissoCompraSEQ, b.cdCronogramaSafraVencimentoSEQ,1),2)	as pcDescontoPontualidade				
		from	tmpCompromissoCompraItem a,
				cronogramaSafraVencimento b
		Where	a.cdCronogramaSafraVencimentoSEQ = b.cdCronogramaSafraVencimentoSEQ
		and		a.tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ
		and     a.qtCompromissoCompraItem > 0
		group by a.cdCronogramaSafraVencimentoSEQ, b.cdTipoCronogramaSafraVencimento, b.dtCronogramaSafraVencimento, b.cdCronogramaSafraVencimentoSEQ

	
		select	cdParcela,
				dsVencimento,
				VALUEVvrTotalMoedaCompromissoCompraItem,
				VALUEVvrTotalMoedaAbertoCompromissoCompraItem,
				VALUEVpcDescontoPontualidade
		from	#TabelaResumoVencimento
		
		drop TABLE #TabelaResumoVencimento
						
	END
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO