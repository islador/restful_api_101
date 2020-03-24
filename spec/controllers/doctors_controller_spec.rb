require 'rails_helper'

RSpec.describe DoctorsController, type: :controller do
	describe "#create" do
		context "with valid params" do
			it "creates a doctor" do
				expect(Doctor.count()).to be 0
				post :create, params: {doctor: {first_name: "Ted", last_name: "Doctor"}}
				expect(Doctor.count()).to be 1
			end

			it "returns 201" do
				post :create, params: {doctor: {first_name: "Ted", last_name: "Doctor"}}
				expect(response.status).to be 201
			end
		end

		context "with invalid params" do
			it "does not create a doctor" do
				expect(Doctor.count()).to be 0
				post :create, params: {doctor: {first_name: "Ted"}}
				expect(Doctor.count()).to be 0
			end

			it "returns 422" do
				post :create, params: {doctor: {first_name: "Ted"}}
				expect(response.status).to be 422
			end

			it "returns validation errors" do
				post :create, params: {doctor: {first_name: "Ted"}}
				expect(JSON.parse(response.body)["errors"]).to_not be_empty
			end
		end
	end

	describe "#index" do
		context "with many doctors" do
			let!(:doctor_1) { create(:doctor) }
			let!(:doctor_2) { create(:doctor) }

			it "returns a 200" do
				get :index
				expect(response.status).to be 200
			end

			it "returns doctors" do
				get :index
				expect(JSON.parse(response.body)).to_not be_empty
			end
		end

		context "with no doctors" do
			it "returns a 200" do
				get :index
				expect(response.status).to be 200
			end
			
			it "returns an empty array" do
				get :index
				expect(JSON.parse(response.body)).to be_empty
			end
		end
	end

	describe "#show" do
		context "with a doctor with that ID" do
			let!(:doctor) { create(:doctor) }
			it "returns 200" do
				get :show, params: {id: doctor.id}
				expect(response.status).to be 200
			end

			it "returns the specified doctor" do
				get :show, params: {id: doctor.id}
				expect(JSON.parse(response.body)["id"]).to eq doctor.id
			end
		end

		context "without a doctor by that ID" do
			it "returns 404" do
				get :show, params: {id: 1}
				expect(response.status).to be 404
			end
		end
	end

	describe "#update" do
		context "with existing doctor" do
			let!(:doctor) { create(:doctor) }
			context "with valid params" do
				it "returns 202" do
					put :update, params: {id: doctor.id, doctor: {first_name: "Jeff", last_name: "Alligator"}}
					expect(response.status).to eq 202
				end

				it "modifies the record" do
					put :update, params: {id: doctor.id, doctor: {first_name: "Jeff", last_name: "Alligator"}}
					expect(Doctor.first.first_name).to eq "Jeff" 
				end
			end

			context "with invalid params" do
				it "returns 422" do
					put :update, params: {id: doctor.id, doctor: {last_name: nil}}
					expect(response.status).to eq 422
				end

				it "returns validation errors" do
					put :update, params: {id: doctor.id, doctor: {last_name: nil}}
					expect(JSON.parse(response.body)["errors"]).to_not be_empty
				end

				it "does not modify the record" do
					put :update, params: {id: doctor.id, doctor: {last_name: nil}}
					expect(Doctor.first.last_name).to_not be_nil 
				end
			end
		end

		context "with non-existent doctor" do
			it "returns a 404" do
				put :update, params: {id: 1, doctor: {first_name: "Jeff", last_name: "Meowmix"}}
				expect(response.status).to be 404
			end
		end
	end

	describe "#destroy" do
		context "with a doctor by that ID" do
			let!(:doctor) { create(:doctor) }
			it "deletes the doctor from the database" do
				expect(Doctor.count()).to be 1
				delete :destroy, params: {id: doctor.id}
				expect(Doctor.count()).to be 0
			end

			it "returns 204" do
				delete :destroy, params: {id: doctor.id}
				expect(response.status).to be 204
			end
		end

		context "without a doctor by that ID" do
			it "returns 404" do
				delete :destroy, params: {id: 1}
				expect(response.status).to be 404
			end
		end
	end
end
