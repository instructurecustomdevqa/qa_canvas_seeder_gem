
class CanvasTerm < CanvasObject

  attr_reader :name, :integration_id, :term_id, :start_date, :end_date, :status
  attr_writer :end_date

  def to_s
    string = "#{integration_id}, #{name}, #{term_id}, #{status}, #{start_date}, #{end_date}"
  end

  def to_csv
    row = [integration_id, name, term_id, status, start_date, end_date]
  end

  # future relase: Make fields reuired by canvas required here
  def initialize(opts = {})
    @name = opts[:name] if opts[:name]
    @integration_id = opts[:integration_id] if opts[:integration_id]
    @term_id = opts[:term_id] if opts[:term_id]
    @start_date = opts[:start_date] if opts[:start_date]
    @end_date = opts[:end_date] if opts[:end_date]
    @status = opts[:status] if opts[:status]
  end

  def self.random
    a = "#{Faker::Company.name} #{Faker::Company.industry}, #{Faker::Address.country}"
    id_rand = rand(100_000)
    duration = rand(200)
    rndTerm = CanvasTerm.new(
      {
        name: a,
        integration_id: "#{a}-#{id_rand}",
        term_id: "#{a}-#{id_rand}",
        start_date: Faker::Date.between(from: (Date.today - 7.days), to: (Date.today + 6.months)),
        status: "active"
        }
      )
    rndTerm.end_date = Faker::Date.between(from: rndTerm.start_date, to: (rndTerm.start_date + duration.days))
    return rndTerm
  end

  def self.get_csv_headers
    header = %w[integration_id name term_id status start_date end_date]
    return header
  end

end
