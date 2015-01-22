using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.IO;
using System.Data.SqlClient;
using System.Timers;

namespace SFA_Servico
{
    public partial class IntegracaoMicrosiga : ServiceBase
    {
        
        #region Variáveis Modulares

        Timer moTimer = new Timer();
        Padrao moPadrao = new Padrao();

        string msStringConexao;
        string msTempoRepeticao;
        string msNomePessoaEnvio;
        string msEmailPessoaEnvio;

        #endregion Variáveis Modulares



        public IntegracaoMicrosiga()
        {
            InitializeComponent();
            msStringConexao = moPadrao.ObterStringConexao();
            msTempoRepeticao = moPadrao.ObterTempoRepeticao();
            msNomePessoaEnvio = moPadrao.ObterNomePessoaEnvio();
            msEmailPessoaEnvio = moPadrao.ObterEmailPessoaEnvio();
        }

        protected override void OnStart(string[] args)
        {
            //StreamWriter arquivoWS;

            //arquivoWS = new StreamWriter("C:\\SFA_Servico\\Eventos.log", true);
            //arquivoWS.WriteLine("Iniciado em " + DateTime.Now.ToString());
            //arquivoWS.Flush();
            //arquivoWS.Close();

            //eventLog1.WriteEntry("Testando o Log de Eventos", EventLogEntryType.Error);

            moTimer.Elapsed += new ElapsedEventHandler(Timer_Elapsed);
            moTimer.Interval = Convert.ToInt32(msTempoRepeticao);
            moTimer.Enabled = true;
            moTimer.Start();

        }

        protected override void OnStop()
        {
            moTimer.Enabled = false;
        }

        private void Timer_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            try
            {
                string Retorno;

                // Chamando o método para salvar o arquivo.
                Retorno = IntegrarMicrosiga();
                if (Retorno != "")
                {
                    eventLog1.WriteEntry(Retorno, EventLogEntryType.Error);
                }
            }
            catch (IOException ex)
            {
                /* Gravando o erro no log de eventos do windows,
                 * será mostrado o ícone de erro (EventLogEntryType.Error).
                 * */
                eventLog1.WriteEntry(ex.ToString(), EventLogEntryType.Error);
            }

        }


        private string IntegrarMicrosiga()
        {
            string Retorno = "";

            Retorno = InserirPedidoMicrosiga();
            if (Retorno != "")
            {
                return Retorno;
            }

            return "";
        }


        public string InserirPedidoMicrosiga()
        {

            string Retorno;


            WSPedidoMicrosiga.CABEC_PV loCABEC_PV;
            WSPedidoMicrosiga.ITEM_PV loITEM_PV;
            List<WSPedidoMicrosiga.ITEM_PV> loITEM_PVArray;

            WSPedidoMicrosiga.PEDIDO_VENDA loPEDIDO_VENDA;

            WSPedidoMicrosiga.PEDIDO loPedido;


            Int64 cdPedidoVendaSEQ = 0;
            string CONDPAG = "";
            string EMISSAO = "";
            string MOEDA = "";
            string XCLIENT = "";
            string XCLIFAT = "";
            string XLOJAENT = "";
            string XLOJAFAT = "";
            string XTPPED = "";
            string XDESPER = "";
            
            Int64 cdPedidoVendaERPSEQ = 0;
            string DATA1 = "";
            string NUMSFA = "";
            string PARC1 = "";


            string ENTREG = "";
            string ITEMSFA = "";
            float PRCVEN = 0;
            string PRODUTO = "";
            float QTDVEN = 0;

            DataTable loDataTable;
            DataTable loDataTableERP;
            DataTable loDataTableERPItem;

            try
            {

                SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
                SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PedidoVenda_Microsiga", loSqlConnection);

                SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

                loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                //loSqlDataAdapter.SelectCommand.Parameters.Add("@qtRegistros", SqlDbType.Int);
                //loSqlDataAdapter.SelectCommand.Parameters["@qtRegistros"].Value = Convert.ToInt32(msQuantidadeRegistros);

                loDataTable = new DataTable();
                loSqlDataAdapter.Fill(loDataTable);

                loSqlConnection.Close();
                loSqlConnection = null;


                //Setar para 8, somente o cabeçalho
                Retorno = MarcarMicroSiga();
                if (Retorno != "")
                {
                    return Retorno;
                }


                foreach (DataRow loDataRow in loDataTable.Rows)
                {


                    cdPedidoVendaSEQ = Convert.ToInt64(loDataRow["cdPedidoVendaSEQ"]);
                    EMISSAO = loDataRow["EMISSAO"].ToString();
                    MOEDA = loDataRow["MOEDA"].ToString();
                    XCLIENT = loDataRow["XCLIENT"].ToString();
                    XCLIFAT = loDataRow["XCLIFAT"].ToString();
                    XLOJAENT = loDataRow["XLOJAENT"].ToString();
                    XLOJAFAT = loDataRow["XLOJAFAT"].ToString();
                    XTPPED = loDataRow["XTPPED"].ToString();
                    
                    SqlConnection loSqlConnectionERP = new SqlConnection(msStringConexao);
                    SqlDataAdapter loSqlDataAdapterERP = new SqlDataAdapter("SP_G_PedidoVendaERP_Microsiga", loSqlConnectionERP);

                    SqlCommand loSqlCommandERP = loSqlConnectionERP.CreateCommand();

                    loSqlDataAdapterERP.SelectCommand.CommandType = CommandType.StoredProcedure;

                    loSqlDataAdapterERP.SelectCommand.Parameters.Add("@cdPedidoVendaSEQ", SqlDbType.BigInt);
                    loSqlDataAdapterERP.SelectCommand.Parameters["@cdPedidoVendaSEQ"].Value = cdPedidoVendaSEQ;

                    loDataTableERP = new DataTable();
                    loSqlDataAdapterERP.Fill(loDataTableERP);

                    loSqlConnectionERP.Close();
                    loSqlConnectionERP = null;

                    foreach (DataRow loDataRowERP in loDataTableERP.Rows)
                    {
                        cdPedidoVendaERPSEQ = Convert.ToInt64(loDataRowERP["cdPedidoVendaERPSEQ"]);
                        DATA1 = loDataRowERP["DATA1"].ToString();
                        NUMSFA = loDataRowERP["NUMSFA"].ToString();
                        PARC1 = loDataRowERP["PARC1"].ToString().Replace(",", ".");
                        CONDPAG = loDataRowERP["CONDPAG"].ToString();

                        loCABEC_PV = new WSPedidoMicrosiga.CABEC_PV();

                        loCABEC_PV.CONDPAG = CONDPAG;
                        loCABEC_PV.DATA1 = DATA1;
                        loCABEC_PV.DATA2 = "";
                        loCABEC_PV.DATA3 = "";
                        loCABEC_PV.DATA4 = "";
                        loCABEC_PV.DATA5 = "";
                        loCABEC_PV.DATA6 = "";
                        loCABEC_PV.EMISSAO = EMISSAO;
                        loCABEC_PV.ESPECI1 = "VOLUMES";
                        loCABEC_PV.MOEDA = Convert.ToInt32(MOEDA);
                        loCABEC_PV.NUMSFA = NUMSFA;
                        loCABEC_PV.PARC1 = Convert.ToInt32(PARC1);
                        loCABEC_PV.PARC2 = 0;
                        loCABEC_PV.PARC3 = 0;
                        loCABEC_PV.PARC4 = 0;
                        loCABEC_PV.PARC5 = 0;
                        loCABEC_PV.PARC6 = 0;
                        loCABEC_PV.TABELA = "001";
                        loCABEC_PV.VEND1 = "";
                        loCABEC_PV.VEND2 = "";
                        loCABEC_PV.VEND3 = "";
                        loCABEC_PV.VEND4 = "";
                        loCABEC_PV.VEND5 = "";
                        loCABEC_PV.VOLUME1 = Convert.ToSingle(loDataRowERP["pcDescontoPontualidade"]);
                        loCABEC_PV.XCLIENT = XCLIENT;
                        loCABEC_PV.XCLIFAT = XCLIFAT;
                        loCABEC_PV.XHISTCO = "GERADO A PARTIR DO PORTAL";
                        loCABEC_PV.XLOJAENT = XLOJAENT;
                        loCABEC_PV.XLOJAFAT = XLOJAFAT;
                        loCABEC_PV.XOBSERV = "GERADO A PARTIR DO PORTAL";
                        loCABEC_PV.XTPPED = XTPPED;
                        loCABEC_PV.XDESPER = Convert.ToSingle(loDataRowERP["pcDescontoPontualidade"]);
                        
                        loITEM_PVArray = new List<WSPedidoMicrosiga.ITEM_PV>();
                        loPEDIDO_VENDA = new WSPedidoMicrosiga.PEDIDO_VENDA();
                        loPedido = new WSPedidoMicrosiga.PEDIDO();

                        SqlConnection loSqlConnectionERPItem = new SqlConnection(msStringConexao);
                        SqlDataAdapter loSqlDataAdapterERPItem = new SqlDataAdapter("SP_G_PedidoVendaERPItem_Microsiga", loSqlConnectionERPItem);

                        SqlCommand loSqlCommandERPItem = loSqlConnectionERPItem.CreateCommand();

                        loSqlDataAdapterERPItem.SelectCommand.CommandType = CommandType.StoredProcedure;

                        loSqlDataAdapterERPItem.SelectCommand.Parameters.Add("@cdPedidoVendaERPSEQ", SqlDbType.BigInt);
                        loSqlDataAdapterERPItem.SelectCommand.Parameters["@cdPedidoVendaERPSEQ"].Value = cdPedidoVendaERPSEQ;

                        loDataTableERPItem = new DataTable();
                        loSqlDataAdapterERPItem.Fill(loDataTableERPItem);

                        loSqlConnectionERPItem.Close();
                        loSqlConnectionERPItem = null;


                        foreach (DataRow loDataRowERPItem in loDataTableERPItem.Rows)
                        {

                            ENTREG = loDataRowERPItem["ENTREG"].ToString();
                            ITEMSFA = loDataRowERPItem["ITEMSFA"].ToString();
                            PRCVEN = Convert.ToSingle(loDataRowERPItem["PRCVEN"]);
                            PRODUTO = loDataRowERPItem["PRODUTO"].ToString();
                            QTDVEN = Convert.ToSingle(loDataRowERPItem["QTDVEN"]);



                            loITEM_PV = new WSPedidoMicrosiga.ITEM_PV();

                            loITEM_PV.ENTREG = ENTREG;
                            loITEM_PV.ITEMSFA = Convert.ToInt64(ITEMSFA);
                            loITEM_PV.NUMSFA = NUMSFA;
                            loITEM_PV.PRCVEN = PRCVEN;
                            loITEM_PV.PRODUTO = PRODUTO;
                            loITEM_PV.QTDVEN = QTDVEN;

                            loITEM_PVArray.Add(loITEM_PV);


                        }

                        loPEDIDO_VENDA.CABECPV = loCABEC_PV;
                        loPEDIDO_VENDA.AITEMPV = loITEM_PVArray.ToArray();

                        Retorno = AcessarWSMicrosiga(loPedido, loPEDIDO_VENDA, cdPedidoVendaERPSEQ, cdPedidoVendaSEQ);
                        if (Retorno != "")
                        {
                            return Retorno;
                        }




                    }


                }

                return "";
            }
            catch (Exception loException)
            {
                return loException.Message;
            }

        }


        private string MarcarMicroSiga()
        {
            //Marca como 8
            try
            {
                SqlConnection loSqlConnection = null;
                SqlCommand loSqlCommand = null;

                loSqlConnection = new SqlConnection(msStringConexao);
                loSqlConnection.Open();
                loSqlCommand = loSqlConnection.CreateCommand();

                loSqlCommand.Connection = loSqlConnection;

                loSqlCommand.CommandText = "SP_U_PedidoVenda_MicrosigaEnviado";
                loSqlCommand.CommandType = CommandType.StoredProcedure;


                //loSqlCommand.Parameters.Add("@cdPedidoVendaSEQ", SqlDbType.BigInt);
                //loSqlCommand.Parameters["@cdPedidoVendaSEQ"].Value = cdPedidoVendaSEQ;


                loSqlCommand.ExecuteNonQuery();

                loSqlConnection.Close();
                loSqlConnection = null;

                return "";
            }
            catch (Exception loException)
            {
                return loException.Message;
            }

        }


        private string AcessarWSMicrosiga(WSPedidoMicrosiga.PEDIDO loPedido, WSPedidoMicrosiga.PEDIDO_VENDA loPEDIDO_VENDA, Int64 cdPedidoVendaERPSEQ, Int64 cdPedidoVendaSEQ)
        {
            string Retorno = "";
            SqlTransaction loSqlTransaction = null;

            string Erro = "";

            try
            {
                SqlConnection loSqlConnection = null;
                SqlCommand loSqlCommand = null;

                loSqlConnection = new SqlConnection(msStringConexao);
                loSqlConnection.Open();
                loSqlCommand = loSqlConnection.CreateCommand();
                loSqlTransaction = loSqlConnection.BeginTransaction("PedidoMicrosiga");
                loSqlCommand.Connection = loSqlConnection;
                loSqlCommand.Transaction = loSqlTransaction;

                loSqlCommand.CommandText = "SP_U_PedidoVendaERP_Microsiga";
                loSqlCommand.CommandType = CommandType.StoredProcedure;

                try
                {

                    Retorno = loPedido.INCLUSAO(loPEDIDO_VENDA);

                    if (Retorno == null)
                    {
                        Retorno = "";

                        loSqlCommand.Parameters.Add("@cdIndicadorStatus", SqlDbType.Int);
                        loSqlCommand.Parameters["@cdIndicadorStatus"].Value = 7;

                        loSqlCommand.Parameters.Add("@nmPessoa", SqlDbType.VarChar, 70);
                        loSqlCommand.Parameters["@nmPessoa"].Value = msNomePessoaEnvio;

                        loSqlCommand.Parameters.Add("@enEmail", SqlDbType.VarChar, 70);
                        loSqlCommand.Parameters["@enEmail"].Value = msEmailPessoaEnvio;

                        loSqlCommand.Parameters.Add("@Erro", SqlDbType.VarChar);
                        loSqlCommand.Parameters["@Erro"].Value = "Código de Retorno Nulo";
                    }
                    else
                    {
                        loSqlCommand.Parameters.Add("@cdIndicadorStatus", SqlDbType.Int);
                        loSqlCommand.Parameters["@cdIndicadorStatus"].Value = 6;

                        loSqlCommand.Parameters.Add("@nmPessoa", SqlDbType.VarChar, 70);
                        loSqlCommand.Parameters["@nmPessoa"].Value = "";

                        loSqlCommand.Parameters.Add("@enEmail", SqlDbType.VarChar, 70);
                        loSqlCommand.Parameters["@enEmail"].Value = "";

                        loSqlCommand.Parameters.Add("@Erro", SqlDbType.VarChar);
                        loSqlCommand.Parameters["@Erro"].Value = "";
                    }

                }
                catch (Exception loException)
                {

                    Erro = loException.Message;

                    loSqlCommand.Parameters.Add("@cdIndicadorStatus", SqlDbType.Int);
                    loSqlCommand.Parameters["@cdIndicadorStatus"].Value = 7;

                    loSqlCommand.Parameters.Add("@nmPessoa", SqlDbType.VarChar, 70);
                    loSqlCommand.Parameters["@nmPessoa"].Value = msNomePessoaEnvio;

                    loSqlCommand.Parameters.Add("@enEmail", SqlDbType.VarChar, 70);
                    loSqlCommand.Parameters["@enEmail"].Value = msEmailPessoaEnvio;

                    loSqlCommand.Parameters.Add("@Erro", SqlDbType.VarChar);
                    loSqlCommand.Parameters["@Erro"].Value = Erro;

                }

                loSqlCommand.Parameters.Add("@cdPedidoVendaERPSEQ", SqlDbType.BigInt);
                loSqlCommand.Parameters["@cdPedidoVendaERPSEQ"].Value = cdPedidoVendaERPSEQ;

                loSqlCommand.Parameters.Add("@cdPedidoVendaERP", SqlDbType.VarChar, 30);
                loSqlCommand.Parameters["@cdPedidoVendaERP"].Value = Retorno;

                loSqlCommand.Parameters.Add("@cdPedidoVendaSEQ", SqlDbType.BigInt);
                loSqlCommand.Parameters["@cdPedidoVendaSEQ"].Value = cdPedidoVendaSEQ;


                loSqlCommand.ExecuteNonQuery();

                loSqlTransaction.Commit();

                loSqlConnection.Close();
                loSqlConnection = null;

                return "";
            }
            catch (Exception loException)
            {
                loSqlTransaction.Rollback("PedidoMicrosiga");

                //Gravo como erro
                SqlConnection loSqlConnection = null;
                SqlCommand loSqlCommand = null;

                loSqlConnection = new SqlConnection(msStringConexao);
                loSqlConnection.Open();
                loSqlCommand = loSqlConnection.CreateCommand();

                loSqlCommand.Connection = loSqlConnection;

                loSqlCommand.CommandText = "SP_U_PedidoVendaERP_Microsiga";
                loSqlCommand.CommandType = CommandType.StoredProcedure;


                loSqlCommand.Parameters.Add("@cdIndicadorStatus", SqlDbType.Int);
                loSqlCommand.Parameters["@cdIndicadorStatus"].Value = 7;

                loSqlCommand.Parameters.Add("@nmPessoa", SqlDbType.VarChar, 70);
                loSqlCommand.Parameters["@nmPessoa"].Value = msNomePessoaEnvio;

                loSqlCommand.Parameters.Add("@enEmail", SqlDbType.VarChar, 70);
                loSqlCommand.Parameters["@enEmail"].Value = msEmailPessoaEnvio;

                loSqlCommand.Parameters.Add("@Erro", SqlDbType.VarChar);
                loSqlCommand.Parameters["@Erro"].Value = loException.Message;

                loSqlCommand.Parameters.Add("@cdPedidoVendaERPSEQ", SqlDbType.BigInt);
                loSqlCommand.Parameters["@cdPedidoVendaERPSEQ"].Value = cdPedidoVendaERPSEQ;

                loSqlCommand.Parameters.Add("@cdPedidoVendaERP", SqlDbType.VarChar, 30);
                loSqlCommand.Parameters["@cdPedidoVendaERP"].Value = "";

                loSqlCommand.Parameters.Add("@cdPedidoVendaSEQ", SqlDbType.BigInt);
                loSqlCommand.Parameters["@cdPedidoVendaSEQ"].Value = cdPedidoVendaSEQ;

                loSqlCommand.ExecuteNonQuery();

                loSqlConnection.Close();
                loSqlConnection = null;


                return loException.Message;
            }

        }


    }
}
