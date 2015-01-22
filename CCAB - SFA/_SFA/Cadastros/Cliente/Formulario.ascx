<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Formulario.ascx.cs" Inherits="_SFA_Cliente_Formulario" %>

<!-- Preparação da PopUp Modal que exibirá o Formulário (Permite que o formulário seja arrastado pela tela) -->
<asp:Button runat="server" ID="btShowPanel1" Style="display: none" />
<asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btShowPanel1"
    PopupControlID="Panel1" PopupDragHandleControlID="Panel1DragHandle" BackgroundCssClass="modalBackground" />
    
<!-- Cabeçalho Formulário -->    
<div class="pageSection">
    <asp:Panel runat="Server" ID="Panel1DragHandle" CssClass="drag">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td class="tbTitulo_bordaEsquerda">
                    &nbsp;
                </td>
                <td class="tbTitulo_BG">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td width="250" class="tbTitulo_NomeTela" align="left">
                                <asp:Label runat="server" SkinID="normal" ID="lbOperacao" />
                            </td>
                            <td width="*">
                                <asp:Image ID="Image2" runat="server" Width="18" Height="36" ImageAlign="Right" ImageUrl="~/imgsCCAB/tbTitulo_imgMarcador.jpg" />
                            </td>
                            <td width="265" class="tbTitulo_NomeTela" align="left">
                                <asp:Label ID="lbNomeTela" runat="server" SkinID="normal" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="tbTitulo_bordaDireita">
                    &nbsp;
                </td>
            </tr>
        </table>
    </asp:Panel>
</div>
<!-- Área de Mensagens -->
<div>
    <asp:ValidationSummary EnableClientScript="true" ID="ValidationSummary1" ShowSummary="false"
        ShowMessageBox="true" ValidationGroup="Form" HeaderText="O formulário contém erros:"
        runat="server" />
    <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Form" />
</div>
<!-- Formulário -->
<div>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="cdPessoaSEQ" CellPadding="5"
        AutoGenerateRows="false" Width="100%" GridLines="None">
        
        <EditItemTemplate>
            <div class="pageSection">
                
                <asp:TabContainer ID="TabContainer1" Height="335" runat="server">
                    
                    <asp:TabPanel ID="TabPanel1" runat="server" HeaderText="Cadastro Básico">
                        <ContentTemplate>
                            <table width="100%" border="0" cellpadding="3" cellspacing="0">
                                <tr>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Tipo Pessoa:
                                    </td>
                                    <td class="tdCamposFormularios" colspan="4">
                                        <asp:DropDownList Enabled="false" ID="cdIndicadorPessoa" runat="server" ValidationGroup="Form"
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource8" 
                                            DataValueField="vrDominioCodigoReferenciado" DataTextField="wkDominioCodigoReferenciado"  />
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fonteTbCadastro">
                                        Código:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="cdPessoaERP" runat="server" 
                                            Columns="14" CssClass="campoTexto" Text='<%# Bind("cdPessoaERP") %>' />
                                    </td>
                                    <td></td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        CNPJ/CPF:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuCNPJCPFPessoa" runat="server" 
                                            Columns="14" CssClass="campoTexto" Text='<%# Bind("nuCNPJCPFPessoa") %>' />
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="fonteTbCadastro">
                                        Nome:
                                    </td>
                                    <td class="tdCamposFormularios" colspan="4">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nmPessoa" runat="server" 
                                            Columns="123" CssClass="campoTexto" Text='<%# Bind("nmPessoa") %>' />
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fonteTbCadastro">
                                        Nome Reduzido:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nmReduzidoPessoa" runat="server" 
                                            Columns="40" CssClass="campoTexto" Text='<%# Bind("nmReduzidoPessoa") %>' />
                                    </td>
                                    <td>
                                    </td>
                                    <td class="fonteTbCadastro">
                                        E-mail:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="enEmailPrincipalPessoa" runat="server" 
                                            Columns="40" CssClass="campoTexto" Text='<%# Bind("enEmailPrincipalPessoa") %>' />
                                    </td>
                                    <td>
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
                                    <td class="tdCamposFormularios" colspan="4">
                                        <asp:DropDownList Enabled="false" ID="cdIndicadorStatusPessoa" runat="server"   
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataValueField="vrDominioCodigoReferenciado" 
                                            DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource5" />
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fonteTbCadastro">
                                        Representante Comercial:
                                    </td>
                                    <td class="tdCamposFormularios" colspan="4">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nmAgenteComercialRCPessoa" runat="server" 
                                            Columns="123" CssClass="campoTexto" Text='<%# Bind("nmAgenteComercialRCPessoa") %>' />
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fonteTbCadastro">
                                        Cooperativa:
                                    </td>
                                    <td class="tdCamposFormularios" colspan="4">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nmAgenteComercialCooperativaPessoa" runat="server" 
                                            Columns="123" CssClass="campoTexto" Text='<%# Bind("nmAgenteComercialCooperativaPessoa") %>' />
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fonteTbCadastro">
                                        Agente CCAB:
                                    </td>
                                    <td class="tdCamposFormularios" colspan="4">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nmAgenteComercialCCABPessoa" runat="server" 
                                            Columns="123" CssClass="campoTexto" Text='<%# Bind("nmAgenteComercialCCABPessoa") %>' />
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:TabPanel>
                    
                    <asp:TabPanel ID="TabPanel2" runat="server" HeaderText="Endereços">
                        <ContentTemplate>
                            <table width="100%" border="0" cellpadding="3" cellspacing="0">
                                <tr>
                                    <td colspan="6">
                                        <h5 style="text-align: left; color: Gray; margin: 0 0 0 0">
                                            Endereço Principal</h5>
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
                                    <td class="fonteTbCadastro">
                                        Logradouro:
                                    </td>
                                    <td class="tdCamposFormularios" colspan="3">
                                        <conv:TextBox Type="Text" Enabled="false" ID="enLogradouroEnderecoPrincipalPessoa"
                                            runat="server" ValidationGroup="Form" Columns="100" CssClass="campoTexto" Text='<%# Bind("enLogradouroEnderecoPrincipalPessoa") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fonteTbCadastro">
                                        Bairro:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="enBairroEnderecoPrincipalPessoa" runat="server"
                                            Columns="25" CssClass="campoTexto" Text='<%# Bind("enBairroEnderecoPrincipalPessoa") %>' />
                                    </td>
                                    <td class="fonteTbCadastro">
                                        Município:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="enMunicipioEnderecoPrincipalPessoa"
                                            runat="server" Columns="40" CssClass="campoTexto" Text='<%# Bind("enMunicipioEnderecoPrincipalPessoa") %>' />
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Estado:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList Enabled="false" ID="cdSiglaEstadoEnderecoPrincipalPessoa" runat="server"
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource6"
                                            DataTextField="cdSiglaEstado" DataValueField="cdSiglaEstado" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fonteTbCadastro">
                                        CEP:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Enabled="false" ID="nuCepEnderecoPrincipalPessoa" runat="server" ValidationGroup="Form"
                                            Columns="7" CssClass="campoTexto" Text='<%# Bind("nuCepEnderecoPrincipalPessoa") %>' />
                                    </td>
                                    <td class="fonteTbCadastro">
                                        Referência:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="enReferenciaEnderecoPrincipalPessoa"
                                            runat="server" Columns="40" CssClass="campoTexto" Text='<%# Bind("enReferenciaEnderecoPrincipalPessoa") %>' />
                                    </td>
                                    <td class="fonteTbCadastro">
                                        Caixa Postal:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuCaixaPostalEnderecoPrincipalPessoa"
                                            runat="server" Columns="15" CssClass="campoTexto" Text='<%# Bind("nuCaixaPostalEnderecoPrincipalPessoa") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6">
                                        <h5 style="text-align: left; color: Gray; margin: 0 0 0 0">
                                            Endereço de Cobrança</h5>
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
                                    <td class="fonteTbCadastro">
                                        Logradouro:
                                    </td>
                                    <td class="tdCamposFormularios" colspan="3">
                                        <conv:TextBox Type="Text" Enabled="false" ID="enLogradouroEnderecoCobrancaPessoa"
                                            runat="server" ValidationGroup="Form" Columns="100" CssClass="campoTexto" Text='<%# Bind("enLogradouroEnderecoCobrancaPessoa") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fonteTbCadastro">
                                        Bairro:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="enBairroEnderecoCobrancaPessoa" runat="server"
                                            Columns="25" CssClass="campoTexto" Text='<%# Bind("enBairroEnderecoCobrancaPessoa") %>' />
                                    </td>
                                    <td class="fonteTbCadastro">
                                        Município:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="enMunicipioEnderecoCobrancaPessoa"
                                            runat="server" Columns="40" CssClass="campoTexto" Text='<%# Bind("enMunicipioEnderecoCobrancaPessoa") %>' />
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Estado:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList Enabled="false" ID="cdSiglaEstadoEnderecoCobrancaPessoa" runat="server"
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource6"
                                            DataTextField="cdSiglaEstado" DataValueField="cdSiglaEstado" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fonteTbCadastro">
                                        CEP:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Enabled="false" ID="nuCepEnderecoCobrancaPessoa" runat="server" ValidationGroup="Form"
                                            Columns="7" CssClass="campoTexto" Text='<%# Bind("nuCepEnderecoCobrancaPessoa") %>' />
                                    </td>
                                    <td class="fonteTbCadastro">
                                        Referência:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="enReferenciaEnderecoCobrancaPessoa"
                                            runat="server" Columns="40" CssClass="campoTexto" Text='<%# Bind("enReferenciaEnderecoCobrancaPessoa") %>' />
                                    </td>
                                    <td class="fonteTbCadastro">
                                        Caixa Postal:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuCaixaPostalEnderecoCobrancaPessoa"
                                            runat="server" Columns="15" CssClass="campoTexto" Text='<%# Bind("nuCaixaPostalEnderecoCobrancaPessoa") %>' />
                                    </td>
                                </tr> 
                                <tr>
                                    <td colspan="6">
                                        <h5 style="text-align: left; color: Gray; margin: 0 0 0 0">
                                            Endereço de Entrega</h5>
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
                                    <td class="fonteTbCadastro">
                                        Logradouro:
                                    </td>
                                    <td class="tdCamposFormularios" colspan="3">
                                        <conv:TextBox Type="Text" Enabled="false" ID="enLogradouroEnderecoEntregaPessoa"
                                            runat="server" ValidationGroup="Form" Columns="100" CssClass="campoTexto" Text='<%# Bind("enLogradouroEnderecoEntregaPessoa") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fonteTbCadastro">
                                        Bairro:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="enBairroEnderecoEntregaPessoa" runat="server"
                                            Columns="25" CssClass="campoTexto" Text='<%# Bind("enBairroEnderecoEntregaPessoa") %>' />
                                    </td>
                                    <td class="fonteTbCadastro">
                                        Município:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="enMunicipioEnderecoEntregaPessoa" runat="server"
                                            Columns="40" CssClass="campoTexto" Text='<%# Bind("enMunicipioEnderecoEntregaPessoa") %>' />
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Estado:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList Enabled="false" ID="cdSiglaEstadoEnderecoEntregaPessoa" runat="server"
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource6"
                                            DataTextField="cdSiglaEstado" DataValueField="cdSiglaEstado" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fonteTbCadastro">
                                        CEP:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Enabled="false" ID="nuCepEnderecoEntregaPessoa" runat="server" ValidationGroup="Form"
                                            Columns="7" CssClass="campoTexto" Text='<%# Bind("nuCepEnderecoEntregaPessoa") %>' />
                                    </td>
                                    <td class="fonteTbCadastro">
                                        Referência:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="enReferenciaEnderecoEntregaPessoa"
                                            runat="server" Columns="40" CssClass="campoTexto" Text='<%# Bind("enReferenciaEnderecoEntregaPessoa") %>' />
                                    </td>
                                    <td class="fonteTbCadastro">
                                        Caixa Postal:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuCaixaPostalEnderecoEntregaPessoa"
                                            runat="server" Columns="15" CssClass="campoTexto" Text='<%# Bind("nuCaixaPostalEnderecoEntregaPessoa") %>' />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:TabPanel>
                    
                    <asp:TabPanel ID="TabPanel3" runat="server" HeaderText="Telefones">
                        <ContentTemplate>
                            <table width="100%" border="0" cellpadding="3" cellspacing="0">
                                <tr>
                                    <td colspan="9">
                                        <h5 style="text-align: left; color: Gray; margin:  0 0 0 0">Telefone Principal</h5>
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
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuDDDTelefonePrincipalPessoa" runat="server" 
                                            Columns="2" CssClass="campoTexto" Text='<%# Bind("nuDDDTelefonePrincipalPessoa") %>' />
                                    </td>
                                    <td>
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Telefone:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuTelefonePrincipalPessoa" runat="server" 
                                            Columns="10" CssClass="campoTexto" Text='<%# Bind("nuTelefonePrincipalPessoa") %>' />
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="9">
                                        <h5 style="text-align: left; color: Gray; margin:  0 0 0 0">FAX</h5>
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
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuDDDTelefoneFAXPessoa" runat="server" 
                                            Columns="2" CssClass="campoTexto" Text='<%# Bind("nuDDDTelefoneFAXPessoa") %>' />
                                    </td>
                                    <td>
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Telefone:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuTelefoneFAXPessoa" runat="server" 
                                            Columns="10" CssClass="campoTexto" Text='<%# Bind("nuTelefoneFAXPessoa") %>' />
                                    </td>
                                    <td>
                                    </td>
                                </tr> 
                                <tr>
                                    <td colspan="9">
                                        <h5 style="text-align: left; color: Gray; margin:  0 0 0 0">Celular</h5>
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
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuDDDTelefoneCelularPessoa" runat="server" 
                                            Columns="2" CssClass="campoTexto" Text='<%# Bind("nuDDDTelefoneCelularPessoa") %>' />
                                    </td>
                                    <td>
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Telefone:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuTelefoneCelularPessoa" runat="server" 
                                            Columns="10" CssClass="campoTexto" Text='<%# Bind("nuTelefoneCelularPessoa") %>' />
                                    </td>
                                    <td>
                                    </td>
                                </tr>   
                            </table>
                        </ContentTemplate>
                    </asp:TabPanel>
                    
                    <asp:TabPanel ID="TabPanel4" runat="server" HeaderText="Segurança de Acesso">
                        <ContentTemplate>
                            <asp:HiddenField ID="cdPessoaSEQ" runat="server" Value='<%# Bind("cdPessoaSEQ") %>' /> 
                            <table width="100%" border="0" cellpadding="3" cellspacing="0">
                                <tr>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Login:*
                                    </td>
                                    <td class="tdCamposFormularios" colspan="4">
                                        <conv:TextBox Type="Text" ID="dsLoginPessoa" runat="server" 
                                            Columns="40" MaxLength="40" CssClass="campoTexto" Text='<%# Bind("dsLoginPessoa") %>' />
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator5" runat="server" ErrorMessage="Login é campo obrigatório"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="dsLoginPessoa" />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Tipo de Acesso:*
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList ID="cdIndicadorTipoAcessoPessoa" runat="server" ValidationGroup="Form"
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource2" 
                                            DataTextField="wkDominioCodigoReferenciado" DataValueField="vrDominioCodigoReferenciado" />
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator6" runat="server" ErrorMessage="Tipo de Acesso deve ser informado"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="cdIndicadorTipoAcessoPessoa" InitialValue="0" />
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Primeiro Acesso:*
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList ID="cdIndicadorPrimeiroAcessoPessoa" runat="server" ValidationGroup="Form"
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource3" 
                                            DataTextField="wkDominioCodigoReferenciado" DataValueField="vrDominioCodigoReferenciado" />
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator7" runat="server" ErrorMessage="Deve ser informado se é Primeiro Acesso ou não"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="cdIndicadorPrimeiroAcessoPessoa" InitialValue="0" />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Senha Bloqueada:*
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList ID="cdIndicadorSenhaBloqueadaPessoa" runat="server" ValidationGroup="Form"
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource3" 
                                            DataTextField="wkDominioCodigoReferenciado" DataValueField="vrDominioCodigoReferenciado" />
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator8" runat="server" ErrorMessage="Deve ser informado se a Senha está bloqueada ou não"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="cdIndicadorSenhaBloqueadaPessoa" InitialValue="0" />
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Grupo Acesso:*
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList ID="cdGrupoAcessoSEQ" runat="server" ValidationGroup="Form"
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource4" 
                                            DataTextField="dsGrupoAcesso" DataValueField="cdGrupoAcessoSEQ" />
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator2" runat="server" ErrorMessage="O Grupo de Acesso não foi informado"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="cdGrupoAcessoSEQ" InitialValue="0" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:TabPanel>
                    
                </asp:TabContainer>
                
            </div>
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
        </EditItemTemplate>          
    </asp:FormView>
    
    <div style="text-align: right;">
        <asp:Button runat="server" ID="btAction" CssClass="button" ValidationGroup="Form"
            CausesValidation="true" OnCommand="btAction_OnClick" />
        <asp:Button runat="server" ID="btCancel" CommandName="Cancel" CssClass="button" Text="cancelar" 
            CausesValidation="false" OnCommand="btCancel_OnClick" />
    </div>
</div>

