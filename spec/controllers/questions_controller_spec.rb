require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let (:question) { FactoryGirl.create(:question) }
  let(:user) { create(:user) }

  describe "GET #index" do
    before { get :index }

    it 'load all questiions' do
      questions = FactoryGirl.create_list(:question, 3)
      #get :index
      expect(assigns(:questions)).to eq questions
    end

    it 'renders index template' do
      #get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do

    before { get :show, id: question}

    it 'loads question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders show template' do

      expect(response).to render_template :show
    end

    it 'builds new attachment for answer' do
      expect(assigns(:answer).attachments.first).to be_a_new(Attachment)
    end

  end

  describe "GET #new" do

    before do
      login(user)

      get :new
    end


    it 'assigns new Question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'builds new attachment for question' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it 'renders new template' do
      expect(response).to render_template :new
    end

  end

  describe "GET #edit" do
    before do
      login(user)
      get :edit, id: question
    end

    it 'edits Question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders edit template' do
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    before { login(user) }
    context 'valid' do
      it 'saves new questions in DB' do
        expect { post :create,
                      question: FactoryGirl.attributes_for(:question) }.to change(Question, :count).by(1)
        end
        it 'redirects to show' do
          post :create, question: FactoryGirl.attributes_for(:question)
          expect(response).to redirect_to question_path(assigns(:question))
        end
    end

    context 'invalid' do
      it 'does not save new questions in DB' do
        expect { post :create,
                      question: FactoryGirl.attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it 'renders show template' do
        post :create, question: FactoryGirl.attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    before { login(user) }

    context 'valid' do
      before { patch :update, id: question, question: {title: 'new title', body: 'new body'} }
      it 'changes question' do

        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirects to show' do
        expect(response).to redirect_to question
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      login(user)
      question
    end
    context 'author deletes own question' do
      let!(:question) { create(:question, user: user)}
      it 'deletes question from DB' do
        expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
      end
    # it 'deletes question from DB' do
    #   expect {delete :destroy, id: question }.to change(Question, :count).by(-1)
    # end
    it 'does not deletes question from DB' do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end
  end

  end
  end