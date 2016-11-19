require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'find or update settings should be ok' do
    Setting.keys.keys do |key|
      Setting.try((key+'=').to_sym, 100)
      assert Setting.try((key).to_sym) == 100
    end
  end
end
