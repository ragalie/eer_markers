module EerMarkers
  class Base
    attr_reader :filename
    attr_accessor :rows

    def initialize(filename)
      @filename = filename
      @rows = []
    end

    def perform
      read
      write
    end

    def write
      Dir.mkdir(directory_name) unless Dir.exists?(directory_name)

      tsv = CSV.open("#{directory_name}/#{File.basename(filename)}", "w", col_sep: "\t")
      tsv << ["T", "=", "[..."]

      rows.each do |row|
        end_value = row == rows.last ? "];" : ";..."
        row[3] = row[3].to_s + end_value
        tsv << row
      end

      tsv.close
    end

    private

    def directory_name
      self.class.name.split("::").last.downcase
    end
  end
end
