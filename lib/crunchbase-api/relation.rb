module Crunchbase

  class Relation

    attr_reader :type
    attr_reader :name
    attr_reader :path
    attr_reader :created_at
    attr_reader :updated_at
    attr_reader :money_invested
    attr_reader :money_invested_usd
    attr_reader :money_raised_currency_code
    attr_reader :investors

    def initialize(data)
      @type = data['type']
      @name = data['name']
      @path = data['path']
      @money_invested = data['money_invested'] unless data['money_invested'].nil?
      @money_invested_usd = data['money_invested_usd'] unless data['money_invested_usd'].nil?
      @money_raised_currency_code = data['money_invested_currency_code'] unless data['money_invested_currency_code'].nil?
      @investors = data['investors'] unless data['investors'].nil?

      @created_at = Time.at(data['created_at']) unless data['created_at'].nil?
      @updated_at = Time.at(data['updated_at']) unless data['updated_at'].nil?
    end

    def fetch
      supported_relations = %w[Organization Person Product FundingRound Acquisition Ipo InvestorInvestment]
      unless supported_relations.include?(@type)
        raise CrunchbaseException, "Fetching of '#{@type}' relations is not supported at this time"
      end
      result = Crunchbase.fetch @path
      Crunchbase.const_get(@type).new result
    end

  end

end
