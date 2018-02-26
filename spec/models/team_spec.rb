require 'rails_helper'

RSpec.describe Team, type: :model do
  describe Team do

    before do
      Team.destroy_all
      @team = Team.create!(name: "Marketing")
      ["Abe", "Bailey", "Carla"].each { |employee| @team.employees.build(name: employee, assignable: true) }
    end

    it "can create a team" do
      expect(@team.name). to eq("Marketing")
    end

    it "does not have any preferred workdays by default" do
      expect(@team.workday_prefs).to eq('0,0,0,0,0,0,0')
    end

    it "can be associated with multiple employees" do
      expect(@team.employees.length).to eq(3)
    end

    it "can have preferred workdays" do
      @team.update!(workday_prefs: '0,1,0,1,0,1,0')
      expect(@team.workday_prefs_values.include?(0)).to eq(false)
      expect(@team.workday_prefs_values.include?(1)).to eq(true)
      expect(@team.workday_prefs_values.include?(2)).to eq(false)
      expect(@team.workday_prefs_values.include?(3)).to eq(true)
      expect(@team.workday_prefs_values.include?(4)).to eq(false)
      expect(@team.workday_prefs_values.include?(5)).to eq(true)
      expect(@team.workday_prefs_values.include?(6)).to eq(false)
    end

  end
end
