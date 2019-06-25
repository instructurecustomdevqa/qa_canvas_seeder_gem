class User < Forgery

  def to_s
    string = ""
  end

  def self.random
    @first_name =Forgery('name').first_name
    @last_name = Forgery('name').last_name
    @uid = Forgery('bank_account').iban
  end
end
