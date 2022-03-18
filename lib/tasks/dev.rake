namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      execute_spinner("Apagando BD...") {%x(rails db:drop)}
      execute_spinner("Criando BD...") {%x(rails db:create)}
      execute_spinner("Migrando BD...") {%x(rails db:migrate)}
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      "Você não está em ambiente de desenvolvimento!"
    end
  end

  desc "Cadastra moedas na tabela coins"
  task add_coins: :environment do
    execute_spinner("Cadastrando moedas...") do
      coins = [
          {
              description: "Bitcoin",
              acronym: "BTC",
              url_image: "https://www.dlf.pt/dfpng/middlepng/254-2543000_bitcoin-logo-hd-png-download.png",
              mining_type: MiningType.find_by(acronym: 'PoW')
          },
          {
              description: "Ethereum",
              acronym: "ETH",
              url_image: "https://d33wubrfki0l68.cloudfront.net/fcd4ecd90386aeb50a235ddc4f0063cfbb8a7b66/4295e/static/bfc04ac72981166c740b189463e1f74c/40129/eth-diamond-black-white.jpg",
              mining_type: MiningType.all.sample
          },
          {
              description: "Dash",
              acronym: "DASH",
              url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/131.png",
              mining_type: MiningType.all.sample
          }
      ]

      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Cadastra tipos de mineração na tabela mining_types"
  task add_mining_types: :environment do
    execute_spinner("Cadastrando tipos de mineração...") do
      mining_types = [
          {
            description: "Proof of Work",
            acronym: "PoW"
          },
          {
            description: "Proof of Stake",
            acronym: "PoS"
          },
          {
            description: "Proof of Capacity",
            acronym: "PoC"
          }
      ]

      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end

  private
  
  def execute_spinner(msg_start)
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(Concluído!)")
  end

end
