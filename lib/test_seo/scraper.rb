require 'mechanize'

class TestSeo::Scraper
  GOOGLE_API_KEY   = "AIzaSyDPUTVmb-9-4bPs5txZcc7eiLWLkb5TBRY"
  GOOGLE_ENGINE_ID = "009349026759546465297:awpc7okfknq"
  YANDEX_API_USER  = "sirgris"
  YANDEX_API_KEY   = "03.94719674:a415f0d52cab12313f1406c6c16714d6"

  def self.scrape_yandex(query)
    encoded_query = URI::encode(query)
    api_url = "https://yandex.ru/search/xml"
    params = {
      user:   YANDEX_API_USER,
      key:    YANDEX_API_KEY,
      query:  encoded_query,
      lr:     2,
      l10n:   'ru',
    }.inject("") {|acc, (key, val)| "#{acc}&#{key}=#{val}" }

    url = "#{api_url}?#{params}"

    response = TestSeo.agent.get url
    response.search('//url').map(&:text)
  end

  def self.scrape_google(query)
    encoded_query = URI::encode(query)
    api_url = "https://www.googleapis.com/customsearch/v1"
    params = {
      cx:   GOOGLE_ENGINE_ID,
      key:  GOOGLE_API_KEY,
      q:    encoded_query,
      hl:   'ru',
      num:  10,
    }.inject("") {|acc, (key, val)| "#{acc}&#{key}=#{val}" }

    url = "#{api_url}?#{params}"

    response = TestSeo.agent.get url
    response = JSON.parse response.body
    links = response["items"].map { |i| i['link'] }
  end
end
