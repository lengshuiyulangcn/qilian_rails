require 'rails_helper' 
describe EventsController do
  describe 'test for all user roles' do
    let(:admin_user) { FactoryGirl.build(:admin) }
    let(:normal_user) {  FactoryGirl.build(:gyorou) }
    let(:teacher_user)  { FactoryGirl.build(:teacher) }
    let(:comming_event)  { FactoryGirl.create(:comming_event) }
    let(:comming_event_params)  { FactoryGirl.attributes_for(:comming_event) }
    let(:comming_event_params_2)  { FactoryGirl.attributes_for(:comming_event_2) }
    let(:held_event)  { FactoryGirl.create(:held_event) }
    context 'when the current user is non-login user' do
      before do
        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
        allow(controller).to receive(:current_user).and_return(nil)
      end
        it 'is expected not to access index page' do
          get :index
          expect(response.status).to eq 302 
        end
        it 'is expected not to access show page' do
          get :show, id: comming_event.id
          expect(response.status).to eq 302 
        end
        it 'is expected not to create event' do
          post :create, event: comming_event_params
          expect(assigns(:event)).to eq nil
        end
        it 'is expected not to update event' do
          patch :update, id: comming_event.id, event: comming_event_params_2
          expect(assigns(:event)).to eq nil
        end
        it 'is expected not to delete event' do
          expect(Event.all).to include comming_event 
          delete :destroy, id: comming_event.id
          expect(Event.all).to include comming_event 
        end
        it 'is expected to be able to see comming event list' do
          get :list
          expect(response.status).to eq 200
          expect(assigns(:events)).to include comming_event
          expect(assigns(:events)).not_to include held_event 
        end
        it 'is expected to be able to see event detail' do
          get :detail, id: comming_event.id
          expect(response.status).to eq 200
        end
        context 'users are not able to apply for event' do
          before do
            request.env["HTTP_REFERER"] = '/'
          end
          it 'is expected to not be able to apply for event' do
            post :apply, event_id: comming_event.id
            expect(response.status).to eq 302 
          end
        end
    end
    context 'when the current user is normal user' do
      before do
        allow(request.env['warden']).to receive(:authenticate!).and_return(normal_user)
        allow(controller).to receive(:current_user).and_return normal_user
      end
      context 'normal user can not see the event and the event index' do
        it 'is expected not to access index page' do
          get :index
          expect(response.status).to eq 302 
        end
        it 'is expected not to access show page' do
          get :show, id: comming_event.id
          expect(response.status).to eq 302 
        end
        it 'is expected not to create event' do
          post :create, event: comming_event_params
          expect(assigns(:event)).to eq nil
        end
        it 'is expected not to update event' do
          patch :update, id: comming_event.id, event: comming_event_params_2
          expect(assigns(:event)).to eq nil
        end
        it 'is expected not to delete event' do
          expect(Event.all).to include comming_event 
          delete :destroy, id: comming_event.id
          expect(Event.all).to include comming_event 
        end
        it 'is expected to be able to see comming event list' do
          get :list
          expect(response.status).to eq 200
          expect(assigns(:events)).to include comming_event
          expect(assigns(:events)).not_to include held_event 
        end
        it 'is expected to be able to see event detail' do
          get :detail, id: comming_event.id
          expect(response.status).to eq 200
        end
        context 'users are able to apply for event' do
          before do
            allow(EventMessage).to receive_message_chain(:apply, :deliver)
            request.env["HTTP_REFERER"] = '/'
          end
          it 'is expected be able to apply for event' do
            post :apply, event_id: comming_event.id
            expect(Event.find(comming_event.id).users).to include normal_user
            post :apply, event_id: comming_event.id
            expect(Event.find(comming_event.id).users.length).to eq 1 
          end
        end
      end
    end
    context 'when the current user is teacher user' do
      before do
        allow(controller).to receive(:current_user).and_return teacher_user
      end
      context 'teacher user can see the event and the event list' do
        it 'is expected to be able to create event' do
          post :create, event: comming_event_params_2
          expect(Event.last.content).to eq comming_event_params_2[:content] 
        end
        it 'is expected not to update event' do
          patch :update, id: comming_event.id, event: comming_event_params_2
          expect(Event.find(comming_event.id).content).to eq comming_event_params_2[:content] 
        end
        it 'is expected not to delete event' do
          expect(Event.all).to include comming_event 
          delete :destroy, id: comming_event.id
          expect(Event.all).not_to include comming_event 
        end
      end
    end
  end
end

