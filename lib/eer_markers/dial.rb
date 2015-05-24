module EerMarkers
  class Dial
    attr_reader :timing_directory, :dial_directory
    attr_accessor :timing, :dial

    def initialize(timing_directory, dial_directory)
      @timing_directory = timing_directory
      @dial_directory = dial_directory
      @timing = {}
      @dial = {}

      read_timing
      read_dial
      write
    end

    def read_timing
      Dir["#{timing_directory}/*"].each do |filename|
        participant = filename.match(/PEG([0-9]{3})/) && $1
        next unless participant

        timing[participant] = {}

        tsv = CSV.open(filename, "r", col_sep: "\t")
        tsv.each_with_index do |row, idx|
          next unless config["rows"].include?(idx)

          timing[participant][idx] = {start: row[1].to_f.ceil, end: row[2].to_f.floor}
        end
      end
    end

    def read_dial
      raise "Must read timing first" if timing.empty?

      timing.each do |participant, segments|
        puts "Processing #{participant}..."
        filename = "#{dial_directory}/#{participant}.xlsx"
        next unless File.exists?(filename)

        xlsx = RubyXL::Parser.parse(filename).worksheets[0].sheet_data
        segments.each do |segment, start_and_end|
          values = []
          start_and_end[:start].upto(start_and_end[:end]) do |idx|
            values << xlsx[idx][0].value
          end

          dial[segment] ||= {}
          dial[segment][participant] = values
        end
      end
    end

    def write
      Dir.mkdir("dial") unless Dir.exists?("dial")

      dial.each do |segment, participants|
        csv = CSV.open("dial/#{segment}.csv", "w")
        csv << ["Participant", "1st Second", "2nd Second"]

        participants.each do |participant, values|
          csv << [participant] + values
        end

        csv.close
      end
    end

    private

    def config
      @config ||= YAML.load_file(File.expand_path("../../../config/dial.yml", __FILE__))
    end
  end
end
