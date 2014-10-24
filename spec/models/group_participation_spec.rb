require 'rails_helper'

describe GroupParticipation do
  describe "associations" do
    it { should belong_to :group }
  end
end
