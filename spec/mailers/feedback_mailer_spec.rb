require "spec_helper"

describe FeedbackMailer do
  describe "user_feedback" do
    let(:mail) { FeedbackMailer.user_feedback }

    it "renders the headers" do
      mail.subject.should eq("User feedback")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
