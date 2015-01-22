--delete TipoCultura
--delete TipoCulturaHistorico
select * from TipoCultura
select * from TipoCulturaHistorico

declare @cdTipoCulturaSEQ			bigint
exec SP_I_TipoCultura
	 @cdTipoCulturaERP				= 4
	,@dsTipoCultura					= '1'
	,@wkTipoCultura					= '1'
	,@cdUsuarioUltimaAlteracao		= 216
	,@cdTipoCulturaSEQ				= @cdTipoCulturaSEQ

exec SP_U_TipoCultura
	 @cdTipoCulturaSEQ				= 9
	,@cdTipoCulturaERP				= 5
	,@dsTipoCultura					= '1x'
	,@wkTipoCultura					= '1'
	,@cdUsuarioUltimaAlteracao		= 216

exec SP_S_TipoCultura
	@cdTipoCulturaSEQ				= 5

exec SP_G_TipoCultura

exec SP_S_TipoCulturaHistorico
	@cdTipoCulturaHistoricoSEQ	    = 22

exec SP_G_TipoCulturaHistorico
	@cdTipoCulturaSEQ				= 9

exec SP_S_TipoCultura_AK
	@cdTipoCulturaERP = '5'
	