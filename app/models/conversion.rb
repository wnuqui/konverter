class Conversion < ApplicationRecord
  URL = 'https://www.google.com/search?q=BASE+AMOUNT+to+TARGET'.freeze

  class << self
    def convert(options)
      conversion = fetch_cached_or_create_conversion(options)
      result = convert_via_google(options)
      conversion.update_attribute(:result, result)
      result
    end

    private

    def fetch_cached_or_create_conversion(options)
      now = Time.now
      conversion = where({ created_at: (now - 1.minute)..now }).where(options).first
      conversion.nil? ? create(options) : conversion
    end

    def convert_currency_url(options)
      url = URL
            .gsub(/BASE/, options[:base])
            .gsub(/TARGET/, options[:target])

      options[:base_amount] ? url.gsub(/AMOUNT/, options[:base_amount]) : url.gsub(/AMOUNT\+/, '')
    end

    def convert_via_google(options)
      agent = Mechanize.new
      page  = agent.get(convert_currency_url(options))
      doc   = page.parser

      result = doc.xpath('//*[@id="ires"]/ol/table').children.children[2].children.children[0].children.text

      result
    end
  end
end
