RSpec.describe Bobross do
  it "has a version number" do
    expect(Bobross::VERSION).not_to be nil
  end

  it "creates a random account" do
    a = Bobross::Account.random
    expect(a.name.nil?).to eq(false)
  end

  it "creates a random assignment" do
    a = Assignment.random
    expect(a.name.nil?).to eq(false)
  end

  it "creates  a random course" do
    a = Course.random
    expect(a.name.nil?).to eq(false)
  end

  it "creates a random section" do
    a = Section.random
    expect(a.name.nil?).to eq(false)
  end

  it "creates a random user" do
    a = User.random
    expect(a.name.nil?).to eq(false)
  end

end
