
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
    a = "#{Forgery('name').company_name} #{Forgery('name').industry}, #{Forgery('name').location}"
    id_rand = rand(100_000)
    days = rand(200)
    rndTerm = CanvasTerm.new(
      {
        name: a,
        integration_id: "#{a}-#{id_rand}",
        term_id: "#{a}-#{id_rand}",
        start_date: Forgery('date').date,
        status: "active"
        }
      )
    rndTerm.end_date = rndTerm.start_date + days.days if (days.even?)
    return rndTerm
  end

  def self.get_random_collection(qty=0)
    terms = []
    if (qty > 0)
      qty.times do
        terms.push(CanvasTerm.random)
      end
    end
    return terms
  end

  def self.gen_file(opts = {})
    opts[:rows] ? rows = opts[:rows] : rows = 0
    terms = []
    if(opts[:rows])
      rows.times do |x|
        terms.push(CanvasTerm.random)
      end
    end
    header = %w[integration_id name term_id status start_date end_date]
    CSV.open('./terms.csv', 'wb', write_headers: true, headers: header) do |csv|
      terms.each do |term|
        csv << term.to_csv
      end
    end
    return terms
  end

  def self.write_collection_to_file(terms=[])
    if(terms.count > 0)
      header = %w[integration_id name term_id status start_date end_date]
      CSV.open('./terms.csv', 'wb', write_headers: true, headers: header) do |csv|
        terms.each do |term|
          csv << term.to_csv
        end
      end
    end
  end

end
