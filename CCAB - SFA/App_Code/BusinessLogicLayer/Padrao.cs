using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Web.Configuration;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;

/// <summary>
/// Summary description for Padrao
/// </summary>
public class Padrao
{
    #region Variáveis Globais

    TripleDESCryptoServiceProvider oTripleDESCryptoServiceProvider = new TripleDESCryptoServiceProvider();
    MD5CryptoServiceProvider oMD5CryptoServiceProvider = new MD5CryptoServiceProvider();

    string msStringConexao;

    #endregion Variáveis Globais

    #region Propriedades

    public string MensagemErroObtencao { get; set; }
    public string MensagemErroInclusao { get; set; }
    public string MensagemErroAlteracao { get; set; }
    public string MensagemErroExclusao { get; set; }

    public string MensagemObrigatorio{ get; set; }
    public string MensagemInvalido { get; set; }
    public string MensagemCaracterInvalido { get; set; }

    public string Erro { get; set; }

    #endregion Propriedades


    

	public Padrao()
	{

        MensagemErroObtencao = "Erro na tentativa de Obtenção dos Dados. Entre em contato com o Suporte.";
        MensagemErroInclusao = "Erro na tentativa de Inclusão dos Dados. Entre em contato com o Suporte.";
        MensagemErroAlteracao = "Erro na tentativa de Alteração dos Dados. Entre em contato com o Suporte.";
        MensagemErroExclusao = "Erro na tentativa de Exclusão dos Dados. Entre em contato com o Suporte.";

        MensagemObrigatorio = "(Campo obrigatório)";
        MensagemInvalido = "(Campo inválido)";
        MensagemCaracterInvalido = "(Possui caracter inválido)";

        msStringConexao = ObterStringConexao();
    }

    #region Métodos

    public bool ValidarDataInterno(object Entrada)
    {

        DateTime ltData;
        try
        {
            ltData = Convert.ToDateTime(Entrada);
            return true;
        }
        catch
        {
            return false;
        }

    }


    public bool ValidarValorInterno(object Entrada)
    {

        Double ldInteiro;
        try
        {
            ldInteiro = Convert.ToDouble(Entrada);
            return true;
        }
        catch
        {
            return false;
        }

    }

    public string ObterStringConexao()
    {
        string lsName = "CCAB_SEC";
        Configuration lcConfiguration = WebConfigurationManager.OpenWebConfiguration("~");
        return lcConfiguration.ConnectionStrings.ConnectionStrings[lsName].ToString();
    }

    public void GravarLogErro(string NomeClasse, string MensagemErro)
    {
        //string sSource;
        //string sLog;

        //sSource = string.Format("{0} ({1})", ConfigurationSettings.AppSettings["LOG_SOURCE"].ToString(), NomeClasse);
        //sLog = "Application";

        //if (!EventLog.SourceExists(sSource))
        //    EventLog.CreateEventSource(sSource, sLog);

        //EventLog.WriteEntry(sSource, MensagemErro,
        //    EventLogEntryType.Error);

        System.IO.StreamWriter arq = System.IO.File.AppendText(@"C:\Temp\LOG.txt");
        arq.WriteLine(string.Format("****************{0}****************\n{1}\n************", NomeClasse, MensagemErro));
        arq.Close();
    }

    public string FormatarNumero(string entrada, int quantidade_casas)
    {
       
        try
        {
            Erro = "";

            decimal entrada_decimal = 0;
            string retorno = "";

            string formatacao = "{0:NX}";
            formatacao = formatacao.Replace("X", quantidade_casas.ToString());

            if (entrada == "")
            {
                return "";
            }
            else
            {
                entrada_decimal = Convert.ToDecimal(entrada);
                retorno = String.Format(formatacao, entrada_decimal);


                return retorno;
            }
        }
        catch (Exception exception)
        {
            GravarLogErro(this.ToString(), exception.Message);
            Erro = exception.Message;
            return "";
        }

    }

    public string Codificar(string Entrada)
    {

        try
        {
            Erro = "";
            if (Entrada.Trim() != "")
            {
                string myKey = "778922";
                oTripleDESCryptoServiceProvider.Key = oMD5CryptoServiceProvider.ComputeHash(ASCIIEncoding.ASCII.GetBytes(myKey));
                oTripleDESCryptoServiceProvider.Mode = CipherMode.ECB;
                ICryptoTransform desdencrypt = oTripleDESCryptoServiceProvider.CreateEncryptor();
                ASCIIEncoding MyASCIIEncoding = new ASCIIEncoding();
                byte[] buff = Encoding.ASCII.GetBytes(Entrada);

                return Convert.ToBase64String(desdencrypt.TransformFinalBlock(buff, 0, buff.Length));
            }
            else
            {
                return "";
            }
        }
        catch (Exception loException)
        {
            GravarLogErro(this.ToString(), loException.Message);
            Erro = loException.Message;
            return "";
        }

    }

    public string Decodificar(string Entrada)
    {
        try
        {
            Erro = "";
            if (Entrada.Trim() != "")
            {
                string myKey = "778922";
                oTripleDESCryptoServiceProvider.Key = oMD5CryptoServiceProvider.ComputeHash(ASCIIEncoding.ASCII.GetBytes(myKey));
                oTripleDESCryptoServiceProvider.Mode = CipherMode.ECB;
                ICryptoTransform desdencrypt = oTripleDESCryptoServiceProvider.CreateDecryptor();
                byte[] buff = Convert.FromBase64String(Entrada);

                return ASCIIEncoding.ASCII.GetString(desdencrypt.TransformFinalBlock(buff, 0, buff.Length));
            }
            else
            {
                return "";
            }
        }
        catch (Exception loException)
        {
            GravarLogErro(this.ToString(), loException.Message);
            Erro = loException.Message;
            return "";
        }

    }

    public string VerificarDuplicidadeLogin(Int64 cdPessoaSEQ, string dsLoginPessoa)
    {
        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_Pessoa_Login_Duplicidade", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (dsLoginPessoa.Trim() != "")
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@dsLoginPessoa", SqlDbType.VarChar, 30);
                loSqlDataAdapter.SelectCommand.Parameters["@dsLoginPessoa"].Value = dsLoginPessoa;
            }


            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;


            if (cdPessoaSEQ == 0)
            {
                if (loDataTable.Rows.Count > 0)
                {
                    return "Login já existe.";
                }
            }
            else
            {
                if (loDataTable.Rows.Count > 0)
                {
                    if (Convert.ToInt32(loDataTable.Rows[0]["cdPessoaSEQ"]) != cdPessoaSEQ)
                    {
                        return "Login já existe.";
                    }
                }
            }



            return "";

        }
        catch (Exception loException)
        {
            GravarLogErro(this.ToString(), loException.Message);
            return MensagemErroObtencao;
        }
    }

    public string VerificarDuplicidadeCpfColaborador(Int64 cdPessoaSEQ, string nuCNPJCPFPessoa)
    {
        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_Pessoa_CpfColaborador_Duplicidade", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;


            loSqlDataAdapter.SelectCommand.Parameters.Add("@nuCNPJCPFPessoa", SqlDbType.VarChar, 30);
            loSqlDataAdapter.SelectCommand.Parameters["@nuCNPJCPFPessoa"].Value = nuCNPJCPFPessoa;


            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;


            if (cdPessoaSEQ == 0)
            {
                if (loDataTable.Rows.Count > 0)
                {
                    return "Cpf já existe.";
                }
            }
            else
            {
                if (loDataTable.Rows.Count > 0)
                {
                    if (Convert.ToInt32(loDataTable.Rows[0]["cdPessoaSEQ"]) != cdPessoaSEQ)
                    {
                        return "Cpf já existe.";
                    }
                }
            }



            return "";

        }
        catch (Exception loException)
        {
            GravarLogErro(this.ToString(), loException.Message);
            return MensagemErroObtencao;
        }
    }

    public bool VeriricarCaracterInvalido(string Entrada)
    {
        int liPosicao;

        liPosicao = Entrada.IndexOf("'");
        if (liPosicao >= 0)
        {
            return true;
        }


        return false;
    }

    public string ObterFonetico(string pNome)
    {
        //char[] cTran =
        //    {
        //        'A','A','A','A','A','A','A','C','E','E',
        //        'E','E','I','I','I','I','D','N','O','O',
        //        'O','O','O',' ',' ','U','U','U','U','Y'
        //    };

        //string[] strDe =
        //    {
        //        " DA "," DAS "," DO "," DOS "," DE ",
        //        "CA","CO","CU","CE","CI",
        //        "GE","GI","GU","QU","CT",
        //        "CK","SCH","CHR","SH","PH",
        //        "CH","CR","CL"
        //    };

        //string[] strPa =
        //    {
        //        " "," "," "," "," ",
        //        "KA","KO","KU","SE","SI",
        //        "JE","JI","G","K","T",
        //        "K","K","K","X","F",
        //        "X","K","K"
        //    };


        ////VER-SINTIA CYNTHIA ETC ---> LINHAS 21 E 29
        ////Troca caracteres para maiúsculos
        //StringBuilder fon = new StringBuilder((pNome.ToUpper()).Trim());
        ////Troca caracteres acentuados
        //for (int i = 0; i < fon.Length; i++)
        //{
        //    if (fon[i] >= 'A' && fon[i] <= 'Z') continue;
        //    if (fon[i] >= '0' && fon[i] <= '9') continue;
        //    if (fon[i] >= 'À' && fon[i] <= 'Ý') fon[i] = cTran[Convert.ToInt32(fon[i]) - 192];
        //    else fon[i] = ' ';
        //}
        //fon = new StringBuilder(fon.ToString().Trim());
        ////Saca preposições e troca "ch", "sh", etc
        //for (int i = 0; i < strDe.Length; i++) fon.Replace(strDe[i], strPa[i]);
        ////Ajusta vogais
        //for (int i = 0; i < fon.Length; i++)
        //{
        //    switch (fon[i])
        //    {
        //        case 'E': fon[i] = 'I'; break;
        //        case 'O': fon[i] = 'U'; break;
        //        case 'W': fon[i] = 'V'; break;
        //        case 'Z': fon[i] = 'S'; break;
        //        case 'Y': fon[i] = 'I'; break;
        //    }
        //}
        ////Saca caracteres repetidos (deixa só um)
        //int j = fon.Length - 1;
        //while (j > 0)
        //{
        //    char c = fon[j--];
        //    if (c >= '0' && c <= '9') continue;
        //    if (fon[j] == c) fon.Remove(j, 1);
        //    else if (c == 'H') fon.Remove(j + 1, 1);
        //}
        //if (fon.Length > 1 && fon[0] == 'H') fon.Remove(0, 1);
        ////Saca últimas consoantes das palavras
        ////... saca consoantes intermediárias (só deixa uma)
        //string[] sPalavras = fon.ToString().Split(new char[] { ' ' });
        //for (int i = 0; i < sPalavras.Length; i++)
        //{
        //    StringBuilder xpal = new StringBuilder(sPalavras[i]);
        //    int k;
        //    j = xpal.Length - 1;
        //    //Últimas consoantes
        //    for (k = j; k > 0; k--)
        //    {
        //        char c = xpal[k];
        //        if (c == 'A' || c == 'I' || c == 'U' || c == 'V' || (c >= '0' && c <= '9')) break;
        //    }
        //    if (k != j) xpal.Remove(k + 1, j - k);
        //    //Consoantes intermediárias
        //    k = xpal.Length - 2;
        //    while (k > 0)
        //    {
        //        int m;
        //        for (m = k; m > -1; m--)
        //        {
        //            char c = xpal[m];
        //            if (c == 'A' || c == 'I' || c == 'U' || c == 'V' || (c >= '0' && c <= '9')) break; // || c=='R' || c=='L') break;
        //        }
        //        int mk = k - m;
        //        if (mk > 1) xpal.Remove(m + 1, mk - 1);
        //        k = m - 1;
        //    }
        //    //Saca vogais intermediárias - só deixa uma
        //    k = xpal.Length - 1;
        //    while (k > 0)
        //    {
        //        int m;
        //        for (m = k; m > -1; m--)
        //        {
        //            char c = xpal[m];
        //            if (c != 'A' && c != 'I' && c != 'U') break; //&& c!='V') break;
        //        }
        //        int mk = k - m;
        //        if (mk > 1) xpal.Remove(m + 1, mk - 1);
        //        k = m - 1;
        //    }
        //    //Salva nova palavra
        //    sPalavras[i] = xpal.ToString();
        //}
        ////retorna
        //return (String.Join(" ", sPalavras));

        return pNome;
    }



    #endregion Métodos
}
