module EerMarkers
  class V1 < Base
    def read
      tsv = CSV.open(filename, "r", col_sep: "\t")
      tsv.each_with_index do |row, idx|
        next if idx == 0
        next if idx == 4
        next if idx == 8
        next if idx >= 10

        row[3].gsub!(/;\.\.\.$/, "").gsub(/\];/, "")

        rows << row
      end

      tsv.close
    end
  end
end
