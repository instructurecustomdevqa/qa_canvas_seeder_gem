class AssignmentSubmission < Forgery

  def to_s
    string = ''
  end

  def to_csv
    row = []
  end

  def initialize(opts = {})
  end

  def self.random
  end

  def self.get_random_collection(qty=0)
    # submissions = []
    # if (qty > 0)
    #   qty.times do
    #     submissions.push(AssignmentSubmission.random)
    #   end
    # end
    # return submissions
  end

  def self.write_collection_to_file(submissions=[])
    # if(submissions.count > 0)
    #   header = %w[submission_id  assignment]
    #   CSV.open('./submissions.csv', 'wb', write_headers: true, headers: header) do |csv|
    #     submissions.each do |submission|
    #       csv << submission.to_csv
    #     end
    #   end
    # end
  end

end
