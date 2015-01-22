set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: FN_RetornarMesExtenso.sql
**		Name: FN_RetornarMesExtenso
**		Desc: Retornar um Mês por Extenso
**
**		Auth: Roberto Chaparro
**		Date: Abr 8 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FN_RetornarMesExtenso]'))
BEGIN
	DROP FUNCTION [dbo].[FN_RetornarMesExtenso]
END
GO

CREATE FUNCTION [dbo].[FN_RetornarMesExtenso] 
(
	@Mes		int
)

returns		varchar(9)

AS
BEGIN

	declare
		@MesExtenso		varchar(9)


	if @Mes = 1
	begin
		select
			@MesExtenso = 'Janeiro'
	end

	if @Mes = 2
	begin
		select
			@MesExtenso = 'Fevereiro'
	end

	if @Mes = 3
	begin
		select
			@MesExtenso = 'Março'
	end

	if @Mes = 4
	begin
		select
			@MesExtenso = 'Abril'
	end

	if @Mes = 5
	begin
		select
			@MesExtenso = 'Maio'
	end

	if @Mes = 6
	begin
		select
			@MesExtenso = 'Junho'
	end

	if @Mes = 7
	begin
		select
			@MesExtenso = 'Julho'
	end

	if @Mes = 8
	begin
		select
			@MesExtenso = 'Agosto'
	end

	if @Mes = 9
	begin
		select
			@MesExtenso = 'Setembro'
	end

	if @Mes = 10
	begin
		select
			@MesExtenso = 'Outubro'
	end

	if @Mes = 11
	begin
		select
			@MesExtenso = 'Novembro'
	end

	if @Mes = 12
	begin
		select
			@MesExtenso = 'Dezembro'
	end






	RETURN @MesExtenso

END

	
