require 'rails_helper'

RSpec.describe Doctor, type: :model do
  describe "accessors" do
  	let(:doctor) { create(:doctor) }
  	it "responds to id" do
  		expect(doctor.id).to_not be_nil
  	end
  	
  	it "responds to first_name" do
  		expect(doctor.first_name).to_not be_nil
  	end

  	it "responds to last_name" do
  		expect(doctor.last_name).to_not be_nil
  	end

  	it "responds to created_at" do
  		expect(doctor.created_at).to_not be_nil
  	end

  	it "responds to created_by" do
  		expect(doctor.created_by).to_not be_nil
  	end

  	it "responds to updated_at" do
  		expect(doctor.updated_at).to_not be_nil
  	end

  	it "responds to updated_by" do
  		expect(doctor.updated_by).to_not be_nil
  	end
  end

  describe "validations" do
    describe "first_name" do
      context "with first_name present" do
        let(:doctor) { build(:doctor, first_name: "Ted", last_name: "Meowmers") }
        it "is valid" do
          expect(doctor.valid?).to be true
        end
      end

      context "with first_name missing" do
        let(:doctor) { build(:doctor, first_name: nil, last_name: "Felicity") }
        it "is invalid" do
          expect(doctor.valid?).to be false
        end
      end
    end

    describe "last_name" do
      context "with last_name present" do
        let(:doctor) { build(:doctor, first_name: "Ted", last_name: "Dog") }
        it "is valid" do
          expect(doctor.valid?).to be true
        end
      end

      context "with last_name missing" do
        let(:doctor) { build(:doctor, first_name: "Ted", last_name: nil) }
        it "is invalid" do
          expect(doctor.valid?).to be false
        end
      end
    end
  end
end
