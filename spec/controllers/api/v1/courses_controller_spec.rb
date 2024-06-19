# spec/controllers/api/v1/courses_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::CoursesController, type: :controller do
  let(:valid_attributes) do
    {
      name: 'Mathematics',
      tutors_attributes: [
        { name: 'John Doe' },
        { name: 'Jane Smith' }
      ]
    }
  end

  let(:invalid_attributes) do
    {
      name: '',
      tutors_attributes: [
        { name: 'John Doe' },
        { name: 'Jane Smith' }
      ]
    }
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:create_course) { post :create, params: { course: valid_attributes } }

      it 'returns success response' do
        create_course
        expect(response).to have_http_status(:created)
      end

      it 'creates a new Course with tutors' do
        expect do
          create_course
        end.to change(Course, :count).by(1).and change(Tutor, :count).by(2)
        expect(success_response['name']).to eq('Mathematics')
        expect(success_response['tutors'].size).to eq(2)
        expect(success_response['tutors'].first['name']).to eq('John Doe')
      end
    end

    context 'with invalid parameters' do
      let(:create_course) { post :create, params: { course: invalid_attributes } }

      it 'returns unsuccess response' do
        create_course
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create a new Course' do
        expect do
          create_course
        end.to change(Course, :count).by(0)

        expect(json['errors']['name']).to include("can't be blank")
      end
    end
  end

  describe 'GET #index' do
    context 'when records are present' do
      before do
        maths = create(:course, name: 'Mathematics')
        science = create(:course, name: 'Science')
        create(:tutor, course: maths, name: 'John Doe')
        create(:tutor, course: science, name: 'Jane Smith')

        get :index
      end

      it 'returns success response' do
        expect(response).to be_successful
      end

      it 'returns list of courses along with its tutors' do
        expect(success_response.size).to eq(2)
        expect(success_response.first['tutors'].size).to eq(1)
        expect(success_response.first['tutors'].first['name']).to eq('John Doe')
      end
    end

    context 'when records are not present' do
      before do
        get :index
      end

      it 'returns success response' do
        expect(response).to be_successful
      end

      it 'returns empty array' do
        expect(success_response.size).to eq(0)
      end
    end
  end
end
