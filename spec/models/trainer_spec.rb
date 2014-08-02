require 'spec_helper'

describe Trainer do

  it "is valid with email, and password" do
    trainer = Trainer.new(email: "foo@bar.com", password: "foobarbaz")
    expect(trainer).to be_valid
  end

  it "is invalid without an email" do
    trainer = Trainer.new(email: "", password: "foobarbaz")
    expect(trainer).to_not be_valid
  end

  it "is invalid without a password" do
    trainer = Trainer.new(email: "foobar@baz.com", password: "")
    expect(trainer).to_not be_valid

  end
end

