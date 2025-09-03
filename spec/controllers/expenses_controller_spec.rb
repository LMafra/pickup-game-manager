require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  fixtures :expenses, :incomes, :matches

  let(:valid_attributes) {
    { type: 'Basic', description: 'Test expense', unit_value: 100.0, quantity: 1, date: Date.today }
  }

  let(:invalid_attributes) {
    { type: '', description: '', unit_value: nil, quantity: nil, date: nil }
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
      expense = expenses(:food)
      get :show, params: { id: expense.to_param }, session: valid_session
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
      expense = expenses(:food)
      get :edit, params: { id: expense.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Expense" do
        expect {
          post :create, params: { expense: valid_attributes }, session: valid_session
        }.to change(Expense, :count).by(1)
      end

      it "redirects to the created expense" do
        post :create, params: { expense: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Expense.last)
      end
    end

    context "with invalid params" do
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post :create, params: { expense: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { type: 'Intermediary', description: 'Updated expense', unit_value: 200.0, quantity: 2, date: Date.today - 1 }
      }

      it "updates the requested expense" do
        expense = expenses(:food)
        put :update, params: { id: expense.to_param, expense: new_attributes }, session: valid_session
        expense.reload
        expect(expense.type).to eq('Intermediary')
        expect(expense.description).to eq('Updated expense')
        expect(expense.unit_value).to eq(200.0)
        expect(expense.quantity).to eq(2)
        expect(expense.date).to eq(Date.today - 1)
      end

      it "redirects to the expense" do
        expense = expenses(:food)
        put :update, params: { id: expense.to_param, expense: new_attributes }, session: valid_session
        expect(response).to have_http_status(:see_other)
        expect(response).to redirect_to(expense)
      end
    end

    context "with invalid params" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        expense = expenses(:food)
        put :update, params: { id: expense.to_param, expense: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested expense" do
      expense = expenses(:food)
      expect {
        delete :destroy, params: { id: expense.to_param }, session: valid_session
      }.to change(Expense, :count).by(-1)
    end

    it "redirects to the expenses list" do
      expense = expenses(:food)
      delete :destroy, params: { id: expense.to_param }, session: valid_session
      expect(response).to have_http_status(:see_other)
      expect(response).to redirect_to(expenses_path)
    end
  end
end
