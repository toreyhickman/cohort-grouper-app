require 'rails_helper'

describe Student do
  describe "associations" do
    it { should have_many :group_participations }
    it { should have_many(:groups).through(:group_participations) }
  end
end
