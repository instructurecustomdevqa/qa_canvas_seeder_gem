
class CanvasTerm < CanvasObject

  attr_reader :name, :uid, :sis_id, :term_start, :term_end, :student_acc_start, :student_acc_end, :teacher_acc_start, :teacher_acc_end, :ta_acc_start, :ta_acc_end, :designer_acc_start, :designer_acc_end

  def to_s
    string = "#{uid}, #{name}, #{sis_id}, #{term_start}, #{term_end}, #{student_acc_start}, #{student_acc_end}, #{teacher_acc_start}, #{teacher_acc_end}, #{ta_acc_start}, #{ta_acc_end}, #{designer_acc_start}, #{designer_acc_end}"
  end

  def to_csv
    row = [uid, name, sis_id, term_start, term_end, student_acc_start, student_acc_end, teacher_acc_start, teacher_acc_end, ta_acc_start, ta_acc_end, designer_acc_start, designer_acc_end]
  end

  # future relase: Make fields reuired by canvas required here
  def initialize(opts = {})
    @name = opts[:name] if opts[:name]
    @uid = opts[:uid] if opts[:uid]
    @sis_id = opts[:sis] if opts[:sis]
    @term_start = opts[:term_start] if opts[:term_start]
    @term_end = opt[:term_end] if opts[:term_end]
    @student_acc_start = opt[:student_access_start] if opts[:student_access_start]
    @student_acc_end = opt[:student_access_end] if opts[:student_access_end]
    @teacher_acc_start = opt[:teacher_access_start] if opts[:teacher_access_start]
    @teacher_acc_end = opt[:teacher_access_end] if opts[:teacher_access_end]
    @ta_acc_start = opt[:ta_access_start] if opts[:ta_access_start]
    @ta_acc_end = opt[:ta_access_end] if opts[:ta_access_end]
    @designer_acc_start = opt[:designer_access_start] if opts[:designer_access_start]
    @designer_acc_end = opt[:designer_access_end] if opts[:designer_access_end]
  end

  def self.random
    a = Forgery('lorem_ipsum').words(6)
    id_rand = rand(10_000)
    CanvasTerm.new(
      {
        name: a,
        uid: "#{a}-#{id_rand}",
        sis_id: id_rand,
        term_start: Forgery('date').date
        }
      )
  end

  def self.gen_file(opts = {})
    opts[:rows] ? rows = opts[:rows] : rows = 0
    terms = []
    if(opts[:rows])
      rows.times do |x|
        terms.push(CanvasTerm.random)
      end
    end
    header = %w[term_id name sis_id]
    CSV.open('./terms.csv', 'wb', write_headers: true, headers: header) do |csv|
      terms.each do |term|
        csv << term.to_csv
      end
    end
    return accounts
  end

end
