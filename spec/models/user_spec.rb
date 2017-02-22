require 'rails_helper'

RSpec.describe User, type: :model do
    let(:user) { create(:user) }

    describe 'attributes' do
        it 'should have name and email attributes' do
            expect(user).to have_attributes(name: user.name, email: user.email)
        end

        it 'responds to role' do
            expect(user).to respond_to(:role)
        end
    end
end
