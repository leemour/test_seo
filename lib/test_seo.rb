module TestSeo
  require_relative 'test_seo/scraper'
  require_relative 'test_seo/rank_calculator'
  require_relative 'test_seo/exporter'

  USER_AGENTS = {
    firefox_android: "Mozilla/5.0 (Android 5.1; Mobile; rv:41.0) " +
      "Gecko/41.0 Firefox/41.0",
    chrome_win7: "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 " +
      "(KHTML, like Gecko) Chrome/47.0.2526.80 Safari/537.36",
    safari_macos: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) " +
      "AppleWebKit/601.2.7 (KHTML, like Gecko) Version/9.0.1 Safari/601.2.7",
    firefox_win8: "Mozilla/5.0 (Windows NT 6.3; WOW64; rv:42.0) " +
      "Gecko/20100101 Firefox/42.0"
  }

  def self.top_links_for(query, search_engine = 'yandex')
    links = Scraper.public_send("scrape_#{search_engine}", query)
    ranked_links = RankCalculator.rank(links)
    Exporter.new(ranked_links).to_csv
  end

  def self.root
    return @root if @root
    @root = File.expand_path File.dirname __dir__
    class << @root
      def join(*args)
        File.join self, *args
      end
    end
    @root
  end

  def self.agent
    @agent ||= Mechanize.new do |agent|
      # Choose random User Agent to avoid spam filters
      agent.user_agent = USER_AGENTS[USER_AGENTS.keys.sample]
    end
  end
end
