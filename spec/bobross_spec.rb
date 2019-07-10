require 'bobross'
include Bobross
RSpec.describe Bobross do
  it "has a version number" do
    expect(Bobross::VERSION).not_to be nil
  end

  it "creates a random account" do
    a = CanvasAccount.random
    expect(a.name.nil?).to eq(false)
  end

  it "creates an account csv" do
    CanvasAccount.gen_file({rows: 200})
    expect(File.exist?("accounts.csv")).to eq(true)
    File.delete("accounts.csv")
  end

  it "creates a random assignment" do
    a = CanvasAssignment.random
    expect(a.name.nil?).to eq(false)
  end

  it "creates an assignment csv" do
    CanvasAssignment.gen_file({rows: 200})
    expect(File.exist? ("assignments.csv")).to eq(true)
    File.delete("assignments.csv")
  end

  it "creates a random course" do
    a = CanvasCourse.random
    expect(a.name.nil?).to eq(false)
  end

  it "creates a course csv" do
    CanvasCourse.gen_file({rows: 200})
    expect(File.exist? ("courses.csv")).to eq(true)
    File.delete("courses.csv")
  end

  it "creates a random section" do
    a = CanvasSection.random
    expect(a.name.nil?).to eq(false)
  end

  it "creates a section csv" do
    CanvasSection.gen_file({rows: 200})
    expect(File.exist? ("sections.csv")).to eq(true)
    File.delete("sections.csv")
  end

  it "creates a random user" do
    a = CanvasUser.random
    expect(a.name.nil?).to eq(false)
  end

  it "creates a user csv" do
    CanvasUser.gen_file({rows: 200})
    expect(File.exist? ("users.csv")).to eq(true)
    File.delete("users.csv")
  end

end
