<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Formulario.ascx.cs" Inherits="_SFA_Cadastros_MinhaCentral_Usuario_Formulario" %>

<script type="text/javascript" src="../../../../scripts/JScript.js"></script>
 
<!-- Área de Mensagens -->
<div>
    <asp:ValidationSummary EnableClientScript="true" ID="ValidationSummary1" ShowSummary="false"
        ShowMessageBox="true" ValidationGroup="Form" HeaderText="O formulário contém erros:"
        runat="server" />
    <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Form" />
</div>

<!-- Formulário -->
<%if(!_successMsg){ %>
<div>

    <div id="panAlerta" runat="server" class="fonteTbCadastro" visible="false">
        <p style="text-align: center; font-size: medium; color: #FF0000;">Alerta: Favor preencher todos os campos marcados com asteriscos para utilizar o Sistema corretamente.</p>
    </div>

    <asp:FormView ID="FormView1" runat="server" DataSourceID="ObjectDataSource12" DataKeyNames="cdPessoaSEQ" CellPadding="5"
        AutoGenerateRows="false" Width="100%" GridLines="None">
        
        <EditItemTemplate>
            
            <div class="pageSection">
            
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td colspan="6">
                            <h5 style="text-align: left; color: Green; margin-bottom: 0">Dados Gerais</h5>
                            <hr style="color: Green; height: 1px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Tipo Pessoa:*
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="false" ID="cdIndicadorPessoa" runat="server" ValidationGroup="Form"
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource8" 
                                DataValueField="vrDominioCodigoReferenciado" DataTextField="wkDominioCodigoReferenciado"  />
                        </td>
                        <td>
                        </td>
                        <td class="fonteTbCadastro">
                            Código:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="cdPessoaERP" runat="server" 
                                Columns="14" CssClass="campoTexto" Text='<%# Bind("cdPessoaERP") %>' />
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            CNPJ/CPF:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled='false' ID="nuCNPJCPFPessoa" runat="server" 
                                Columns="14" CssClass="campoTexto" Text='<%# Bind("nuCNPJCPFPessoa") %>' />
                        </td>
                        <td></td>
                        <td class="fonteTbCadastro">
                            Razão Social:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="nmPessoa" runat="server" 
                                Width="300" CssClass="campoTexto" Text='<%# Bind("nmPessoa") %>' />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator3" runat="server" ErrorMessage="Nome é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="nmPessoa" />
                        </td>
                    </tr>
                    <tr>
                        <td class="fonteTbCadastro">
                            Nome Fantasia:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="nmReduzidoPessoa" runat="server" 
                                Columns="40" CssClass="campoTexto" Text='<%# Bind("nmReduzidoPessoa") %>' />
                        </td>
                        <td>
                        </td>
                        <td class="fonteTbCadastro">
                            E-mail:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="enEmailPrincipalPessoa" runat="server" 
                                Columns="40" CssClass="campoTexto" Text='<%# Bind("enEmailPrincipalPessoa") %>' />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator4" runat="server" ErrorMessage="E-mail é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="enEmailPrincipalPessoa" />
                            <asp:RegularExpressionValidator Display="None" ID="RegularExpressionValidator1" runat="server" ErrorMessage="O formato de Email é nome@dominio.com.br"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="enEmailPrincipalPessoa" ValidationExpression="^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$" />                          
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Login:*
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:TextBox ID="dsLoginPessoa" runat="server" 
                                Columns="40" MaxLength="40" CssClass="campoTexto" Text='<%# Bind("dsLoginPessoa") %>' />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator5" runat="server" ErrorMessage="Login é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="dsLoginPessoa" />
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Empresa:*
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="false" ID="cdEmpresaColaboradorPessoa" runat="server"   
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataValueField="cdPessoaSEQ" Width="300"
                                DataTextField="dsPessoa" DataSourceID="ObjectDataSource11" />
                        </td>
                        <td>
                            <%if (blnColaborador)
                              { %>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator0" runat="server" ErrorMessage="Empresa é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="cdEmpresaColaboradorPessoa" InitialValue="0" />
                            <%} %>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Inscrição Estadual:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="nuInscricaoEstadualPessoa" runat="server" 
                                Columns="14" CssClass="campoTexto" Text='<%# Bind("nuInscricaoEstadualPessoa") %>' />
                        </td>
                        <td>
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Inscrição Municipal:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="nuInscricaoMunicipalPessoa" runat="server" 
                                Columns="14" CssClass="campoTexto" Text='<%# Bind("nuInscricaoMunicipalPessoa") %>' />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Inscrição Rural:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="nuInscricaoRuralPessoa" runat="server" 
                                Columns="14" CssClass="campoTexto" Text='<%# Bind("nuInscricaoRuralPessoa") %>' />
                        </td>
                        <td>
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Nacionalidade:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="false" ID="cdNacionalidadePessoa" runat="server" ValidationGroup="Form"
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource1" 
                                DataTextField="dsNacionalidadePais" DataValueField="cdPais" />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            RG/Cédula Estr:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="nuRGCedulaEstrangeiroPessoa" runat="server" 
                                CssClass="campoTexto" Text='<%# Bind("nuRGCedulaEstrangeiroPessoa") %>' />
                        </td>
                        <td>
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Data Nascimento:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Date" Enabled="false" ID="dtNascimentoPessoa" runat="server" 
                                CssClass="campoTexto" Text='<%# Bind("dtNascimentoPessoa", "{0:dd/MM/yyyy}") %>' />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Sexo:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="false" ID="cdIndicadorSexoPessoa" runat="server" ValidationGroup="Form"
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource9" 
                                DataTextField="wkDominioCodigoReferenciado" DataValueField="vrDominioCodigoReferenciado" />
                        </td>
                        <td>
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Estado Civil:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="false" ID="cdIndicadorEstadoCivilPessoa" runat="server" ValidationGroup="Form"
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource10" 
                                DataTextField="wkDominioCodigoReferenciado" DataValueField="vrDominioCodigoReferenciado" />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Contato Principal:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="nmContatoPrincipalPessoa" runat="server" 
                                Columns="30" CssClass="campoTexto" Text='<%# Bind("nmContatoPrincipalPessoa") %>' />
                        </td>
                        <td>
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Contato Cobrança:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="nmContatoCobrancaPessoa" runat="server" 
                                Columns="30" CssClass="campoTexto" Text='<%# Bind("nmContatoCobrancaPessoa") %>' />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Situação:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="false" ID="cdIndicadorStatusPessoa" runat="server"   
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataValueField="vrDominioCodigoReferenciado" 
                                DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource5" />
                        </td>
                        <td>
                        </td>
                        <td class="fonteTbCadastro">
                            Representante Comercial:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="nmAgenteComercialRCPessoa" runat="server" 
                                Width="300" CssClass="campoTexto" Text='<%# Bind("nmAgenteComercialRCPessoa") %>' />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="fonteTbCadastro">
                            Cooperativa:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="nmAgenteComercialCooperativaPessoa" runat="server" 
                                Width="300" CssClass="campoTexto" Text='<%# Bind("nmAgenteComercialCooperativaPessoa") %>' />
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <h5 style="text-align: left; color: Green; margin:  20px 0 0 0">Endereço Principal</h5>
                            <hr style="color: Green; height: 1px;" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            País:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="false" ID="cdPaisEnderecoPrincipalPessoa" runat="server"
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource1"
                                DataTextField="nmPais" DataValueField="cdPais" />
                        </td>
                        <td></td>
                        <td class="fonteTbCadastro">
                            Logradouro:
                        </td>
                        <td class="tdCamposFormularios" colspan="3">
                            <conv:TextBox Type="Text" Enabled="false" ID="enLogradouroEnderecoPrincipalPessoa"
                                runat="server" ValidationGroup="Form" Width="300" CssClass="campoTexto" 
                                Text='<%# Bind("enLogradouroEnderecoPrincipalPessoa") %>' />
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="fonteTbCadastro">
                            Bairro:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="enBairroEnderecoPrincipalPessoa" runat="server"
                                Columns="25" CssClass="campoTexto" Text='<%# Bind("enBairroEnderecoPrincipalPessoa") %>' />
                        </td>
                        <td></td>
                        <td class="fonteTbCadastro">
                            Município:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="enMunicipioEnderecoPrincipalPessoa"
                                runat="server" Columns="40" CssClass="campoTexto" Text='<%# Bind("enMunicipioEnderecoPrincipalPessoa") %>' />
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Estado:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="false" ID="cdSiglaEstadoEnderecoPrincipalPessoa" runat="server"
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource6"
                                DataTextField="cdSiglaEstado" DataValueField="cdSiglaEstado" />
                        </td>
                        <td></td>
                        <td class="fonteTbCadastro">
                            CEP:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Enabled="false" Type="Numeric" DecimalPlaces="0" MaxLength="8" 
                                ID="nuCepEnderecoPrincipalPessoa" runat="server" ValidationGroup="Form" 
                                Columns="7" CssClass="campoTexto" Text='<%# Bind("nuCepEnderecoPrincipalPessoa") %>' />
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="fonteTbCadastro">
                            Referência:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="enReferenciaEnderecoPrincipalPessoa"
                                runat="server" Columns="40" CssClass="campoTexto" 
                                Text='<%# Bind("enReferenciaEnderecoPrincipalPessoa") %>' />
                        </td>
                        <td></td>
                        <td class="fonteTbCadastro">
                            Caixa Postal:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="nuCaixaPostalEnderecoPrincipalPessoa"
                                runat="server" Columns="15" CssClass="campoTexto" 
                                Text='<%# Bind("nuCaixaPostalEnderecoPrincipalPessoa") %>' />
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <h5 style="text-align: left; color: Green; margin: 20px 0 0 0">Endereço de Cobrança</h5>
                            <hr style="color: Green; height: 1px;" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            País:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="false" ID="cdPaisEnderecoCobrancaPessoa" runat="server"
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource1"
                                DataTextField="nmPais" DataValueField="cdPais" />
                        </td>
                        <td></td>
                        <td class="fonteTbCadastro">
                            Logradouro:
                        </td>
                        <td class="tdCamposFormularios" colspan="3">
                            <conv:TextBox Type="Text" Enabled="false" ID="enLogradouroEnderecoCobrancaPessoa"
                                runat="server" ValidationGroup="Form" Width="300" CssClass="campoTexto" 
                                Text='<%# Bind("enLogradouroEnderecoCobrancaPessoa") %>' />
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="fonteTbCadastro">
                            Bairro:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="enBairroEnderecoCobrancaPessoa" runat="server"
                                Columns="25" CssClass="campoTexto" Text='<%# Bind("enBairroEnderecoCobrancaPessoa") %>' />
                        </td>
                        <td></td>
                        <td class="fonteTbCadastro">
                            Município:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="enMunicipioEnderecoCobrancaPessoa"
                                runat="server" CssClass="campoTexto" Columns="40" 
                                Text='<%# Bind("enMunicipioEnderecoCobrancaPessoa") %>' />
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Estado:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="false" ID="cdSiglaEstadoEnderecoCobrancaPessoa" runat="server"
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource6"
                                DataTextField="cdSiglaEstado" DataValueField="cdSiglaEstado" />
                        </td>
                        <td></td>
                        <td class="fonteTbCadastro">
                            CEP:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="0" Enabled="false" ID="nuCepEnderecoCobrancaPessoa" 
                                runat="server" MaxLength="8" ValidationGroup="Form"
                                Columns="7" CssClass="campoTexto" Text='<%# Bind("nuCepEnderecoCobrancaPessoa") %>' />
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="fonteTbCadastro">
                            Referência:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="enReferenciaEnderecoCobrancaPessoa"
                                runat="server" Columns="40" CssClass="campoTexto" 
                                Text='<%# Bind("enReferenciaEnderecoCobrancaPessoa") %>' />
                        </td>
                        <td></td>
                        <td class="fonteTbCadastro">
                            Caixa Postal:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="nuCaixaPostalEnderecoCobrancaPessoa"
                                runat="server" Columns="15" CssClass="campoTexto" 
                                Text='<%# Bind("nuCaixaPostalEnderecoCobrancaPessoa") %>' />
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <h5 style="text-align: left; color: Green; margin: 20px 0 0 0">Endereço de Entrega</h5>
                            <hr style="color: Green; height: 1px;" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            País:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="false" ID="cdPaisEnderecoEntregaPessoa" runat="server"
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource1"
                                DataTextField="nmPais" DataValueField="cdPais" />
                        </td>
                        <td></td>
                        <td class="fonteTbCadastro">
                            Logradouro:
                        </td>
                        <td class="tdCamposFormularios" colspan="3">
                            <conv:TextBox Type="Text" Enabled="false" ID="enLogradouroEnderecoEntregaPessoa" Width="300px"
                                runat="server" ValidationGroup="Form" CssClass="campoTexto" Text='<%# Bind("enLogradouroEnderecoEntregaPessoa") %>' />
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="fonteTbCadastro">
                            Bairro:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="enBairroEnderecoEntregaPessoa" runat="server"
                                Columns="25" CssClass="campoTexto" Text='<%# Bind("enBairroEnderecoEntregaPessoa") %>' />
                        </td>
                        <td></td>
                        <td class="fonteTbCadastro">
                            Município:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="enMunicipioEnderecoEntregaPessoa" runat="server"
                                Columns="40" CssClass="campoTexto" Text='<%# Bind("enMunicipioEnderecoEntregaPessoa") %>' />
                        </td>
                        <td></td>
                    </tr>
                    <tr>    
                        <td valign="middle" class="fonteTbCadastro">
                            Estado:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="false" ID="cdSiglaEstadoEnderecoEntregaPessoa" runat="server"
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource6"
                                DataTextField="cdSiglaEstado" DataValueField="cdSiglaEstado" />
                        </td>
                        <td></td>
                        <td class="fonteTbCadastro">
                            CEP:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="0" Enabled="false" ID="nuCepEnderecoEntregaPessoa" 
                                runat="server" MaxLength="8" ValidationGroup="Form"
                                Columns="7" CssClass="campoTexto" Text='<%# Bind("nuCepEnderecoEntregaPessoa") %>' />
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="fonteTbCadastro">
                            Referência:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="enReferenciaEnderecoEntregaPessoa"
                                runat="server" Columns="40" CssClass="campoTexto" 
                                Text='<%# Bind("enReferenciaEnderecoEntregaPessoa") %>' />
                        </td>
                        <td></td>
                        <td class="fonteTbCadastro">
                            Caixa Postal:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="nuCaixaPostalEnderecoEntregaPessoa"
                                runat="server" Columns="15" CssClass="campoTexto" 
                                Text='<%# Bind("nuCaixaPostalEnderecoEntregaPessoa") %>' />
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <h5 style="text-align: left; color: Green; margin: 20px 0 0 0">Telefone Principal</h5>
                            <hr style="color: Green; height: 1px;" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            DDI:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="false" ID="cdPaisTelefonePrincipalPessoa" runat="server" 
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource7" 
                                DataTextField="dsDDI" DataValueField="cdPais" />
                        </td>
                        <td>
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            DDD:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Enabled="false" ID="nuDDDTelefonePrincipalPessoa" runat="server" 
                                Columns="2" Type="Numeric" DecimalPlaces="0" MaxLength="2" CssClass="campoTexto" Text='<%# Bind("nuDDDTelefonePrincipalPessoa") %>' />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Telefone:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="0" MaxLength="8" Enabled="false" ID="nuTelefonePrincipalPessoa" runat="server" 
                                Columns="8" CssClass="campoTexto" Text='<%# Bind("nuTelefonePrincipalPessoa") %>' />
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <h5 style="text-align: left; color: Green; margin: 20px 0 0 0">FAX</h5>
                            <hr style="color: Green; height: 1px;" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            DDI:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="false" ID="cdPaisTelefoneFAXPessoa" runat="server" 
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource7" 
                                DataTextField="dsDDI" DataValueField="cdPais" />
                        </td>
                        <td>
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            DDD:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Enabled="false" ID="nuDDDTelefoneFAXPessoa" runat="server" 
                                Columns="2" Type="Numeric" DecimalPlaces="0" MaxLength="2" CssClass="campoTexto" Text='<%# Bind("nuDDDTelefoneFAXPessoa") %>' />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Telefone:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="0" MaxLength="8" Enabled="false" ID="nuTelefoneFAXPessoa" runat="server" 
                                Columns="8" CssClass="campoTexto" Text='<%# Bind("nuTelefoneFAXPessoa") %>' />
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr> 
                    <tr>
                        <td colspan="6">
                            <h5 style="text-align: left; color: Green; margin: 20px 0 0 0">Celular</h5>
                            <hr style="color: Green; height: 1px;" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            DDI:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="false" ID="cdPaisTelefoneCelularPessoa" runat="server" 
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource7" 
                                DataTextField="dsDDI" DataValueField="cdPais" />
                        </td>
                        <td>
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            DDD:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Enabled="false" ID="nuDDDTelefoneCelularPessoa" runat="server" 
                                Columns="2" Type="Numeric" DecimalPlaces="0" MaxLength="2" CssClass="campoTexto" Text='<%# Bind("nuDDDTelefoneCelularPessoa") %>' />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Telefone:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="0" MaxLength="8" Enabled="false" ID="nuTelefoneCelularPessoa" runat="server" 
                                Columns="8" CssClass="campoTexto" Text='<%# Bind("nuTelefoneCelularPessoa") %>' />
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Demais campos solicitados pelo método de gravação -->
            <div>
                <asp:HiddenField ID="cdUsuarioUltimaAlteracao" runat="server" />
                <asp:HiddenField ID="cdPessoaSEQ" runat="server" Value='<%# Bind("cdPessoaSEQ") %>' />
                <asp:HiddenField ID="cdGrupoAcessoSEQ" runat="server" Value='<%# Bind("cdGrupoAcessoSEQ") %>' />
                <asp:HiddenField ID="cdIndicadorTipoAcessoPessoa" runat="server" Value='<%# Bind("cdIndicadorTipoAcessoPessoa") %>' />
                <asp:HiddenField ID="cdIndicadorPrimeiroAcessoPessoa" runat="server" Value='<%# Bind("cdIndicadorPrimeiroAcessoPessoa") %>' />
                <asp:HiddenField ID="cdIndicadorSenhaBloqueadaPessoa" runat="server" Value='<%# Bind("cdIndicadorSenhaBloqueadaPessoa") %>' />
                <asp:HiddenField ID="cdIndicadorTipoPerfilPessoa" runat="server" Value='<%# Bind("cdIndicadorTipoPerfilPessoa") %>' /> 
            </div>
            
            <div visible="false">
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="ObterListaNacionalidade" TypeName="Pais">
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
                    <SelectParameters>
                        <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORTIPOACESSO" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
                    <SelectParameters>
                        <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORSIMNAO" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" SelectMethod="ObterLista" TypeName="GrupoAcesso">
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource5" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
                    <SelectParameters>
                        <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORATIVOINATIVO" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource6" runat="server" SelectMethod="ObterLista" TypeName="Estado">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="1" Name="cdPais" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource7" runat="server" SelectMethod="ObterListaDDI" TypeName="Pais">
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource8" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
                    <SelectParameters>
                        <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORPESSOA" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>  
                <asp:ObjectDataSource ID="ObjectDataSource9" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
                    <SelectParameters>
                        <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORSEXO" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource> 
                <asp:ObjectDataSource ID="ObjectDataSource10" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
                    <SelectParameters>
                        <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORESTADOCIVIL" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource11" runat="server" SelectMethod="ObterListaOnDemandERP" TypeName="Pessoa">
                    <SelectParameters>
                        <asp:Parameter Name="cdIndicadorTipoPerfilPessoa" DefaultValue="3" Type="Int32" />
                        <asp:SessionParameter SessionField="cdUsuario" Name="cdUsuarioUltimaAlteracao" Type="Int64" />
                        <asp:Parameter Name="cdIndicadorTipoAgenteComercialPessoa" DefaultValue="0" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </div>
            
        </EditItemTemplate>          
    </asp:FormView>

    <div visible="false">
        <asp:ObjectDataSource ID="ObjectDataSource12" runat="server" TypeName="Pessoa">
            <SelectParameters>
                <asp:Parameter Name="cdPessoaSEQ" Type="Int64" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
    
    <div style="text-align: left">
        <table>
            <tr>
                <td class="fonteTbCadastro">
                    (*) Os campos marcados com asterisco são de preenchimento obrigatório
                </td>
            </tr>
        </table>
    </div> 
    
    <div style="text-align: right;">
        <asp:Button runat="server" ID="btAction" CssClass="button" Text="salvar" 
            CommandName="AlterarCliente" ValidationGroup="Form" 
            CausesValidation="true" OnCommand="btAction_OnClick" />
    </div>           
    
</div>
<%} else { %>
    <div class="tbCadastro_Mestra">
        <h2 style="color: #808080">Cadastro atualizado com sucesso!</h2>
    </div>   
<%} %>