require 'rails_helper'

RSpec.describe IncomesController, type: :controller do
  fixtures :incomes, :expenses, :matches

  let(:valid_attributes) {
    { type: 'daily', unit_value: 20.0, date: Date.today }
  }

  let(:invalid_attributes) {
    { type: '', unit_value: nil, date: nil }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      income = Income.create! valid_attributes
      get :show, params: { id: income.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      income = Income.create! valid_attributes
      get :edit, params: { id: income.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Income" do
        expect {
          post :create, params: { income: valid_attributes }, session: valid_session
        }.to change(Income, :count).by(1)
      end

      it "redirects to the created income" do
        post :create, params: { income: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Income.last)
      end
    end

    context "with invalid params" do
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post :create, params: { income: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { type: 'monthly', unit_value: 50.0, date: Date.today - 1 }
      }

      it "updates the requested income" do
        income = Income.create! valid_attributes
        put :update, params: { id: income.to_param, income: new_attributes }, session: valid_session
        income.reload
        expect(income.type).to eq('monthly')
        expect(income.unit_value).to eq(50.0)
        expect(income.date).to eq(Date.today - 1)
      end

      it "redirects to the income" do
        income = Income.create! valid_attributes
        put :update, params: { id: income.to_param, income: new_attributes }, session: valid_session
        expect(response).to have_http_status(:see_other)
        expect(response).to redirect_to(income)
      end
    end

    context "with invalid params" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        income = Income.create! valid_attributes
        put :update, params: { id: income.to_param, income: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested income" do
      income = Income.create! valid_attributes
      expect {
        delete :destroy, params: { id: income.to_param }, session: valid_session
      }.to change(Income, :count).by(-1)
    end

    it "redirects to the incomes list" do
      income = Income.create! valid_attributes
      delete :destroy, params: { id: income.to_param }, session: valid_session
      expect(response).to have_http_status(:see_other)
      expect(response).to redirect_to(incomes_path)
    end
  end
end
