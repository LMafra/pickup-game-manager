require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  fixtures :payments, :athletes, :matches

  let(:valid_attributes) {
    {
      date: Date.today,
      status: 'pending',
      athlete_id: athletes(:john_doe).id,
      match_id: matches(:weekend_game).id,
      description: 'Test payment',
      amount: 15.0
    }
  }

  let(:invalid_attributes) {
    {
      date: nil,
      status: '',
      athlete_id: nil,
      match_id: nil,
      description: '',
      amount: nil
    }
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
      payment = payments(:weekend_payment)
      get :show, params: { id: payment.to_param }, session: valid_session
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
      payment = payments(:weekend_payment)
      get :edit, params: { id: payment.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Payment" do
        expect {
          post :create, params: { payment: valid_attributes }, session: valid_session
        }.to change(Payment, :count).by(1)
      end

      it "redirects to the created payment" do
        post :create, params: { payment: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Payment.last)
      end
    end

    context "with invalid params" do
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post :create, params: { payment: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          date: Date.today + 1,
          status: 'paid',
          amount: 20.0,
          description: 'Updated payment'
        }
      }

      it "updates the requested payment" do
        payment = payments(:weekend_payment)
        put :update, params: { id: payment.to_param, payment: new_attributes }, session: valid_session
        payment.reload
        expect(payment.date).to eq(Date.today + 1)
        expect(payment.status).to eq('paid')
        expect(payment.amount).to eq(20.0)
        expect(payment.description).to eq('Updated payment')
      end

      it "redirects to the payment" do
        payment = payments(:weekend_payment)
        put :update, params: { id: payment.to_param, payment: new_attributes }, session: valid_session
        expect(response).to have_http_status(:see_other)
        expect(response).to redirect_to(payment)
      end
    end

    context "with invalid params" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        payment = payments(:weekend_payment)
        put :update, params: { id: payment.to_param, payment: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested payment" do
      payment = payments(:weekend_payment)
      expect {
        delete :destroy, params: { id: payment.to_param }, session: valid_session
      }.to change(Payment, :count).by(-1)
    end

    it "redirects to the payments list" do
      payment = payments(:weekend_payment)
      delete :destroy, params: { id: payment.to_param }, session: valid_session
      expect(response).to have_http_status(:see_other)
      expect(response).to redirect_to(payments_path)
    end
  end
end
