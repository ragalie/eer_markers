module EerMarkers
  class V1 < Base
    def read
      tsv = CSV.open(filename, "r", col_sep: "\t")
      tsv.each_with_index do |row, idx|
        next unless config["rows"].include?(idx)
        row[3].gsub!(/;\.\.\.$/, "").gsub(/\];/, "")

        rows << row
      end

      tsv.close
    end

    def config
      @config ||= YAML.load_file(File.expand_path("../../../config/v1.yml", __FILE__))
    end
  end
end
