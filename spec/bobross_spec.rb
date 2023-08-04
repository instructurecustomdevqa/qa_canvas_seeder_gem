require 'bobross'
include Bobross
RSpec.describe Bobross do
  it 'has a version number' do
    expect(Bobross::VERSION).not_to be nil
  end

  it 'creates a random account' do
    a = CanvasAccount.random
    expect(a.name.nil?).to eq(false)
  end

  it 'creates a random assignment' do
    a = CanvasAssignment.random
    expect(a.name.nil?).to eq(false)
  end

  it 'creates a random course' do
    a = CanvasCourse.random
    expect(a.name.nil?).to eq(false)
  end

  it 'creates a random section' do
    a = CanvasSection.random
    expect(a.name.nil?).to eq(false)
  end

  it 'creates a random user' do
    a = CanvasUser.random
    expect(a.name.nil?).to eq(false)
  end
end
