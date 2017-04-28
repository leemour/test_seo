class TestSeo::Exporter
  def initialize(links)
    @links = links
  end

  def to_csv
    require 'csv'

    file = TestSeo.root.join "public", "links.csv"
    CSV.open file, "w" do |csv|
      csv << %w{
        URL
        ТИЦ
        Alexa
      }

      @links.each do |link|
        csv << [
          link[:url],
          link[:tyc],
          link[:alexa],
        ]
      end
    end
    puts "Экспорт в CSV заврешен. Файл - #{file}"
  end
end
