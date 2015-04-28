module EerMarkers
  class V2 < Base
    def read
      tsv = CSV.open(filename, "r", col_sep: "\t")
      tsv.shift

      first_row = tsv.shift
      tsv.shift
      second_row = tsv.shift

      rows << [first_row[0], first_row[1], second_row[2], second_row[2].to_f - first_row[1].to_f]

      first_row = tsv.shift
      tsv.shift
      second_row = tsv.shift

      rows << [first_row[0], first_row[1], second_row[2], second_row[2].to_f - first_row[1].to_f]

      tsv.close
    end
  end
end
