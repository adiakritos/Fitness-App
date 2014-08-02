require 'spec_helper'

describe Client do
 
  it "is valid with a first and last name" do
    client = build(:client, firstname: "foo", lastname: "bar")
    expect(client).to be_valid
  end

  it "is invalid without a first name" do
    client = build(:client, firstname: "", lastname: "bar")
    expect(client).to_not be_valid
  end

  it 'is invalid if email is already taken' do
    trainer = create(:trainer)
    client1 = build(:client, trainer: trainer, email: "foobar@baz.com")
    client2 = build(:client, trainer: trainer, email: "foobar@baz.com")
    client1.save
    client2.save
    expect(client2).to_not be_valid
  end

  it "is invalid without a trainer" do
    client = build(:client, trainer: nil)
    expect(client).to_not be_valid
  end

  it "is valid with a trainer" do
    trainer = build(:trainer)
    trainer.save
    client = build(:client, trainer: trainer)
    expect(client).to be_valid
  end

end
