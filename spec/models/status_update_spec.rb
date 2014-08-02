require 'spec_helper'

describe StatusUpdate do

  it "has a valid factory" do
    expect(build(:status_update)).to be_valid
  end

  it "is invalid without phase, entry date, total weight, and body fat pct" do
    status_update = build(:status_update, entry_date:   nil,
                                          total_weight: nil, 
                                          phase:        nil,
                                          body_fat_pct: nil
                                     )
    expect(status_update).to_not be_valid
  end

  it "is invalid without a client" do
    status_update = build(:status_update, client: nil)
    expect(status_update).to_not be_valid
  end

end
