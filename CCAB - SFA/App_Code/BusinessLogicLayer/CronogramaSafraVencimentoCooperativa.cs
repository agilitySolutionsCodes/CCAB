using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;


/// <summary>
/// Summary description for CronogramaSafraVencimentoCooperativa
/// </summary>
public class CronogramaSafraVencimentoCooperativa
{
    #region Variáveis Modulares

    HttpContext moHttpContext = HttpContext.Current;
    Usuario moUsuario = new Usuario();
    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares

    public CronogramaSafraVencimentoCooperativa()
    {
        moUsuario = (Usuario)moHttpContext.Session["Usuario"];
        msStringConexao = moPadrao.ObterStringConexao();
    }

    #region Métodos

    private string ConsistirParcelas(double pcParcela1CronogramaSafraVencimento, DateTime dtParcela1CronogramaSafraVencimento, double pcParcela2CronogramaSafraVencimento, DateTime dtParcela2CronogramaSafraVencimento, double pcParcela3CronogramaSafraVencimento, DateTime dtParcela3CronogramaSafraVencimento, double pcParcela4CronogramaSafraVencimento, DateTime dtParcela4CronogramaSafraVencimento, double pcParcela5CronogramaSafraVencimento, DateTime dtParcela5CronogramaSafraVencimento, double pcParcela6CronogramaSafraVencimento, DateTime dtParcela6CronogramaSafraVencimento, Int64 cdCronogramaSafraVencimentoSEQ)
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

                            DateTime dtCronogramaSafraVencimento = DateTime.Now;
                            int cdTipoCronogramaSafraVencimento;
                            DataTable datatable = new DataTable();
                            CronogramaSafraVencimento cronogramasafravencimento = new CronogramaSafraVencimento();

                            datatable = cronogramasafravencimento.Obter(cdCronogramaSafraVencimentoSEQ);

                            cdTipoCronogramaSafraVencimento = Convert.ToInt32(datatable.Rows[0]["cdTipoCronogramaSafraVencimento"]);

                            if (datatable.Rows[0]["dtCronogramaSafraVencimento"].ToString().Trim() != "")
                            {
                                dtCronogramaSafraVencimento = Convert.ToDateTime(datatable.Rows[0]["dtCronogramaSafraVencimento"]);
                            }

                            datatable = null;
                            cronogramasafravencimento = null;


                            if (cdTipoCronogramaSafraVencimento == 2)
                            {
                                if (dtParcela1CronogramaSafraVencimento < dtCronogramaSafraVencimento)
                                {
                                    return "Data Parcela 1 precisa ser maior ou igual a data de Vencimento (" + dtCronogramaSafraVencimento.ToShortDateString() + ").";
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


    public string Incluir(Int64 cdCronogramaSafraVencimentoSEQ, Int64 cdCooperativaSEQ, double pcCorrecaoPreco, double pcDescontoPontualidade, string wkCronogramaSafraVencimentoCooperativa, Int64 cdUsuarioUltimaAlteracao, double pcParcela1CronogramaSafraVencimento, DateTime dtParcela1CronogramaSafraVencimento, double pcParcela2CronogramaSafraVencimento, DateTime dtParcela2CronogramaSafraVencimento, double pcParcela3CronogramaSafraVencimento, DateTime dtParcela3CronogramaSafraVencimento, double pcParcela4CronogramaSafraVencimento, DateTime dtParcela4CronogramaSafraVencimento, double pcParcela5CronogramaSafraVencimento, DateTime dtParcela5CronogramaSafraVencimento, double pcParcela6CronogramaSafraVencimento, DateTime dtParcela6CronogramaSafraVencimento, int cdTipoCronogramaSafraVencimento, DateTime dtCronogramaSafraVencimento)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            Int64 cdCronogramaSafraVencimentoCoopSEQ = 0;

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            string retorno = "";

            retorno = ConsistirParcelas(pcParcela1CronogramaSafraVencimento, dtParcela1CronogramaSafraVencimento, pcParcela2CronogramaSafraVencimento, dtParcela2CronogramaSafraVencimento, pcParcela3CronogramaSafraVencimento, dtParcela3CronogramaSafraVencimento, pcParcela4CronogramaSafraVencimento, dtParcela4CronogramaSafraVencimento, pcParcela5CronogramaSafraVencimento, dtParcela5CronogramaSafraVencimento, pcParcela6CronogramaSafraVencimento, dtParcela6CronogramaSafraVencimento, cdCronogramaSafraVencimentoSEQ);
            if (retorno != "")
            {
                return retorno;
            }


            //Consistências
            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }

            if (cdCronogramaSafraVencimentoSEQ == 0)
            {
                return "Vencimento" + moPadrao.MensagemObrigatorio;
            }

            if (cdCooperativaSEQ == 0)
            {
                return "Cooperativa" + moPadrao.MensagemObrigatorio;
            }

            //Verifica se a Cooperativa já foi cadastrada no Safra/Vencimento
            if (VerificarDataVencimentoCooperativa(cdCronogramaSafraVencimentoSEQ, cdCooperativaSEQ) == false)
            {
                return "Cooperativa já cadastrada na Safra/Vencimento";
            }

            //Verifico se há relacionamento
            if (VerificarRelacionamento(cdCronogramaSafraVencimentoSEQ, cdCooperativaSEQ) == false)
            {
                return "Inclusão não permitida pois já há Tabela de Preço cadastrada para este registro";
            }

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCooperativaSafraVencimento");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_I_CooperativaSafraVencimento";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.Int);
            loSqlCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

            loSqlCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.Int);
            loSqlCommand.Parameters["@cdCooperativaSEQ"].Value = cdCooperativaSEQ;

            loSqlCommand.Parameters.Add("@pcCorrecaoPreco", SqlDbType.Float);
            loSqlCommand.Parameters["@pcCorrecaoPreco"].Value = pcCorrecaoPreco;

            loSqlCommand.Parameters.Add("@pcDescontoPontualidade", SqlDbType.Float);
            loSqlCommand.Parameters["@pcDescontoPontualidade"].Value = pcDescontoPontualidade;

            if (wkCronogramaSafraVencimentoCooperativa.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@wkCronogramaSafraVencimentoCooperativa", SqlDbType.VarChar, 255);
                loSqlCommand.Parameters["@wkCronogramaSafraVencimentoCooperativa"].Value = wkCronogramaSafraVencimentoCooperativa;
            }

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

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


            loSqlCommand.Parameters.Add("@cdCronogramaSafraVencimentoCoopSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraVencimentoCoopSEQ"].Direction = ParameterDirection.Output;

            loSqlCommand.ExecuteNonQuery();

            cdCronogramaSafraVencimentoCoopSEQ = Convert.ToInt64(loSqlCommand.Parameters["@cdCronogramaSafraVencimentoCoopSEQ"].Value);

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TrCooperativaSafraVencimento");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public string Alterar(Int64 cdCronogramaSafraVencimentoCoopSEQ, Int64 cdCronogramaSafraVencimentoSEQ, Int64 cdCooperativaSEQ, double pcCorrecaoPreco, double pcDescontoPontualidade, string wkCronogramaSafraVencimentoCooperativa, Int64 cdUsuarioUltimaAlteracao, double pcParcela1CronogramaSafraVencimento, DateTime dtParcela1CronogramaSafraVencimento, double pcParcela2CronogramaSafraVencimento, DateTime dtParcela2CronogramaSafraVencimento, double pcParcela3CronogramaSafraVencimento, DateTime dtParcela3CronogramaSafraVencimento, double pcParcela4CronogramaSafraVencimento, DateTime dtParcela4CronogramaSafraVencimento, double pcParcela5CronogramaSafraVencimento, DateTime dtParcela5CronogramaSafraVencimento, double pcParcela6CronogramaSafraVencimento, DateTime dtParcela6CronogramaSafraVencimento, int cdTipoCronogramaSafraVencimento, DateTime dtCronogramaSafraVencimento)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            string retorno = "";

            retorno = ConsistirParcelas(pcParcela1CronogramaSafraVencimento, dtParcela1CronogramaSafraVencimento, pcParcela2CronogramaSafraVencimento, dtParcela2CronogramaSafraVencimento, pcParcela3CronogramaSafraVencimento, dtParcela3CronogramaSafraVencimento, pcParcela4CronogramaSafraVencimento, dtParcela4CronogramaSafraVencimento, pcParcela5CronogramaSafraVencimento, dtParcela5CronogramaSafraVencimento, pcParcela6CronogramaSafraVencimento, dtParcela6CronogramaSafraVencimento, cdCronogramaSafraVencimentoSEQ);
            if (retorno != "")
            {
                return retorno;
            }


            //Consistências
            if (cdCronogramaSafraVencimentoCoopSEQ == 0)
            {
                return "Código Principal" + moPadrao.MensagemObrigatorio;
            }

            if (cdCronogramaSafraVencimentoSEQ == 0)
            {
                return "Vencimento" + moPadrao.MensagemObrigatorio;
            }

            if (cdCooperativaSEQ == 0)
            {
                return "Cooperativa" + moPadrao.MensagemObrigatorio;
            }

            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }

            ////Verifico se há relacionamento
            //if (VerificarRelacionamento(cdCronogramaSafraVencimentoSEQ, cdCooperativaSEQ) == false)
            //{
            //    return "Alteração não permitida pois já há Tabela de Preço cadastrada para este registro";
            //}

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCooperativaSafraVencimento");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_CooperativaSafraVencimento";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraVencimentoCoopSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraVencimentoCoopSEQ"].Value = cdCronogramaSafraVencimentoCoopSEQ;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

            loSqlCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaSEQ"].Value = cdCooperativaSEQ;

            loSqlCommand.Parameters.Add("@pcCorrecaoPreco", SqlDbType.Float);
            loSqlCommand.Parameters["@pcCorrecaoPreco"].Value = pcCorrecaoPreco;

            loSqlCommand.Parameters.Add("@pcDescontoPontualidade", SqlDbType.Float);
            loSqlCommand.Parameters["@pcDescontoPontualidade"].Value = pcDescontoPontualidade;


            if (wkCronogramaSafraVencimentoCooperativa.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@wkCronogramaSafraVencimentoCooperativa", SqlDbType.VarChar, 255);
                loSqlCommand.Parameters["@wkCronogramaSafraVencimentoCooperativa"].Value = wkCronogramaSafraVencimentoCooperativa;
            }

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

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
            loSqlTransaction.Rollback("TrCooperativaSafraVencimento");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public string Excluir(Int64 cdCronogramaSafraVencimentoCoopSEQ)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            ////Verifico se há relacionamento
            //if (VerificarRelacionamento(cdCronogramaSafraVencimentoSEQ, cdCooperativaSEQ) == false)
            //{
            //    return "Exclusão não permitida pois já há Tabela de Preço cadastrada para este registro";
            //}

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCooperativaSafraVencimento");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_D_CooperativaSafraVencimento";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraVencimentoCoopSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraVencimentoCoopSEQ"].Value = cdCronogramaSafraVencimentoCoopSEQ;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TrCooperativaSafraVencimento");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroExclusao;
        }
    }

    public DataTable ObterLista(Int64 cdCronogramaSafraVencimentoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaSafraVencimento", loSqlConnection);

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

    public DataTable Obter(Int64 cdCronogramaSafraVencimentoCoopSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_CooperativaSafraVencimento", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraVencimentoCoopSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraVencimentoCoopSEQ"].Value = cdCronogramaSafraVencimentoCoopSEQ;

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

    private bool VerificarRelacionamento(Int64 cdCronogramaSafraVencimentoSEQ, Int64 cdCooperativaSEQ)
    {
        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_CooperativaSafraVencimento_X_PessoaTabelaPrecoProduto", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCooperativaSEQ"].Value = cdCooperativaSEQ;

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

    private bool VerificarDataVencimentoCooperativa(Int64 cdCronogramaSafraVencimentoSEQ, Int64 cdCooperativaSEQ)
    {
        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_VerificaDataVencimentoCooperativa", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCooperativaSEQ"].Value = cdCooperativaSEQ;

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

