=begin
Este bloco de configuração RSpec é usado para gerenciar a limpeza do banco de dados durante os testes.
- config.before(:suite): Antes de todos os testes, limpamos o banco de dados (removemos tudo).
- config.before(:each): Antes de cada teste individual, configuramos a estrategia de limpeza para "transacao". Isso nos ajuda a manter o banco de dados limpo entre os testes.
- config.before(:each, js: true): Se o teste tiver a opção "js: true", fazemos a mesma configuracao de "transacao" antes do teste.
- config.before(:each): Sempre antes de cada teste, iniciamos o DatabaseCleaner.
- config.after(:each): Apos cada teste, limpamos o banco de dados, usando a estrategia configurada anteriormente.
=end

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
