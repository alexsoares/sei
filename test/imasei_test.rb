require 'test_helper'

describe 'imasei' do

  before do
    Imasei.configure do |config|
      config.wsdl = ENV['SEI_CONFIG_WSDL']
      config.follow_redirects = true
      config.pretty_print_xml = true
      config.sigla = ENV['SEI_CONFIG_SIGLA']
      config.identificacao = ENV['SEI_CONFIG_IDENTIFICACAO']
    end
  end

  it 'tem um número de versão' do
    refute_nil ::Imasei::VERSION
  end

  it 'gera um procedimento sem documento' do
    procedimento = Imasei::Estruturas::Procedimento.new
                    .id_tipo_procedimento('20')
                    .especificacao('Especificação do processo')
                    .assunto('01.01.01', 'Licitação')
                    .interessado('leandro.telles', 'Leandro Telles')
                    .observacao('Observação do webservice')
                    .nivel_de_acesso('0')
    
    retorno_geracao_procedimento = Imasei::Servico.gerar_procedimento(
                                      '110000949',
                                      procedimento,
                                      documentos = [],
                                      procedimentos_relacionados = [],
                                      unidades_envio = [],
                                      manter_aberto_unidade = 'N',
                                      enviar_email_notificacao = 'N',
                                      data_retorno_programado = nil,
                                      dias_retorno_programado = nil,
                                      dias_uteis_retorno_programado = 'N')

    refute_nil retorno_geracao_procedimento.id_procedimento
  end

  it 'gera um procedimento com 1 documento gerado' do
    procedimento = Imasei::Estruturas::Procedimento.new
                    .id_tipo_procedimento('20')
                    .especificacao('Especificação do processo')
                    .assunto('01.01.01', 'Licitação')
                    .interessado('leandro.telles', 'Leandro Telles')
                    .observacao('Observação do webservice')
                    .nivel_de_acesso('0')
    documentos = [
      Imasei::Estruturas::Documento.new
        .tipo('G')
        .id_serie('20')
        .descricao('Descrição do documento 1')
        .remetente('Remetente do documento 1')
        .observacao('Observação do documento 1')
        .conteudo('Conteúdo do documento 1')
    ]

    retorno_geracao_procedimento = Imasei::Servico.gerar_procedimento(
                                      '110000949',
                                      procedimento,
                                      documentos,
                                      procedimentos_relacionados = [],
                                      unidades_envio = [],
                                      manter_aberto_unidade = 'N',
                                      enviar_email_notificacao = 'N',
                                      data_retorno_programado = nil,
                                      dias_retorno_programado = nil,
                                      dias_uteis_retorno_programado = 'N')

    refute_nil retorno_geracao_procedimento.id_procedimento
  end

  it 'gera um procedimento com 2 documentos gerados' do
    procedimento = Imasei::Estruturas::Procedimento.new
                    .id_tipo_procedimento('20')
                    .especificacao('Especificação do processo')
                    .assunto('01.01.01', 'Licitação')
                    .interessado('leandro.telles', 'Leandro Telles')
                    .observacao('Observação do webservice')
                    .nivel_de_acesso('0')
    documentos = [
      Imasei::Estruturas::Documento.new
        .tipo('G')
        .id_serie('20')
        .descricao('Descrição do documento 1')
        .remetente('Remetente do documento 1')
        .observacao('Observação do documento 1')
        .conteudo('Conteúdo do documento 1'),
      Imasei::Estruturas::Documento.new
        .tipo('G')
        .id_serie('20')
        .descricao('Descrição do documento 2')
        .remetente('Remetente do documento 2')
        .observacao('Observação do documento 2')
        .conteudo('Conteúdo do documento 2')
    ]

    retorno_geracao_procedimento = Imasei::Servico.gerar_procedimento(
                                      '110000949',
                                      procedimento,
                                      documentos,
                                      procedimentos_relacionados = [],
                                      unidades_envio = [],
                                      manter_aberto_unidade = 'N',
                                      enviar_email_notificacao = 'N',
                                      data_retorno_programado = nil,
                                      dias_retorno_programado = nil,
                                      dias_uteis_retorno_programado = 'N')

    refute_nil retorno_geracao_procedimento.id_procedimento
  end

  it 'gera um procedimento com 1 documento recebido' do
    procedimento = Imasei::Estruturas::Procedimento.new
                    .id_tipo_procedimento('20')
                    .especificacao('Especificação do processo')
                    .assunto('01.01.01', 'Licitação')
                    .interessado('leandro.telles', 'Leandro Telles')
                    .observacao('Observação do webservice')
                    .nivel_de_acesso('0')
    documentos = [
      Imasei::Estruturas::Documento.new
        .tipo('R')
        .id_serie('20')
        .numero('Nome na árvore')
        .data(Date.today)
        .remetente('Remetente do documento')
        .nome_arquivo('ws-manual.pdf')
        .conteudo(File.read('./test/ws-manual.pdf'))
    ]

    retorno_geracao_procedimento = Imasei::Servico.gerar_procedimento(
                                      '110000949',
                                      procedimento,
                                      documentos,
                                      procedimentos_relacionados = [],
                                      unidades_envio = [],
                                      manter_aberto_unidade = 'N',
                                      enviar_email_notificacao = 'N',
                                      data_retorno_programado = nil,
                                      dias_retorno_programado = nil,
                                      dias_uteis_retorno_programado = 'N')

    refute_nil retorno_geracao_procedimento.id_procedimento
  end

  it 'gera um procedimento com 2 documentos recebidos' do
    procedimento = Imasei::Estruturas::Procedimento.new
                    .id_tipo_procedimento('20')
                    .especificacao('Especificação do processo')
                    .assunto('01.01.01', 'Licitação')
                    .interessado('leandro.telles', 'Leandro Telles')
                    .observacao('Observação do webservice')
                    .nivel_de_acesso('0')
    documentos = [
      Imasei::Estruturas::Documento.new
        .tipo('R')
        .id_serie('20')
        .numero('Nome na árvore')
        .data(Date.today)
        .remetente('Remetente do documento')
        .nome_arquivo('ws-manual.pdf')
        .conteudo(File.read('./test/ws-manual.pdf')),
      Imasei::Estruturas::Documento.new
        .tipo('R')
        .id_serie('20')
        .numero('Nome na árvore')
        .data(Date.today)
        .remetente('Remetente do documento')
        .nome_arquivo('logo-sei.png')
        .conteudo(File.read('./test/logo-sei.png'))
    ]

    retorno_geracao_procedimento = Imasei::Servico.gerar_procedimento(
                                      '110000949',
                                      procedimento,
                                      documentos,
                                      procedimentos_relacionados = [],
                                      unidades_envio = [],
                                      manter_aberto_unidade = 'N',
                                      enviar_email_notificacao = 'N',
                                      data_retorno_programado = nil,
                                      dias_retorno_programado = nil,
                                      dias_uteis_retorno_programado = 'N')

    refute_nil retorno_geracao_procedimento.id_procedimento
  end

  it 'gera um procedimento e adiciona 1 documento gerado' do
    procedimento = Imasei::Estruturas::Procedimento.new
                    .id_tipo_procedimento('20')
                    .especificacao('Especificação do processo')
                    .assunto('01.01.01', 'Licitação')
                    .interessado('leandro.telles', 'Leandro Telles')
                    .observacao('Observação do webservice')
                    .nivel_de_acesso('0')
    
    retorno_geracao_procedimento = Imasei::Servico.gerar_procedimento(
                                      '110000949',
                                      procedimento,
                                      documentos = [],
                                      procedimentos_relacionados = [],
                                      unidades_envio = [],
                                      manter_aberto_unidade = 'N',
                                      enviar_email_notificacao = 'N',
                                      data_retorno_programado = nil,
                                      dias_retorno_programado = nil,
                                      dias_uteis_retorno_programado = 'N')

    documento =
      Imasei::Estruturas::Documento.new
        .tipo('G')
        .id_procedimento(retorno_geracao_procedimento.id_procedimento)
        .id_serie('20')
        .descricao('Descrição do documento 1')
        .remetente('Remetente do documento 1')
        .observacao('Observação do documento 1')
        .conteudo('Conteúdo do documento 1')

    retorno_inclusao_documento = Imasei::Servico.incluir_documento(
                                    '110000949',
                                    documento)

    refute_nil retorno_inclusao_documento.id_documento
  end

end
