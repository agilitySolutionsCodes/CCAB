using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;


/// <summary>
/// Summary description for CronogramaSafraVencimento
/// </summary>
public class CronogramaSafraVencimento
{
    #region Variáveis Modulares

    HttpContext moHttpContext = HttpContext.Current;
    Usuario moUsuario = new Usuario();
    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares

	public CronogramaSafraVencimento()
	{
        moUsuario = (Usuario)moHttpContext.Session["Usuario"];
        msStringConexao = moPadrao.ObterStringConexao();
    }

    #region Métodos

    private string ConsistirParcelas(double pcParcela1CronogramaSafraVencimento, DateTime dtParcela1CronogramaSafraVencimento, double pcParcela2CronogramaSafraVencimento, DateTime dtParcela2CronogramaSafraVencimento, double pcParcela3CronogramaSafraVencimento, DateTime dtParcela3CronogramaSafraVencimento, double pcParcela4CronogramaSafraVencimento, DateTime dtParcela4CronogramaSafraVencimento, double pcParcela5CronogramaSafraVencimento, DateTime dtParcela5CronogramaSafraVencimento, double pcParcela6CronogramaSafraVencimento, DateTime dtParcela6CronogramaSafraVencimento, DateTime dtCronogramaSafraVencimento, int cdTipoCronogramaSafraVencimento)
    {
        Padrao padrao = new Padrao();
        try
        {
            ///////////////////////////////////////////////////////////////////////////////////////////////////
            //Consistências das Parcelas
            if (pcParcela1CronogramaSafraVencimento.ToString().Trim() != "")
            {
                if (padrao.ValidarValorInterno(pcParcela1CronogramaSafraVencimento) == false)
                {
                    return "% Parcela 1 precisa ser numérico.";
                }
                else
                {
                    if (pcParcela1CronogramaSafraVencimento == 0)
                    {
                        return "% Parcela 1 precisa ser informado ou precisa ser maior do que zero.";
                    }
                    else
                    {
                        if (dtParcela1CronogramaSafraVencimento == DateTime.MinValue)
                        {
                            return "Data Parcela 1 precisa ser informada ou está inválida.";
                        }
                        else
                        {
                            if (padrao.ValidarDataInterno(dtParcela1CronogramaSafraVencimento) == false)
                            {
                                return "Data Parcela 1 precisa ser está inválida.";
                            }

                            if (cdTipoCronogramaSafraVencimento == 2)
                            {
                                if (dtParcela1CronogramaSafraVencimento < dtCronogramaSafraVencimento)
                                {
                                    return "Data Parcela 1 precisa ser maior ou igual a data de Vencimento.";
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                return "% Parcela 1 precisa ser informado.";
            }
            /////////
            if (pcParcela2CronogramaSafraVencimento.ToString().Trim() != "")
            {
                if (padrao.ValidarValorInterno(pcParcela2CronogramaSafraVencimento) == false)
                {
                    return "% Parcela 2 precisa ser numérico.";
                }
                else
                {
                    if (pcParcela2CronogramaSafraVencimento != 0)
                    {
                        if (dtParcela2CronogramaSafraVencimento == DateTime.MinValue)
                        {
                            return "Data Parcela 2 precisa ser informada ou está inválida.";
                        }
                        else
                        {
                            if (padrao.ValidarDataInterno(dtParcela2CronogramaSafraVencimento) == false)
                            {
                                return "Data Parcela 2 precisa ser está inválida.";
                            }

                            if (dtParcela2CronogramaSafraVencimento <= dtParcela1CronogramaSafraVencimento)
                            {
                                return "Data Parcela 2 precisa ser maior do que Data Parcela 1.";
                            }
                        }
                    }
                }
            }
            /////////
            if (pcParcela3CronogramaSafraVencimento.ToString().Trim() != "")
            {

                if (padrao.ValidarValorInterno(pcParcela3CronogramaSafraVencimento) == false)
                {
                    return "% Parcela 3 precisa ser numérico.";
                }
                else
                {
                    if (pcParcela3CronogramaSafraVencimento != 0)
                    {
                        if (dtParcela3CronogramaSafraVencimento == DateTime.MinValue)
                        {
                            return "Data Parcela 3 precisa ser informada ou está inválida.";
                        }
                        else
                        {
                            if (padrao.ValidarDataInterno(dtParcela3CronogramaSafraVencimento) == false)
                            {
                                return "Data Parcela 3 precisa ser está inválida.";
                            }

                            if (dtParcela3CronogramaSafraVencimento <= dtParcela2CronogramaSafraVencimento)
                            {
                                return "Data Parcela 3 precisa ser maior do que Data Parcela 2.";
                            }

                            if (pcParcela2CronogramaSafraVencimento.ToString().Trim() == "" | pcParcela2CronogramaSafraVencimento == 0)
                            {
                                return "Não é permitido usar esta parcela sem o preenchimento das parcelas anteriores.";
                            }

                        }
                    }
                }
            }
            /////////
            if (pcParcela4CronogramaSafraVencimento.ToString().Trim() != "")
            {

                if (padrao.ValidarValorInterno(pcParcela4CronogramaSafraVencimento) == false)
                {
                    return "% Parcela 4 precisa ser numérico.";
                }
                else
                {
                    if (pcParcela4CronogramaSafraVencimento != 0)
                    {
                        if (dtParcela4CronogramaSafraVencimento == DateTime.MinValue)
                        {
                            return "Data Parcela 4 precisa ser informada ou está inválida.";
                        }
                        else
                        {
                            if (padrao.ValidarDataInterno(dtParcela4CronogramaSafraVencimento) == false)
                            {
                                return "Data Parcela 4 precisa ser está inválida.";
                            }

                            if (dtParcela4CronogramaSafraVencimento <= dtParcela3CronogramaSafraVencimento)
                            {
                                return "Data Parcela 4 precisa ser maior do que Data Parcela 3.";
                            }

                            if (pcParcela2CronogramaSafraVencimento.ToString().Trim() == "" | pcParcela2CronogramaSafraVencimento == 0 | pcParcela3CronogramaSafraVencimento.ToString().Trim() == "" | pcParcela3CronogramaSafraVencimento == 0)
                            {
                                return "Não é permitido usar esta parcela sem o preenchimento das parcelas anteriores.";
                            }

                        }
                    }
                }
            }
            /////////
            if (pcParcela5CronogramaSafraVencimento.ToString().Trim() != "")
            {

                if (padrao.ValidarValorInterno(pcParcela5CronogramaSafraVencimento) == false)
                {
                    return "% Parcela 5 precisa ser numérico.";
                }
                else
                {
                    if (pcParcela5CronogramaSafraVencimento != 0)
                    {
                        if (dtParcela5CronogramaSafraVencimento == DateTime.MinValue)
                        {
                            return "Data Parcela 5 precisa ser informada ou está inválida.";
                        }
                        else
                        {
                            if (padrao.ValidarDataInterno(dtParcela5CronogramaSafraVencimento) == false)
                            {
                                return "Data Parcela 5 precisa ser está inválida.";
                            }

                            if (dtParcela5CronogramaSafraVencimento <= dtParcela4CronogramaSafraVencimento)
                            {
                                return "Data Parcela 5 precisa ser maior do que Data Parcela 4.";
                            }

                            if (pcParcela2CronogramaSafraVencimento.ToString().Trim() == "" | pcParcela2CronogramaSafraVencimento == 0 | pcParcela3CronogramaSafraVencimento.ToString().Trim() == "" | pcParcela3CronogramaSafraVencimento == 0 | pcParcela4CronogramaSafraVencimento.ToString().Trim() == "" | pcParcela4CronogramaSafraVencimento == 0)
                            {
                                return "Não é permitido usar esta parcela sem o preenchimento das parcelas anteriores.";
                            }

                        }
                    }
                }
            }
            /////////
            if (pcParcela6CronogramaSafraVencimento.ToString().Trim() != "")
            {

                if (padrao.ValidarValorInterno(pcParcela6CronogramaSafraVencimento) == false)
                {
                    return "% Parcela 6 precisa ser numérico.";
                }
                else
                {
                    if (pcParcela6CronogramaSafraVencimento != 0)
                    {
                        if (dtParcela6CronogramaSafraVencimento == DateTime.MinValue)
                        {
                            return "Data Parcela 6 precisa ser informada ou está inválida.";
                        }
                        else
                        {
                            if (padrao.ValidarDataInterno(dtParcela6CronogramaSafraVencimento) == false)
                            {
                                return "Data Parcela 6 precisa ser está inválida.";
                            }

                            if (dtParcela6CronogramaSafraVencimento <= dtParcela5CronogramaSafraVencimento)
                            {
                                return "Data Parcela 6 precisa ser maior do que Data Parcela 5.";
                            }

                            if (pcParcela2CronogramaSafraVencimento.ToString().Trim() == "" | pcParcela2CronogramaSafraVencimento == 0 | pcParcela3CronogramaSafraVencimento.ToString().Trim() == "" | pcParcela3CronogramaSafraVencimento == 0 | pcParcela4CronogramaSafraVencimento.ToString().Trim() == "" | pcParcela4CronogramaSafraVencimento == 0 | pcParcela5CronogramaSafraVencimento.ToString().Trim() == "" | pcParcela5CronogramaSafraVencimento == 0)
                            {
                                return "Não é permitido usar esta parcela sem o preenchimento das parcelas anteriores.";
                            }

                        }
                    }
                }
            }




            //Somatoria das Parcelas
            double valortotal = pcParcela1CronogramaSafraVencimento + pcParcela2CronogramaSafraVencimento + pcParcela3CronogramaSafraVencimento + pcParcela4CronogramaSafraVencimento + pcParcela5CronogramaSafraVencimento + pcParcela6CronogramaSafraVencimento;
            if (valortotal != 100)
            {
                return "A Somatória dos Percentuais é " + valortotal.ToString() + " quando deveria ser 100,00.";
            }

            return "";
            ///////////////////////////////////////////////////////////////////////////////////////////////////

        }
        finally
        {
            padrao = null;
        }

    }


    public string Incluir(Int64 cdCronogramaSafraSEQ, int cdTipoCronogramaSafraVencimento, DateTime dtCronogramaSafraVencimento, double pcCorrecaoPrecoTipoCulturaVencimento, string wkCronogramaSafraVencimento, Int64 cdUsuarioUltimaAlteracao, double pcDescontoPontualidade, double pcParcela1CronogramaSafraVencimento, DateTime dtParcela1CronogramaSafraVencimento, double pcParcela2CronogramaSafraVencimento, DateTime dtParcela2CronogramaSafraVencimento, double pcParcela3CronogramaSafraVencimento, DateTime dtParcela3CronogramaSafraVencimento, double pcParcela4CronogramaSafraVencimento, DateTime dtParcela4CronogramaSafraVencimento, double pcParcela5CronogramaSafraVencimento, DateTime dtParcela5CronogramaSafraVencimento, double pcParcela6CronogramaSafraVencimento, DateTime dtParcela6CronogramaSafraVencimento)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            Int64 cdCronogramaSafraVencimentoSEQ = 0;

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            string retorno = "";

            retorno = ConsistirParcelas(pcParcela1CronogramaSafraVencimento, dtParcela1CronogramaSafraVencimento, pcParcela2CronogramaSafraVencimento, dtParcela2CronogramaSafraVencimento, pcParcela3CronogramaSafraVencimento, dtParcela3CronogramaSafraVencimento, pcParcela4CronogramaSafraVencimento, dtParcela4CronogramaSafraVencimento, pcParcela5CronogramaSafraVencimento, dtParcela5CronogramaSafraVencimento, pcParcela6CronogramaSafraVencimento, dtParcela6CronogramaSafraVencimento, dtCronogramaSafraVencimento, cdTipoCronogramaSafraVencimento);
            if (retorno != "")
            {
                return retorno;
            }


            //Consistências
            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }

            //Verifica se a data de vencimento já foi cadastrada
            if (VerificarDataVencimento(cdCronogramaSafraSEQ, cdTipoCronogramaSafraVencimento, dtCronogramaSafraVencimento, 0) == false)
            {
                return "Vencimento já cadastrado para a Safra Informada";
            }

            ////Verifico se há relacionamento
            //if (VerificarRelacionamentoInclusao(cdCronogramaSafraSEQ) == false)
            //{
            //    return "Inclusão não permitida pois já há Tabela de Preço cadastrada para esta Safra";
            //}

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCronogramaSafraVencimento");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;


            loSqlCommand.CommandText = "SP_I_CronogramaSafraVencimento";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            if (cdTipoCronogramaSafraVencimento != 0)
            {
                loSqlCommand.Parameters.Add("@cdTipoCronogramaSafraVencimento", SqlDbType.Int);
                loSqlCommand.Parameters["@cdTipoCronogramaSafraVencimento"].Value = cdTipoCronogramaSafraVencimento;
            }

            if (dtCronogramaSafraVencimento != DateTime.MinValue)
            {
                loSqlCommand.Parameters.Add("@dtCronogramaSafraVencimento", SqlDbType.DateTime);
                loSqlCommand.Parameters["@dtCronogramaSafraVencimento"].Value = dtCronogramaSafraVencimento;
            }


            loSqlCommand.Parameters.Add("@pcCorrecaoPrecoTipoCulturaVencimento", SqlDbType.Float);
            loSqlCommand.Parameters["@pcCorrecaoPrecoTipoCulturaVencimento"].Value = pcCorrecaoPrecoTipoCulturaVencimento;


            if (wkCronogramaSafraVencimento.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@wkCronogramaSafraVencimento", SqlDbType.VarChar, 255);
                loSqlCommand.Parameters["@wkCronogramaSafraVencimento"].Value = wkCronogramaSafraVencimento;
            }

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.Parameters.Add("@pcDescontoPontualidade", SqlDbType.Float);
            loSqlCommand.Parameters["@pcDescontoPontualidade"].Value = pcDescontoPontualidade;

            //Vencimentos
            loSqlCommand.Parameters.Add("@pcParcela1CronogramaSafraVencimento", SqlDbType.Float);
            loSqlCommand.Parameters["@pcParcela1CronogramaSafraVencimento"].Value = pcParcela1CronogramaSafraVencimento;

            loSqlCommand.Parameters.Add("@dtParcela1CronogramaSafraVencimento", SqlDbType.DateTime);
            loSqlCommand.Parameters["@dtParcela1CronogramaSafraVencimento"].Value = dtParcela1CronogramaSafraVencimento;


            loSqlCommand.Parameters.Add("@pcParcela2CronogramaSafraVencimento", SqlDbType.Float);
            loSqlCommand.Parameters["@pcParcela2CronogramaSafraVencimento"].Value = pcParcela2CronogramaSafraVencimento;

            if (pcParcela2CronogramaSafraVencimento > 0)
            {
                loSqlCommand.Parameters.Add("@dtParcela2CronogramaSafraVencimento", SqlDbType.DateTime);
                loSqlCommand.Parameters["@dtParcela2CronogramaSafraVencimento"].Value = dtParcela2CronogramaSafraVencimento;
            }

            loSqlCommand.Parameters.Add("@pcParcela3CronogramaSafraVencimento", SqlDbType.Float);
            loSqlCommand.Parameters["@pcParcela3CronogramaSafraVencimento"].Value = pcParcela3CronogramaSafraVencimento;

            if (pcParcela3CronogramaSafraVencimento > 0)
            {
                loSqlCommand.Parameters.Add("@dtParcela3CronogramaSafraVencimento", SqlDbType.DateTime);
                loSqlCommand.Parameters["@dtParcela3CronogramaSafraVencimento"].Value = dtParcela3CronogramaSafraVencimento;
            }

            loSqlCommand.Parameters.Add("@pcParcela4CronogramaSafraVencimento", SqlDbType.Float);
            loSqlCommand.Parameters["@pcParcela4CronogramaSafraVencimento"].Value = pcParcela4CronogramaSafraVencimento;

            if (pcParcela4CronogramaSafraVencimento > 0)
            {
                loSqlCommand.Parameters.Add("@dtParcela4CronogramaSafraVencimento", SqlDbType.DateTime);
                loSqlCommand.Parameters["@dtParcela4CronogramaSafraVencimento"].Value = dtParcela4CronogramaSafraVencimento;
            }

            loSqlCommand.Parameters.Add("@pcParcela5CronogramaSafraVencimento", SqlDbType.Float);
            loSqlCommand.Parameters["@pcParcela5CronogramaSafraVencimento"].Value = pcParcela5CronogramaSafraVencimento;

            if (pcParcela5CronogramaSafraVencimento > 0)
            {
                loSqlCommand.Parameters.Add("@dtParcela5CronogramaSafraVencimento", SqlDbType.DateTime);
                loSqlCommand.Parameters["@dtParcela5CronogramaSafraVencimento"].Value = dtParcela5CronogramaSafraVencimento;
            }

            loSqlCommand.Parameters.Add("@pcParcela6CronogramaSafraVencimento", SqlDbType.Float);
            loSqlCommand.Parameters["@pcParcela6CronogramaSafraVencimento"].Value = pcParcela6CronogramaSafraVencimento;

            if (pcParcela6CronogramaSafraVencimento > 0)
            {
                loSqlCommand.Parameters.Add("@dtParcela6CronogramaSafraVencimento", SqlDbType.DateTime);
                loSqlCommand.Parameters["@dtParcela6CronogramaSafraVencimento"].Value = dtParcela6CronogramaSafraVencimento;
            }



            loSqlCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Direction = ParameterDirection.Output;


            loSqlCommand.ExecuteNonQuery();

            cdCronogramaSafraVencimentoSEQ = Convert.ToInt64(loSqlCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value);

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TrCronogramaSafraVencimento");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }

    }

    public string Alterar(Int64 cdCronogramaSafraVencimentoSEQ, Int64 cdCronogramaSafraSEQ, int cdTipoCronogramaSafraVencimento, DateTime dtCronogramaSafraVencimento, double pcCorrecaoPrecoTipoCulturaVencimento, string wkCronogramaSafraVencimento, Int64 cdUsuarioUltimaAlteracao, double pcDescontoPontualidade, double pcParcela1CronogramaSafraVencimento, DateTime dtParcela1CronogramaSafraVencimento, double pcParcela2CronogramaSafraVencimento, DateTime dtParcela2CronogramaSafraVencimento, double pcParcela3CronogramaSafraVencimento, DateTime dtParcela3CronogramaSafraVencimento, double pcParcela4CronogramaSafraVencimento, DateTime dtParcela4CronogramaSafraVencimento, double pcParcela5CronogramaSafraVencimento, DateTime dtParcela5CronogramaSafraVencimento, double pcParcela6CronogramaSafraVencimento, DateTime dtParcela6CronogramaSafraVencimento)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            string retorno = "";

            retorno = ConsistirParcelas(pcParcela1CronogramaSafraVencimento, dtParcela1CronogramaSafraVencimento, pcParcela2CronogramaSafraVencimento, dtParcela2CronogramaSafraVencimento, pcParcela3CronogramaSafraVencimento, dtParcela3CronogramaSafraVencimento, pcParcela4CronogramaSafraVencimento, dtParcela4CronogramaSafraVencimento, pcParcela5CronogramaSafraVencimento, dtParcela5CronogramaSafraVencimento, pcParcela6CronogramaSafraVencimento, dtParcela6CronogramaSafraVencimento, dtCronogramaSafraVencimento, cdTipoCronogramaSafraVencimento);
            if (retorno != "")
            {
                return retorno;
            }


            //Consistências

            if (cdCronogramaSafraVencimentoSEQ == 0)
            {
                return "Código Principal" + moPadrao.MensagemObrigatorio;
            }

            if (cdCronogramaSafraSEQ == 0)
            {
                return "Código" + moPadrao.MensagemObrigatorio;
            }

            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }

            ////Verifico se há relacionamento
            //if (VerificarRelacionamento(cdCronogramaSafraVencimentoSEQ) == false)
            //{
            //    return "Alteração não permitida pois já há Tabela de Preço cadastrada para este registro";
            //}

            //Verifica se a data de vencimento já foi cadastrada
            if (VerificarDataVencimento(cdCronogramaSafraSEQ, cdTipoCronogramaSafraVencimento, dtCronogramaSafraVencimento, cdCronogramaSafraVencimentoSEQ) == false)
            {
                return "Vencimento já cadastrado para a Safra Informada";
            }

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCronogramaSafraVencimento");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_CronogramaSafraVencimento";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            if (cdTipoCronogramaSafraVencimento != 0)
            {
                loSqlCommand.Parameters.Add("@cdTipoCronogramaSafraVencimento", SqlDbType.Int);
                loSqlCommand.Parameters["@cdTipoCronogramaSafraVencimento"].Value = cdTipoCronogramaSafraVencimento;
            }

            if (dtCronogramaSafraVencimento != DateTime.MinValue)
            {
                loSqlCommand.Parameters.Add("@dtCronogramaSafraVencimento", SqlDbType.DateTime);
                loSqlCommand.Parameters["@dtCronogramaSafraVencimento"].Value = dtCronogramaSafraVencimento;
            }

            loSqlCommand.Parameters.Add("@pcCorrecaoPrecoTipoCulturaVencimento", SqlDbType.Float);
            loSqlCommand.Parameters["@pcCorrecaoPrecoTipoCulturaVencimento"].Value = pcCorrecaoPrecoTipoCulturaVencimento;

            if (wkCronogramaSafraVencimento.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@wkCronogramaSafraVencimento", SqlDbType.VarChar, 255);
                loSqlCommand.Parameters["@wkCronogramaSafraVencimento"].Value = wkCronogramaSafraVencimento;
            }

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;


            loSqlCommand.Parameters.Add("@pcDescontoPontualidade", SqlDbType.Float);
            loSqlCommand.Parameters["@pcDescontoPontualidade"].Value = pcDescontoPontualidade;

            //Vencimentos
            loSqlCommand.Parameters.Add("@pcParcela1CronogramaSafraVencimento", SqlDbType.Float);
            loSqlCommand.Parameters["@pcParcela1CronogramaSafraVencimento"].Value = pcParcela1CronogramaSafraVencimento;

            loSqlCommand.Parameters.Add("@dtParcela1CronogramaSafraVencimento", SqlDbType.DateTime);
            loSqlCommand.Parameters["@dtParcela1CronogramaSafraVencimento"].Value = dtParcela1CronogramaSafraVencimento;


            loSqlCommand.Parameters.Add("@pcParcela2CronogramaSafraVencimento", SqlDbType.Float);
            loSqlCommand.Parameters["@pcParcela2CronogramaSafraVencimento"].Value = pcParcela2CronogramaSafraVencimento;

            if (pcParcela2CronogramaSafraVencimento > 0)
            {
                loSqlCommand.Parameters.Add("@dtParcela2CronogramaSafraVencimento", SqlDbType.DateTime);
                loSqlCommand.Parameters["@dtParcela2CronogramaSafraVencimento"].Value = dtParcela2CronogramaSafraVencimento;
            }

            loSqlCommand.Parameters.Add("@pcParcela3CronogramaSafraVencimento", SqlDbType.Float);
            loSqlCommand.Parameters["@pcParcela3CronogramaSafraVencimento"].Value = pcParcela3CronogramaSafraVencimento;

            if (pcParcela3CronogramaSafraVencimento > 0)
            {
                loSqlCommand.Parameters.Add("@dtParcela3CronogramaSafraVencimento", SqlDbType.DateTime);
                loSqlCommand.Parameters["@dtParcela3CronogramaSafraVencimento"].Value = dtParcela3CronogramaSafraVencimento;
            }

            loSqlCommand.Parameters.Add("@pcParcela4CronogramaSafraVencimento", SqlDbType.Float);
            loSqlCommand.Parameters["@pcParcela4CronogramaSafraVencimento"].Value = pcParcela4CronogramaSafraVencimento;

            if (pcParcela4CronogramaSafraVencimento > 0)
            {
                loSqlCommand.Parameters.Add("@dtParcela4CronogramaSafraVencimento", SqlDbType.DateTime);
                loSqlCommand.Parameters["@dtParcela4CronogramaSafraVencimento"].Value = dtParcela4CronogramaSafraVencimento;
            }

            loSqlCommand.Parameters.Add("@pcParcela5CronogramaSafraVencimento", SqlDbType.Float);
            loSqlCommand.Parameters["@pcParcela5CronogramaSafraVencimento"].Value = pcParcela5CronogramaSafraVencimento;

            if (pcParcela5CronogramaSafraVencimento > 0)
            {
                loSqlCommand.Parameters.Add("@dtParcela5CronogramaSafraVencimento", SqlDbType.DateTime);
                loSqlCommand.Parameters["@dtParcela5CronogramaSafraVencimento"].Value = dtParcela5CronogramaSafraVencimento;
            }

            loSqlCommand.Parameters.Add("@pcParcela6CronogramaSafraVencimento", SqlDbType.Float);
            loSqlCommand.Parameters["@pcParcela6CronogramaSafraVencimento"].Value = pcParcela6CronogramaSafraVencimento;

            if (pcParcela6CronogramaSafraVencimento > 0)
            {
                loSqlCommand.Parameters.Add("@dtParcela6CronogramaSafraVencimento", SqlDbType.DateTime);
                loSqlCommand.Parameters["@dtParcela6CronogramaSafraVencimento"].Value = dtParcela6CronogramaSafraVencimento;
            }


            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TrCronogramaSafraVencimento");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public string Excluir(Int64 cdCronogramaSafraVencimentoSEQ)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            //Verifico se há relacionamento
            if (VerificarRelacionamento(cdCronogramaSafraVencimentoSEQ) == false)
            {
                return "Exclusão não permitida pois já há Tabela de Preço cadastrada para este registro";
            }


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCronogramaSafraVencimento");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_D_CronogramaSafraVencimento";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TrCronogramaSafraVencimento");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroExclusao;
        }
    }

    public DataTable ObterLista(Int64 cdCronogramaSafraSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CronogramaSafraVencimento", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;


            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable Obter(Int64 cdCronogramaSafraVencimentoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_CronogramaSafraVencimento", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaHistorico(Int64 cdCronogramaSafraVencimentoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CronogramaSafraVencimentoHistorico", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdCronogramaSafraVencimentoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;
            }


            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterHistorico(Int64 cdCronogramaSafraVencimentoHistoricoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_CronogramaSafraVencimentoHistorico", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdCronogramaSafraVencimentoHistoricoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraVencimentoHistoricoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraVencimentoHistoricoSEQ"].Value = cdCronogramaSafraVencimentoHistoricoSEQ;
            }


            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    private bool VerificarRelacionamento(Int64 cdCronogramaSafraVencimentoSEQ)
    {
        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_CronogramaSafraVencimento_X_PessoaTabelaPrecoProduto", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            if (loDataTable.Rows.Count == 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }

    }

    private bool VerificarRelacionamentoInclusao(Int64 cdCronogramaSafraSEQ)
    {
        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_VerificaTabelaPrecoVencimento", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            if (loDataTable.Rows.Count == 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }

    }

    private bool VerificarDataVencimento(Int64 cdCronogramaSafraSEQ, Int64 cdTipoCronogramaSafraVencimento, DateTime dtCronogramaSafraVencimento, Int64 cdCronogramaSafraVencimentoSEQ)
    {
        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_VerificaDataVencimento", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdTipoCronogramaSafraVencimento", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdTipoCronogramaSafraVencimento"].Value = cdTipoCronogramaSafraVencimento;

            if (dtCronogramaSafraVencimento != DateTime.MinValue)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@dtCronogramaSafraVencimento", SqlDbType.DateTime);
                loSqlDataAdapter.SelectCommand.Parameters["@dtCronogramaSafraVencimento"].Value = dtCronogramaSafraVencimento;
            }

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            if (loDataTable.Rows.Count == 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }

    }

    #endregion Métodos
}
