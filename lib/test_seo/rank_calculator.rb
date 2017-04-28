class TestSeo::RankCalculator

  def self.rank(links)
    links.map do |link|
      tyc_url   = "http://bar-navig.yandex.ru/u?ver=2&url=#{link}&show=1"
      alexa_url = "http://data.alexa.com/data?cli=10&url=#{link}"
      tyc_response   = TestSeo.agent.get tyc_url
      alexa_response = TestSeo.agent.get alexa_url

      {
        url:    link,
        tyc:    tyc_response.search('//tcy').first['value'],
        alexa:  alexa_response.search('//POPULARITY').first['TEXT'],
      }
    end
  end

end
